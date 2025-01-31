// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

contract OidcKeyRegistry is Initializable, OwnableUpgradeable {
    uint8 public constant MAX_KEYS = 5;

    // keccak256(iss) => keys
    mapping(bytes32 => bytes32[MAX_KEYS]) public OIDCKeys;
    // keccak256(iss) => index
    mapping(bytes32 => uint8) public keyIndexes;

    constructor () {
        initialize();
    }

    function initialize() public initializer {
        __Ownable_init();
    }

    function hashIssuer(string memory iss) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(iss));
    }

    function setKey(bytes32 issHash, bytes32 key) public onlyOwner {
        uint8 index = keyIndexes[issHash];
        uint8 nextIndex = (index + 1) % MAX_KEYS;
        OIDCKeys[issHash][nextIndex] = key;
        keyIndexes[issHash] = nextIndex;
    }

    function setKeys(bytes32 issHash, bytes32[] memory keys) public onlyOwner {
        for (uint8 i = 0; i < keys.length; i++) {
            setKey(issHash, keys[i]);
        }
    }

    function getLatestKey(bytes32 issHash) public view returns (bytes32) {
        return OIDCKeys[issHash][keyIndexes[issHash]];
    }

    function isValidKey(bytes32 issHash, bytes32 key) public view returns (bool) {
        for (uint8 i = 0; i < MAX_KEYS; i++) {
            if (OIDCKeys[issHash][i] == key) {
                return true;
            }
        }
        return false;
    }
}
