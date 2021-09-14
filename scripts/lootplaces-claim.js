const HDWalletProvider = require("truffle-hdwallet-provider");
const web3 = require('web3');
const { config, contract, abi } = require('./LootPlacesContractWalletProvider.js');

const tokenIdStart = 400;
const tokenIdCount = 100;

const mint = (id, nonce) =>
{

    const txOptions = {
        from: config.ownerAddress,
        gasPrice: web3.utils.toWei("50", 'gwei'),
        gas: 200000,
        value: 1e16,
        nonce: nonce,
    }

    console.log(`Minting ${id}`, txOptions);

    const provider = new HDWalletProvider(config.mnemonic, config.providerUrl);
    const web3Instance = new web3(provider);
    const nftContract = new web3Instance.eth.Contract(
        abi,
        config.contractAddress,
        { gasLimit: "1000000" }
    );

    tx = nftContract.methods
        .claim(id)
        .send(txOptions)
        .then((result) => { console.log(`Minted ${id}: ${result.transactionHash}`); })
        .catch((err) => { console.log(`Failed ${id}:`, err); });
}


(async () =>
{

    const provider = new HDWalletProvider(config.mnemonic, config.providerUrl);
    const web3Instance = new web3(provider);

    let nonce = await web3Instance.eth.getTransactionCount(
        config.ownerAddress
    );

    for (let i = 0; i < tokenIdCount; i++) {
        let tokenId = tokenIdStart + i;
        mint(tokenId, nonce);
        nonce++;

        await new Promise(resolve => setTimeout(resolve, 2000));
    }

})();
