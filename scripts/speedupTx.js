const {config, contract, abi} = require('./ContractWalletProvider.js');

(async () => {

    let account = config.ownerAddress; //'0xBFe63Cc83FE538DCa77c613A4dFAd126a5b052Df';
    let transactionCount = await web3Instance.eth.getTransactionCount(account);
    let transactionCountIncludingPending = await web3Instance.eth.getTransactionCount(account, "pending");
    console.log(transactionCount, transactionCountIncludingPending);


    web3Instance.eth.sendTransaction({
        from: config.ownerAddress,
        gasPrice: 200e9,
        gas: "21000",
        to: config.ownerAddress,
        value: "0",
        data: "",
        nonce: 8,
    }, '').then(console.log);

//    process.exit();
})();