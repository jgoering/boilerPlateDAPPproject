// Allows us to use ES6 in our migrations and tests.
require('babel-register')
const HDWalletProvider = require("truffle-hdwallet-provider");
module.exports = {
    networks: {
        development: {
            host: "127.0.0.1",
            port: 9545,
            network_id: "*" // Match any network id
        },
        rinkeby: {
            provider: function() {
                return new HDWalletProvider("apology sing dynamic avocado unaware obtain someone sad jazz jealous produce promote", "https://rinkeby.infura.io/v3/4bc797e46db64e058320f48be0bbb177")
            },
            network_id: '4',
            gas: 4500000,
            gasPrice: 10000000000,
        }
    }
};
