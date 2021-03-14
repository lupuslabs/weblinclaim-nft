const {config, contract, abi} = require('./ContractWalletProvider.js');

(async () => {

    let result = await nftContract.methods
        .mintTo(mintTo)
        .send({ from: config.ownerAddress });
    console.log("Minted claim. Transaction: ", result.transactionHash);//*/

    result = await nftContract.methods
        .totalSupply()
        .call();
    console.log("totalSupply = ", result);

    process.exit();
})();

