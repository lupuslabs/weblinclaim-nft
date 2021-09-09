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

    string[] private domainsRare = [
        "microstrategy",
        "007",
        "beeple-crap",
        "robinhood",
        "blackrock",
        "foxnews",
        "nestle",
        "worldbank.org",
        "starwars",
        "yahoo",
        "craigslist.org",
        "ebay",
        "etsy",
        "imdb",
        "christies",
        "binance",
        "zerohedge",
        "ethgasstation.info",
        "gemini",
        "coinmarketcap"
    ];

    string[] private domainsMed = [
        "cointelegraph",
        "decrypt.co",
        "niftygateway",
        "beta.cent.co",
        "mintable.app",
        "trevornoah",
        "messi",
        "50cent",
        "loganpaul",
        "billieeilish",
        "threshold.vc",
        "sequoiacap",
        "accel",
        "usv",
        "earlybird",
        "balderton",
        "indexventures",
        "parsec.finance.com",
        "boost.vc",
        "nsa.gov",
        "federalreserve.gov",
        "sec.gov",
        "defense.gov",
        "fridaysforfuture.org",
        "ipcc.ch",
        "nasa.gov",
        "venturebeat",
        "tyt"
    ];

    string[] private domainsCommon = [
        "huffpost",
        "buzzfeed",
        "wsj",
        "greyscale.co",
        "cnn",
        "nytimes",
        "britannica",
        "wattpad",
        "mastercard",
        "trump",
        "opec.org",
        "bridgewater",
        "goldmansachs",
        "disney",
        "xkcd",
        "akb48.co.jp",
        "tvtropes.org",
        "orionsarm",
        "stackoverflow",
        "4chan.org",
        "steemit",
        "medium",
        "roblox",
        "cyberpunk.net",
        "mario.nintendo",
        "minecraft.net",
        "pokemoncenter",
        "linkedin",
        "youtube",
        "messari.io",
        "travisscott",
        "wikipedia.org",
        "instagram",
        "apple",
        "twitter",
        "aliexpress",
        "imgur",
        "amazon",
        "facebook",
        "reddit",
        "netflix",
        "twitch.tv",
        "cnn",
        "adobe",
        "nytimes",
        "walmart",
        "indeed",
        "espn",
        "hulu",
        "github",
        "spotify"
    ];

    string[] private resourceSet =    [ "Rocks"      , "Minerals"   , "Ore"       , "Waste"      , "Relics"    , "Rare earths", "Precious metals", "Gems"     ]; 
    string[] private securitySet =    [ "Policed"    , "Factional"  , "Lowsec"    , "Controlled" , "Dark"      , "Secured"    , "Anarchy"        , "Safe"     ]; 
    string[] private magicSet =       [ "Silent"     , "Gaia"       , "Kami"      , "Elemental"  , "Arcane"    , "Wizardy"    , "Devine"         , "Demonic"  ]; 
    string[] private factionSet =     [ "Brass"      , "Obsidian"   , "Chrome"    , "Onyx"       , "Lava"      , "Almond"     , "Coral"          , "Taupe"    ]; 
    string[] private infoSet =        [ "Unconnected", "Slow"       , "Wired"     , "Ubiquitous" , "Embedded"  , "Matrix"     , "Quantum"        , "Transcend"]; 
    string[] private environmentSet = [ "Supportive" , "Indifferent", "Hostile"   , "Unfavorable", "Harmful"   , "Rich"       , "Lethal"         , "Lush"     ]; 

    constructor(
        string memory _name,
        string memory _symbol,
        address _proxyRegistryAddress
    ) public ERC721Full(_name, _symbol) {
        proxyRegistryAddress = _proxyRegistryAddress;
    }


    function claim(uint256 tokenId) public  {
        require(tokenId > 0 && tokenId <= 9900, "Token ID invalid");
        _mint(_msgSender(), tokenId);
    }

    function ownerClaim(uint256 tokenId) public onlyOwner {
        require(tokenId > 9900 && tokenId <= 10000, "Token ID invalid");
        _safeMint(owner(), tokenId);
    }

    function random(string memory input) internal pure returns (uint256) {
        return uint256(keccak256(bytes (input)));
    }

    function getDomain(uint256 tokenId) public view returns (string memory) {

        string memory output = '';
        uint256 rand = random(Strings.uint2str(tokenId));
        uint256 rareness = rand % 10000;

        if (rareness < 2) {
            output = domainsRare[rand % domainsRare.length];
        } else if (rareness < 30 ) {
            output = domainsMed[rand % domainsMed.length];
        } else {
            output = domainsCommon[rand % domainsCommon.length];
        }

        if (!Strings.contains(output, '.')) 
        {
            output = Strings.cat(output, '.com');
        }

        return output;
    }

    function getStrength(uint256 tokenId) public pure returns (string memory) {

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
        return getProperty(tokenId, "Resource", resourceSet);
    }

    function getSecurity(uint256 tokenId) public view returns (string memory) {
        return getProperty(tokenId, "Security", securitySet);
    }

    function getMagic(uint256 tokenId) public view returns (string memory) {
        return getProperty(tokenId, "Magic", magicSet);
    }

    function getFaction(uint256 tokenId) public view returns (string memory) {
        return getProperty(tokenId, "Faction", factionSet);
    }

    function getInfo(uint256 tokenId) public view returns (string memory) {
        return getProperty(tokenId, "Info", infoSet);
    }

    function getEnvironment(uint256 tokenId) public view returns (string memory) {
        return getProperty(tokenId, "Environment", environmentSet);
    }


    function getProperty(uint256 tokenId, string memory keyPrefix, string[] memory sourceArray) internal pure returns (string memory) {
        uint256 rand = random(string(abi.encodePacked(keyPrefix, Strings.uint2str(tokenId))));
        uint256 rareness = rand % 10000;

        uint256 index;

        if (rareness < 100) {
            index = rand % 2 + 6;
        } else if (rareness < 1000 ) {
            index = rand % 2 + 4;
        } else {
            index = rand % 4;
        }

        return sourceArray[index];
    }

    function appendLine(string memory _base, string memory _left, string memory _a, string memory _right, string memory _b, string memory _close) internal pure returns (string memory) {
        return Strings.cat(Strings.cat(Strings.cat(Strings.cat(Strings.cat(_base, _left), _a), _right), _b), _close);
    }

    string svgLeft = '</text><text x="10" y="';
    string svgRight = '" class="base">';
    string svgClose = '</text>';
    uint256 svgDY = 20;
    string attrsLeft = '{"trait_type": "';
    string attrsRight = '", "value": "';
    string attrsClose = '"},';

    function tokenURI(uint256 tokenId) external view returns (string memory) {
        require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");

        uint256 svgY = 20;
        string memory svg = '<svg xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMinYMin meet" viewBox="0 0 350 350"><style>.base { fill: white; font-family: serif; font-size: 14px; }</style><rect width="100%" height="100%" fill="black" />';
        svg = appendLine(svg, svgLeft, Strings.uint2str(svgY), svgRight, getDomain(tokenId), svgClose); svgY += svgDY;
        svg = appendLine(svg, svgLeft, Strings.uint2str(svgY), svgRight, getStrength(tokenId), svgClose); svgY += svgDY;
        svg = appendLine(svg, svgLeft, Strings.uint2str(svgY), svgRight, getResource(tokenId), svgClose); svgY += svgDY;
        svg = appendLine(svg, svgLeft, Strings.uint2str(svgY), svgRight, getSecurity(tokenId), svgClose); svgY += svgDY;
        svg = appendLine(svg, svgLeft, Strings.uint2str(svgY), svgRight, getMagic(tokenId), svgClose); svgY += svgDY;
        svg = appendLine(svg, svgLeft, Strings.uint2str(svgY), svgRight, getFaction(tokenId), svgClose); svgY += svgDY;
        svg = appendLine(svg, svgLeft, Strings.uint2str(svgY), svgRight, getInfo(tokenId), svgClose); svgY += svgDY;
        svg = appendLine(svg, svgLeft, Strings.uint2str(svgY), svgRight, getEnvironment(tokenId), svgClose); svgY += svgDY;
        svg = Strings.cat(svg, '</text></svg>');

        string memory attrs = '[';
        attrs = appendLine(attrs, attrsLeft, 'Domain', attrsRight, getDomain(tokenId), attrsClose);
        attrs = appendLine(attrs, attrsLeft, 'Strength', attrsRight, getStrength(tokenId), attrsClose);
        attrs = appendLine(attrs, attrsLeft, 'Resource', attrsRight, getResource(tokenId), attrsClose);
        attrs = appendLine(attrs, attrsLeft, 'Security', attrsRight, getSecurity(tokenId), attrsClose);
        attrs = appendLine(attrs, attrsLeft, 'Magic', attrsRight, getMagic(tokenId), attrsClose);
        attrs = appendLine(attrs, attrsLeft, 'Faction', attrsRight, getFaction(tokenId), attrsClose);
        attrs = appendLine(attrs, attrsLeft, 'Info', attrsRight, getInfo(tokenId), attrsClose);
        attrs = appendLine(attrs, attrsLeft, 'Environment', attrsRight, getEnvironment(tokenId), '"}');
        attrs = Strings.cat(attrs, ']');

        string memory json = '{"name": "Place #';
        json = Strings.cat(json, Strings.uint2str(tokenId));
        json = Strings.cat(json, '", "description": "Metaverse loot places for adventurers. The token defines properties of a web based metaverse location.", "attributes":');
        json = Strings.cat(json, attrs);
        json = Strings.cat(json, ', "image": "data:image/svg+xml;base64,');
        json = Strings.cat(json, Base64.encode(bytes(svg)));
        json = Strings.cat(json, '"}');

        return Strings.cat('data:application/json;base64,', Base64.encode(bytes(json)));
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