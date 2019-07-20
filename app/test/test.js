var assert = require('assert');
const { Hedgehog, /*WalletManager, Authentication */ } = require('@audius/hedgehog');

const setAuthFn = async obj =>  new Promise( resolve => { resolve({}); });
const setUserFn = async obj =>  new Promise( resolve => { resolve({}); });
const getFn = async obj =>  new Promise( resolve => { resolve({}); });
/*
firebaseService.createIfNotExists(AUTH_TABLE, obj.lookupKey, obj);
const setUserFn = async obj =>
firebaseService.createIfNotExists(USER_TABLE, obj.username, obj);
const getFn = async obj => firebaseService.readRecordFromFirebase(AUTH_TABLE, obj);
*/
//export const hedgehog = new Hedgehog(getFn, setAuthFn, setUserFn);

describe('Array', function() {
  let  hedgehog;
  beforeEach(function() {
      hedgehog =  new Hedgehog(getFn, setAuthFn, setUserFn);
  });
  
  describe('Add Funds to Wallet', function() {
    it('Can crete wallet', function() {
      assert.ok(hedgehog, "hedge hog to be defines defined");
    });
  });
});