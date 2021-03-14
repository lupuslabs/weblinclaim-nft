const {config, contract, abi} = require('./ContractWalletProvider.js');

(async () => {
    printAbi(abi);


    let result;
    /*
    result = await contract.methods
        .setBaseURI('https://example.com/')
        .send({ from: config.ownerAddress });
    console.log("R=", result);//*/

    /*result = await contract.methods
        .baseURI()
        .call();
    console.log("R=", result);//*/


    result = await contract.methods
        .mint(config.ownerAddress, 1338, "?foo=bar")
        .send( {from: config.ownerAddress} );
    console.log("R=", result);//*/

    result = await contract.methods
        .properties(138)
        .call( {from: config.ownerAddress} );
    console.log("R=", result);//*/

    result = await contract.methods
        .tokenURI(config.ownerAddress)
        .call( {from: config.ownerAddress} );
    console.log("R=", result);//*/

    process.exit();
})();


function printAbi(abi) {
    for (n in abi) {
        let inp = [];
        let outp = [];
        for (o in abi[n].inputs) {
            inp.push(abi[n].inputs[o].type + ' ' + abi[n].inputs[o].name);
        }
        for (o in abi[n].outputs) {
            outp.push(abi[n].outputs[o].type + ' ' + abi[n].outputs[o].name);
        }
        let sig = abi[n].type + ' ' + abi[n].name + '(' + inp.join(', ') + '): ' + outp.join(', ');
        console.log(sig);
    }
}
