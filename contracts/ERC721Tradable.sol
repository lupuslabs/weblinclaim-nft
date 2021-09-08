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

    string[] private resources = [
    "Soil",
    "Rocks",
    "Minerals",
    "Water",
    "Waste",

    "Volatiles",
    "Relics",
    "Rare earths",

    "Precious metals",
    "Gems"
    ];

    string[] private secs = [
    "Anarchy", "Fractionalized", "Lowsec", "Controlled", "Policed", "Secured", "Safe", "sec8", "sec9", "sec10"
    ];

    string[] private magics = [
    "MAnarchy", "MFractionalized", "MLowsec", "MControlled", "MPoliced", "MSecured", "MSafe", "Msec8", "Msec9", "Msec10"
    ];

    string[] private factions = [
    "FAnarchy", "FFractionalized", "FLowsec", "FControlled", "FPoliced", "FSecured", "FSafe", "Fsec8", "Fsec9", "Fsec10"
    ];

    string[] private infos = [
    "IAnarchy", "IFractionalized", "ILowsec", "IControlled", "IPoliced", "ISecured", "ISafe", "Isec8", "Isec9", "Isec10"
    ];

    string[] private lifes = [
    "LAnarchy", "LFractionalized", "LLowsec", "LControlled", "LPoliced", "LSecured", "LSafe", "Lsec8", "Lsec9", "Lsec10"
    ];

    constructor(
        string memory _name,
        string memory _symbol,
        address _proxyRegistryAddress
    ) public ERC721Full(_name, _symbol) {
        proxyRegistryAddress = _proxyRegistryAddress;
    }


    function claim(uint256 tokenId) public  {
        require(tokenId > 0 && tokenId < 9900, "Token ID invalid");
        _mint(_msgSender(), tokenId);
    }

    function random(string memory input) internal pure returns (uint256) {
        return uint256(keccak256(bytes (input)));
    }

    function getDomain(uint256 tokenId) public view returns (string memory) {

        string memory output = "";
        uint256 rand = random(Strings.uint2str(tokenId));
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

    function getStrength(uint256 tokenId) public view returns (string memory) {

        uint256 value;
        uint256 rand = random(Strings.uint2str(tokenId));
        uint256 rareness = rand % 10000;

        if (rareness < 100) {
            value = rand % 2 + 8;
        } else if (rareness < 1000) {
            value = rand % 3 + 5;
        } else {
            value = rand % 4 + 1;
        }
        return Strings.uint2str(value * 100000);
    }

    function getResource(uint256 tokenId) public view returns (string memory) {
        return propProb(tokenId, "Resource", resources);
    }

    function getSecurity(uint256 tokenId) public view returns (string memory) {
        return propProb(tokenId, "Security", secs);
    }

    function getMagic(uint256 tokenId) public view returns (string memory) {
        return propProb(tokenId, "Magic", magics);
    }

    function getFaction(uint256 tokenId) public view returns (string memory) {
        return propProb(tokenId, "Faction", factions);
    }

    function getInfo(uint256 tokenId) public view returns (string memory) {
        return propProb(tokenId, "Info", infos);
    }

    function getLife(uint256 tokenId) public view returns (string memory) {
        return propProb(tokenId, "Life", lifes);
    }


    function propProb(uint256 tokenId, string memory keyPrefix, string[] memory sourceArray) internal view returns (string memory) {
        uint256 rand = random(string(abi.encodePacked(keyPrefix, Strings.uint2str(tokenId))));
        uint256 rareness = rand % 10000;

        uint256 index;

        if (rareness < 100) {
            index = rand % 2 + 8;
        } else if (rareness < 1000 ) {
            index = rand % 3 + 5;
        } else {
            index = rand % 5;
        }

        string memory output = sourceArray[index];

        return output;
    }

    function tokenURI(uint256 tokenId) external view returns (string memory) {
        require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");

        string[17] memory parts;
        parts[0] = '<svg xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMinYMin meet" viewBox="0 0 350 350"><style>.base { fill: white; font-family: serif; font-size: 14px; }</style><rect width="100%" height="100%" fill="black" /><text x="10" y="20" class="base">';
        parts[1] = getDomain(tokenId);
        parts[2] = '</text><text x="10" y="40" class="base">';
        parts[3] =  getStrength(tokenId);
        parts[4] = '</text><text x="10" y="60" class="base">';
        parts[5] =  getResource(tokenId);
        parts[6] = '</text><text x="10" y="80" class="base">';
        parts[7] =  getSecurity(tokenId);
        parts[8] = '</text><text x="10" y="100" class="base">';
        parts[9] =  getMagic(tokenId);
        parts[10] = '</text><text x="10" y="120" class="base">';
        parts[11] =  getFaction(tokenId);
        parts[12] = '</text><text x="10" y="140" class="base">';
        parts[13] =  getInfo(tokenId);
        parts[14] = '</text><text x="10" y="160" class="base">';
        parts[15] =  getLife(tokenId);
        parts[16] = '</text></svg>';

        string memory svg = Strings.strConcat(parts[0], parts[1], parts[2], parts[3], parts[4]);
        svg = Strings.strConcat(svg, parts[5], parts[6], parts[7], parts[8]);
        svg = Strings.strConcat(svg, parts[9], parts[10], parts[11], parts[12]);
        svg = Strings.strConcat(svg, parts[13], parts[14], parts[15], parts[16]);

        parts[0] = '[{"trait_type": "Domain", "value": "';
        parts[1] = getDomain(tokenId);
        parts[2] = '"}, {"trait_type": "Strength", "value": "';
        parts[3] =  getStrength(tokenId);
        parts[2] = '"}, {"trait_type": "Resource", "value": "';
        parts[5] =  getResource(tokenId);
        parts[2] = '"}, {"trait_type": "Security", "value": "';
        parts[7] =  getSecurity(tokenId);
        parts[2] = '"}, {"trait_type": "Magic", "value": "';
        parts[9] =  getMagic(tokenId);
        parts[2] = '"}, {"trait_type": "Faction", "value": "';
        parts[11] =  getFaction(tokenId);
        parts[2] = '"}, {"trait_type": "Info", "value": "';
        parts[13] =  getInfo(tokenId);
        parts[2] = '"}, {"trait_type": "Life", "value": "';
        parts[15] =  getLife(tokenId);
        parts[16] = '"}]';

        string memory attrs = Strings.strConcat(parts[0], parts[1], parts[2], parts[3], parts[4]);
        attrs = Strings.strConcat(attrs, parts[5], parts[6], parts[7], parts[8]);
        attrs = Strings.strConcat(attrs, parts[9], parts[10], parts[11], parts[12]);
        attrs = Strings.strConcat(attrs, parts[13], parts[14], parts[15], parts[16]);

        //
        string memory json = Base64.encode(bytes(Strings.strConcat('{"name": "Place #', Strings.uint2str(tokenId), '", "description": " ...desc", "attributes":', attrs, ', "image": "data:image/svg+xml;base64,', Base64.encode(bytes(svg)), '"}')));
        string memory output = Strings.strConcat('data:application/json;base64,', json);

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