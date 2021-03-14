const HDWalletProvider = require("truffle-hdwallet-provider");
const network = process.argv[2] ?? 'rinkeby';
const config = require('./config.' + network + '.js');
const web3 = require("web3");
var readlineSync = require('readline-sync');
let abi;
const fs = require('fs');

if (fs.existsSync('./build/contracts/WeblinItem.json')) {
    abi = require('../build/contracts/WeblinItem.json').abi;
} else {
    abi = [];
    console.log("abi not found");
}

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

module.exports = {config: config, contract: nftContract, abi: abi};