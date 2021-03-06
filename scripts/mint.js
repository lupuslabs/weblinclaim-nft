const HDWalletProvider = require("truffle-hdwallet-provider");
const web3 = require('web3');
const {config, contract, abi} = require('./ContractWalletProvider.js');

const mintTo = '0x510F5dD4f91Ee303332B6EAC96bCCE510f05E0E2';
const itemProperties = {
    '12': '?d=veefriends.com&s=1000000&t=CryptoClaim',
    '13': '?d=garyvaynerchuk.com&s=1000000&t=CryptoClaim',
}



const mint = (id, nonce) => {
    let properties = itemProperties[id];

    const txOptions = {
        from: config.ownerAddress,
        gasPrice: web3.utils.toWei("25", 'gwei'),
        gas: 300000,
        value: 0,
        nonce: nonce,
    }

    console.log(`Minting ${id}`, txOptions );

    const provider = new HDWalletProvider(config.mnemonic, config.providerUrl);
    const web3Instance = new web3(provider);
    const nftContract = new web3Instance.eth.Contract(
        abi,
        config.contractAddress,
        { gasLimit: "1000000" }
    );

    tx = nftContract.methods
        .mint(mintTo, id, properties)
        .send(txOptions)
        .then( (result) => { console.log(`Minted ${id}: ${result.transactionHash}`); })
        .catch( (err) => {console.log(`Failed ${id}:`, err); }  );
}


( async () => {

    const provider = new HDWalletProvider(config.mnemonic, config.providerUrl);
    const web3Instance = new web3(provider);

    let nonce = await web3Instance.eth.getTransactionCount(
        config.ownerAddress
    );

    for (n in itemProperties) {
        mint(n, nonce);
        nonce++;
    }

})();
