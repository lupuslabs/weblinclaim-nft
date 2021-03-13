const HDWalletProvider = require("truffle-hdwallet-provider");
const network = process.argv[2] ?? 'rinkeby';
const config = require('./config.' + network + '.js');
const web3 = require("web3");
var readlineSync = require('readline-sync');

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
    config.abi,
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

    result = await nftContract.methods
        .balanceOf('0xDA54196121247511797cEcF378A78a6052992586')
        .call();
    console.log("R=", result);//*/

    process.exit();
})();