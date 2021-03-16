pragma solidity ^0.5.0;

import "./ERC721.sol";
import "./GoldCoinToken.sol";

contract CryptoGame is ERC721 {
    struct Gladiator {
        uint256 level;
        string name;
        uint256 hp;
        uint256 stamina;
        uint256 att;
        uint256 def;
    }

    uint256 randNonce = 0;
    uint256 public numGladiators = 0;
    address public owner;

    Gladiator[] public gladiators;
    GoldCoinToken public money = new GoldCoinToken();

    mapping(uint256 => address) public gladiatorToOwner;
    mapping(address => uint256) public ownerToGladiator;

    modifier onlyOwnerOf(uint256 _gladiatorId) {
        require(msg.sender == gladiatorToOwner[_gladiatorId]);
        _;
    }

    modifier onlyOwner(address _owner) {
        require(owner == _owner);
        _;
    }

    constructor() public {
        owner = msg.sender;
        recruiteGladiator(owner, "Ivan");
    }

    function setWallet() public {
        money = new GoldCoinToken();
    }

    function randMod(uint256 _modulus) internal returns (uint256) {
        randNonce++;
        return
            uint256(keccak256(abi.encodePacked(now, msg.sender, randNonce))) %
            _modulus;
    }

    function recruiteGladiator(address _owner, string memory _name)
        public
    //onlyOwner(_owner)
    {
        uint256 hp = randMod(50);
        uint256 stamina = randMod(30);
        uint256 att = randMod(10);
        uint256 def = randMod(10);
        //gladiators[numGladiators] = Gladiator(1, _name, hp, stamina, att, def);
        uint256 id =
            gladiators.push(Gladiator(1, _name, hp, stamina, att, def)) - 1;
        gladiatorToOwner[id] = _owner;
        ownerToGladiator[_owner] = id;
        _mint(_owner, id);
    }

    function getGladiatorsByOwner(address _owner)
        public
        view
        returns (uint256[] memory)
    {
        uint256[] memory result = new uint256[](gladiators.length);
        uint256 counter = 0;
        for (uint256 i = 0; i < gladiators.length; i = safeAdd(i, 1)) {
            if (gladiatorToOwner[i] == _owner) {
                result[counter] = i;
                counter = safeAdd(counter, 1);
            }
        }
        return result;
    }
}
