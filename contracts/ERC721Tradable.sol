pragma solidity ^0.5.0;

import "openzeppelin-solidity/contracts/token/ERC721/ERC721Full.sol";
import "openzeppelin-solidity/contracts/ownership/Ownable.sol";
import "./Strings.sol";

contract OwnableDelegateProxy {}

contract ProxyRegistry {
    mapping(address => OwnableDelegateProxy) public proxies;
}


/**
 * @title ERC721Tradable
 * ERC721Tradable - ERC721 contract that whitelists a trading address, and has minting functionality.
 */
contract ERC721Tradable is ERC721Full, Ownable {
    using Strings for string;

    address proxyRegistryAddress;

    string[] private domains_high = [
    "example.com",
    "twitter.com",
    "facebook.com",
    "sui.li"
    ];

    string[] private domains_mid = [
    "example.com",
    "twitter.com",
    "facebook.com",
    "sui.li"
    ];

    string[] private domains_low = [
    "google.com",
    "twitter.com",
    "facebook.com",
    "sui.li"
    ];

    constructor(
        string memory _name,
        string memory _symbol,
        address _proxyRegistryAddress
    ) public ERC721Full(_name, _symbol) {
        proxyRegistryAddress = _proxyRegistryAddress;
    }

    /**
     * @dev Mints a token to an address with a tokenURI.
     * @param to address of the future owner of the token
     */
    function mint(address to, uint256 tokenId) public onlyOwner {
        _mint(to, tokenId);
    }

    function random(string memory input) internal pure returns (uint256) {
        return uint256(keccak256(bytes (input)));
    }

    function getDomain(uint256 tokenId, uint256 number) public view returns (string memory) {

        string memory output = "";
        uint256 rand = random(Strings.strConcat(Strings.uint2str(number), Strings.uint2str(tokenId)));
        uint256 rareness = rand % 10000;

        if (rareness < 2) {
            output = domains_high[rand % domains_high.length];
        } else if (rareness < 30 ) {
            output = domains_mid[rand % domains_mid.length];
        } else {
            output = domains_low[rand % domains_low.length];
        }
        return output;
    }


    function tokenURI(uint256 tokenId) external view returns (string memory) {
        string[17] memory parts;
        parts[0] = '<svg xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMinYMin meet" viewBox="0 0 350 350"><style>.base { fill: white; font-family: serif; font-size: 14px; }</style><rect width="100%" height="100%" fill="black" /><text x="10" y="20" class="base">';

        parts[1] = getDomain(tokenId, 1);

        parts[2] = '</text><text x="10" y="40" class="base">';

        parts[3] =  getDomain(tokenId, 2);

        parts[4] = '</text><text x="10" y="60" class="base">';

        parts[5] =  getDomain(tokenId, 3);

        parts[6] = '</text></svg>';

        string memory output = (Strings.strConcat(parts[0], parts[1], parts[2], parts[3], parts[4], parts[5], parts[6]));

        string memory json = Base64.encode(bytes(Strings.strConcat('{"name": "Bag #', Strings.uint2str(tokenId), '", "description": " ...desc", "image": "data:image/svg+xml;base64,', Base64.encode(bytes(output)), '"}')));
        output = Strings.strConcat('data:application/json;base64,', json);

        return output;
    }


    /**
     * Override isApprovedForAll to whitelist user's OpenSea proxy accounts to enable gas-less listings.
     */
    function isApprovedForAll(address owner, address operator)
        public
        view
        returns (bool)
    {
        // Whitelist OpenSea proxy contract for easy trading.
        ProxyRegistry proxyRegistry = ProxyRegistry(proxyRegistryAddress);
        if (address(proxyRegistry.proxies(owner)) == operator) {
            return true;
        }

        return super.isApprovedForAll(owner, operator);
    }
}


library Base64 {
    bytes internal constant TABLE = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

    /// @notice Encodes some bytes to the base64 representation
    function encode(bytes memory data) internal pure returns (string memory) {
        uint256 len = data.length;
        if (len == 0) return "";

        // multiply by 4/3 rounded up
        uint256 encodedLen = 4 * ((len + 2) / 3);

        // Add some extra buffer at the end
        bytes memory result = new bytes(encodedLen + 32);

        bytes memory table = TABLE;

        assembly {
            let tablePtr := add(table, 1)
            let resultPtr := add(result, 32)

            for {
                let i := 0
            } lt(i, len) {

            } {
                i := add(i, 3)
                let input := and(mload(add(data, i)), 0xffffff)

                let out := mload(add(tablePtr, and(shr(18, input), 0x3F)))
                out := shl(8, out)
                out := add(out, and(mload(add(tablePtr, and(shr(12, input), 0x3F))), 0xFF))
                out := shl(8, out)
                out := add(out, and(mload(add(tablePtr, and(shr(6, input), 0x3F))), 0xFF))
                out := shl(8, out)
                out := add(out, and(mload(add(tablePtr, and(input, 0x3F))), 0xFF))
                out := shl(224, out)

                mstore(resultPtr, out)

                resultPtr := add(resultPtr, 4)
            }

            switch mod(len, 3)
            case 1 {
                mstore(sub(resultPtr, 2), shl(240, 0x3d3d))
            }
            case 2 {
                mstore(sub(resultPtr, 1), shl(248, 0x3d))
            }

            mstore(result, encodedLen)
        }

        return string(result);
    }
}