import { compile } from 'google-closure-compiler-js';

/*
 * Copyright 2016 The Closure Compiler Authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

/**
 * @fileoverview Logger for Closure Compiler output.
 */

var ESC = '\x1B';
var COLOR_END = ESC + '[0m';
var COLOR_RED = ESC + '[91m';
var COLOR_GREEN = ESC + '[92m';
var COLOR_YELLOW = ESC + '[93m';

/**
 * @param {string} line to generate prefix for
 * @param {number} charNo to generate prefix at
 * @return {string} prefix for showing a caret
 */
function caretPrefix(line, charNo) {
  return line.substr(0, charNo).replace(/[^\t]/g, ' ');
}

/**
 * @param {!Object} options
 * @param {!Object} output
 * @param {function(string)} logger
 * @return {boolean} Whether this output should fail a compilation.
 */
var logger = function (options, output, logger) {
  logger = logger || console.warn;
  // TODO(samthor): If this file has a sourceMap, then follow it back out of the rabbit hole.
  function fileFor(file) {
    if (!file) {
      return null;
    }

    // Filenames are the same across source and externs, so prefer source files.
    var _arr = [options.jsCode, options.externs];
    for (var _i = 0; _i < _arr.length; _i++) {
      var files = _arr[_i];
      if (!files) {
        continue;
      }

      var _iteratorNormalCompletion = true;
      var _didIteratorError = false;
      var _iteratorError = undefined;

      try {
        for (var _iterator = files[Symbol.iterator](), _step; !(_iteratorNormalCompletion = (_step = _iterator.next()).done); _iteratorNormalCompletion = true) {
          var cand = _step.value;

          if (cand.path == file) {
            return cand;
          }
        }
      } catch (err) {
        _didIteratorError = true;
        _iteratorError = err;
      } finally {
        try {
          if (!_iteratorNormalCompletion && _iterator.return) {
            _iterator.return();
          }
        } finally {
          if (_didIteratorError) {
            throw _iteratorError;
          }
        }
      }
    }

    return null;
  }

  function writemsg(color, msg) {
    if (!msg.file && msg.lineNo < 0) {
      logger(msg.type);
    } else {
      logger(msg.file + ':' + msg.lineNo + ' (' + msg.type + ')');
    }
    logger(msg.description);

    var file = fileFor(msg.file);
    if (file) {
      var lines = file.src.split('\n'); // TODO(samthor): cache this for logger?
      var line = lines[msg.lineNo - 1] || '';
      logger(color + line + COLOR_END);
      logger(COLOR_GREEN + caretPrefix(line, msg.charNo) + '^' + COLOR_END);
    }
    logger('');
  }

  output.warnings.forEach(writemsg.bind(null, COLOR_YELLOW));
  output.errors.forEach(writemsg.bind(null, COLOR_RED));

  return output.errors.length > 0;
}
module.exports = exports['default'];

function closure() {
    var flags = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : {};

    return {
        name: 'closure-compiler-js',
        transformBundle: function transformBundle(code) {
            flags = Object.assign({
                createSourceMap: true,
                processCommonJsModules: true
            }, flags);
            flags.jsCode = [{
                src: code
            }];
            var output = compile(flags);
            if (logger(flags, output)) {
                throw new Error('compilation error, ' + output.errors.length + ' error' + (output.errors.length === 0 || output.errors.length > 1 ? 's' : ''));
            }
            return { code: output.compiledCode, map: output.sourceMap };
        }
    };
}
module.exports = exports['default'];

export default closure;
