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

    let result;
    /*
    result = await nftContract.methods
        .setBaseURI('https://example.com/')
        .send({ from: config.ownerAddress });
    console.log("R=", result);//*/

    /*result = await nftContract.methods
        .baseURI()
        .call();
    console.log("R=", result);//*/


   /* result = await nftContract.methods
        .mint(config.ownerAddress, 1338, "?foo=bar")
        .send( {from: config.ownerAddress} );
    console.log("R=", result);//*/

    result = await nftContract.methods
        .properties(138)
        .call( {from: config.ownerAddress} );
    console.log("R=", result);//*/

    result = await nftContract.methods
        .tokenURI(config.ownerAddress)
        .call( {from: config.ownerAddress} );
    console.log("R=", result);//*/

    process.exit();
})();