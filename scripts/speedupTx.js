const HDWalletProvider = require("truffle-hdwallet-provider");
const network = process.argv[2] ?? 'rinkeby';
const config = require('./config.' + network + '.js');
const web3 = require("web3");
var readlineSync = require('readline-sync');
const abi = require('../build/contracts/WeblinItem.json').abi;


if (config.mnemonic == null) {
    config.mnemonic = readlineSync.question('May I have your mnemonic? ');
}
let provider;
try {
    provider = new HDWalletProvider(config.mnemonic, config.providerUrl);
} catch (e) {
    console.log(e.message);
    process.exit();
}
const web3Instance = new web3(provider);
const nftContract = new web3Instance.eth.Contract(
    abi,
    config.contractAddress,
    {gasLimit: "1000000"}
);

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