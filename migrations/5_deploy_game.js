const CryptoGame = artifacts.require("CryptoGame.sol");

module.exports = function(deployer) {
  deployer.deploy(CryptoGame);
};
