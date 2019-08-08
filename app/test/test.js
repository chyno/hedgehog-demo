var assert = require("assert");
var Web3 = require("web3");
var getDataObj = require("./fakeds");
var utils= require("../js/utils");

const WalletSubprovider = require("ethereumjs-wallet/provider-engine");
const ProviderEngine = require("web3-provider-engine");
const { Hedgehog, WalletManager, Authentication } = require("@audius/hedgehog");
const userName = "foo";
const password = "bar";

const dbObj = getDataObj();
const setAuthFn = async obj => dbObj.createIfNotExists(obj.lookupKey, obj);
const setUserFn = async obj => dbObj.createIfNotExists(obj.username, obj);
const getFn = async obj => dbObj.readRecord(obj);

describe("Can create fake data", function() {
  xit("get function test ", async function() {
    let fdata = {
      foo: {
        username: "foo",
        walletAddress: "0x1f209005dffcfb9b7f956012597bbfa6a9fa54d3"
      },
      "3d68622224c376ff876a2561aba4c5afc2b9b74400e6d136bcb5a0f0a00a1054": {
        iv: "c4cbc2a38a3e2b3c2ae432823d806cea",
        cipherText:
          "3c9a22d9b7fdcc7e429241f8f0a19c7fccd0157a91559d7c98989f37bef943e5de86649bc26d861c7f1ce6178af450987314ca08e3ab577fb42d0ebd03e17935",
        lookupKey:
          "3d68622224c376ff876a2561aba4c5afc2b9b74400e6d136bcb5a0f0a00a1054"
      },
      foo1: {
        username: "foo1",
        walletAddress: "0x9c314a772d0e80c0222b56dbe43432d189cd6cca"
      },
      "932426c36cb447e9bd0524b4307e17371fbada06116208d53ca4ccabecf43d92": {
        iv: "dd7d04c1854c5a65c7abf39d406d2ef7",
        cipherText:
          "142360592fd7230634420c631ceb58697d7af9fa91cac30fe6fad5b9723ee6bdde5baafc101acc0020c520478670c467cfb1e5d111008f396b4713496b46aef3",
        lookupKey:
          "932426c36cb447e9bd0524b4307e17371fbada06116208d53ca4ccabecf43d92"
      }
    };

    dbObj.db = fdata;
    let lookupKey = await WalletManager.createAuthLookupKey(userName, password);
    let data = await getFn({ lookupKey: lookupKey });
    assert.ok(data, "fake data created");

    let lookupKey1 = await WalletManager.createAuthLookupKey(
      userName + "1",
      password + "1"
    );
    let data1 = await getFn({ lookupKey: lookupKey1 });
    assert.ok(data1, "fake data created");
  });
});

describe("web3 and hedgehog", function() {
  let hedgehog = "not set";
  beforeEach(async function() {
    hedgehog = new Hedgehog(getFn, setAuthFn, setUserFn);
  });

  xit("Can create wallet", function() {
    assert.ok(hedgehog, "hedge hog to be defined");
  });

  xit("Can login to hedge hog", async function() {
    let wallet;
    var engine = new ProviderEngine();
    wallet = await hedgehog.signUp(userName, password);

    if (!hedgehog.isLoggedIn()) {
      wallet = await hedgehog.login(userName, password);
    }
    //await hedgehog.signUp(userName + "1", password + "1");
    if (!wallet) {
      wallet = hedgehog.getWallet();
    }

    //const prov = new Web3.providers.HttpProvider("http://localhost:8545");
    engine.addProvider(new WalletSubprovider(wallet));
    //engine.addProvider(prov);
    // data source
    engine.addProvider(
      new RpcSubprovider({
        rpcUrl: "https://localhost:8545"
      })
    );
    engine.start();
    engine.amountToSend(

    )
    assert.ok(wallet, "problem logging into hedge hog");
  });

  xit("can crete web3", async () => {
    const prov = new Web3.providers.HttpProvider("http://localhost:8545");
    const web3 = new Web3(prov);
    const eth = web3.eth;
    let accounts = await eth.getAccounts();
   
    //console.log(accounts);
    assert.ok(accounts.length > 1, "has accounts");
  });

  it("can get value", async () => {
    const prov = new Web3.providers.HttpProvider("http://localhost:8545");
    const web3 = new Web3(prov);
    const eth = web3.eth;
    let accounts = await eth.getAccounts();
    //console.log(accounts);
    let account = accounts[0];
    let ethBal = await utils.balance(web3,account);
    //  let amount = await web3.eth.getBalance(account);
    console.log(ethBal);
    assert.ok(ethBal === 100, "has amount");
  });

  xit("can transer money to wallet", async () => {
    const prov = new Web3.providers.HttpProvider("http://localhost:8545");
    const web3 = new Web3(prov);

    // web3.eth.defaultAccount = 0xADB057708A954f763e7560227510DBB5b2f42022;
    const eth = web3.eth;
    let accounts = await eth.getAccounts();
    const amountToSend = 0.001;
    //console.log(accounts);
    let account = accounts[0];
    let amount = await balance(web3, account);
    console.log(amount);

    assert.ok(amount > 10000000000000000000, "has amount");
  });
});
