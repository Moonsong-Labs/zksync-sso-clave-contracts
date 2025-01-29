// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

contract OidcKeyRegistry is UUPSUpgradeable, OwnableUpgradeable {
    uint8 public constant MAX_KEYS = 5;

    // keccak256(iss) => keys
    mapping(bytes32 => bytes32[MAX_KEYS]) public OIDCKeys;
    // keccak256(iss) => index
    mapping(bytes32 => uint8) public keyIndexes;

    function initialize() public initializer {
        __Ownable_init();
        __UUPSUpgradeable_init();
    }

    function hashIssuer(string memory iss) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(iss));
    }

    function setKey(bytes32 iss, bytes32 key) public onlyOwner {
        uint8 index = keyIndexes[iss];
        uint8 nextIndex = (index + 1) % MAX_KEYS;
        OIDCKeys[iss][nextIndex] = key;
        keyIndexes[iss] = nextIndex;
    }

    function getLatestKey(bytes32 iss) public view returns (bytes32) {
        return OIDCKeys[iss][keyIndexes[iss]];
    }

    function _authorizeUpgrade(
        address newImplementation
    ) internal override onlyOwner {}
}
