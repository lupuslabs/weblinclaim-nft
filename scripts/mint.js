const {config, contract, abi} = require('./ContractWalletProvider.js');

(async () => {

    /*let result = await contract.methods
        .mintTo(mintTo)
        .send({ from: config.ownerAddress });
    console.log("Minted claim. Transaction: ", result.transactionHash);//*/

    result = await contract.methods
        .totalSupply()
        .call();
    console.log("totalSupply = ", result);

    process.exit();
})();

