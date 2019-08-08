var balance = async (web3, acct) => { 
let bal = await web3.eth.getBalance(acct); 
    let res = web3.utils.fromWei(bal, 'ether');
    return parseInt(res);
   //return web3.fromWei(web3.eth.getBalance(acct),'ether').toNumber();};

};

module.exports.balance = balance;

