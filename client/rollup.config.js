import resolve from 'rollup-plugin-node-resolve';

import commonjs from 'rollup-plugin-commonjs';

import builtins from 'rollup-plugin-node-builtins';

import globals from 'rollup-plugin-node-globals';

//import closure from 'rollup-plugin-closure-compiler-js';

export default {

  input: 'static/javascripts/ethereum.js',

  output: {

      file: 'static/javascripts/ethereum.bundle.js',

      format: 'es',

      browser: true

    },

  plugins: [

    globals(),

    builtins(),

    resolve({

      preferBuiltins: false,

      browser: true,

      // pass custom options to the resolve plugin

      customResolveOptions: {

        moduleDirectory: 'node_modules'

      }

    }),

    commonjs()

    // closure({

    //   compilationLevel: 'WHITESPACE',

    //   languageIn: 'ES6',

    //   languageOut: 'ES6'

    // })

  ]

};