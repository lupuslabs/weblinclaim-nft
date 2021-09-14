const HDWalletProvider = require("truffle-hdwallet-provider");
const web3 = require('web3');
const { config, contract, abi } = require('./LootPlacesContractWalletProvider.js');

let startIdx = 0;
let countIdx = 2;

(async () =>
{
    const provider = new HDWalletProvider(config.mnemonic, config.providerUrl);
    const web3Instance = new web3(provider);
    const nftContract = new web3Instance.eth.Contract(
        abi,
        config.contractAddress
    );

    for (let i = 0; i < countIdx; i++) {

        let idx = startIdx + i;
        //console.log(`tokenByIndex ${idx}`);

        try {
            let id = await new Promise((resolve, reject) =>
                nftContract.methods
                    .tokenByIndex(idx)
                    .call()
                    .then((result) => { resolve(result); })
                    .catch((err) => { reject(err); })
            )
            //console.log(`tokenByIndex ${idx} => ${id}`);

            let data = await new Promise((resolve, reject) =>
                nftContract.methods
                    .getDomain(id)
                    .call()
                    .then((result) => { resolve(result); })
                    .catch((err) => { reject(err); })
            )
            console.log(`${idx}\t${id}\t${data}`);

        } catch (err) {
            console.log(`Catch`, err);
        }

        //        await new Promise(resolve => setTimeout(resolve, 1000));
    }

})();
