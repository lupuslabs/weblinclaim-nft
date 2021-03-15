const {config, contract, abi} = require('./ContractWalletProvider.js');

const mintTo = '0x510F5dD4f91Ee303332B6EAC96bCCE510f05E0E2';
const itemProperties = {
    '0': '?d=galactic-developments.de&s=1000000000&t=CryptoClaim',
    '1': '?d=3lau.com&s=1000000&t=CryptoClaim',
    '2': '?d=tesla.com&s=1000000&t=CryptoClaim',
    '3': '?d=banklesshq.com&s=1000000&t=CryptoClaim',
    '4': '?d=opensea.io&s=1000000&t=CryptoClaim',
    '5': '?d=thedailygwei.substack.com&s=1000000&t=CryptoClaim',
};



const mint = (id) => {
    let properties = itemProperties[id];
    console.log(`Minting ${id}` );
    let result = contract.methods
        .mint(mintTo, id, properties)
        .send({ from: config.ownerAddress })
        .then( (result) => { console.log(`Minted ${id}: ${result.transactionHash}`)})
        .catch(err => console.log(`Failed ${id}:`, err) );
}
mint('0');
/*
for (n in itemProperties) {
    mint(n);
}
*/

