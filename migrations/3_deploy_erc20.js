const GoldCoinToken = artifacts.require("GoldCoinToken.sol");

module.exports = function(deployer) {
  deployer.deploy(GoldCoinToken);
};
