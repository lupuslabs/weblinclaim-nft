const HDWalletProvider = require("truffle-hdwallet-provider");
const configRinkeby = require("./scripts/config.rinkeby.js");
const configLive = require("./scripts/config.live.js");
var readlineSync = require('readline-sync');

if (process.argv[3]=='--network=live') {
    configLive.mnemonic = readlineSync.question('May I have your mnemonic? ');
}

module.exports = {
    networks: {
        development: {
            host: "localhost",
            port: 7545,
            gas: 5000000,
            network_id: "*",
        },
        rinkeby: {
            provider: function () {
                return new HDWalletProvider(configRinkeby.mnemonic, configRinkeby.providerUrl);
            },
            gas: 10000000,
            gasPrice: 5e9,
            network_id: "*",
        },
        live: {
            network_id: 1,
            provider: function () {
                return new HDWalletProvider(configLive.mnemonic, configLive.providerUrl);
            },
            gas: 250000,
            gasPrice: 200e9,
        },
    },
    mocha: {
        reporter: "eth-gas-reporter",
        reporterOptions: {
            currency: "USD",
            gasPrice: 2,
        },
    },
    compilers: {
        solc: {
            version: "^0.5.0",
        },
    },
};
