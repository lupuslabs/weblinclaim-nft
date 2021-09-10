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
        "tesla", 
        "starwars", 
        "garyvaynerchuk", 
        "billieeilish", 
        "nsa.gov", 
        "youtube.com/user/PewDiePie", 
        "spotify", 
        "apple", 
        "paypal", 
        "facebook", 
        "netflix", 
        "ethereum.org", 
        "axieinfinity", 
        "pokemoncenter", 
        "minecraft.net", 
        "berniesanders", 
        "beeple-crap", 
        "opensea.io", 
        "sothebys", 
        "christies"
    ];

    string[] private domainsMed = [
        "microsoft", 
        "time", 
        "coinbase", 
        "007", 
        "yahoo", 
        "imdb", 
        "ebay", 
        "etsy", 
        "craigslist.org", 
        "steemit", 
        "huffpost", 
        "buzzfeed", 
        "cnn", 
        "medium", 
        "youtube", 
        "nytimes", 
        "espn", 
        "hulu", 
        "github", 
        "stackoverflow", 
        "giphy", 
        "4chan.org", 
        "nasa.gov", 
        "wsj", 
        "roblox", 
        "chess", 
        "blackrock", 
        "worldbank.org", 
        "nestle", 
        "ethgasstation.info"
    ];

    string[] private domainsCommon = [
        "3lau", 
        "banklesshq", 
        "thedailygwei.substack", 
        "forbes.com/crypto-blockchain", 
        "a16z", 
        "draper.vc", 
        "veefriends", 
        "microstrategy", 
        "robinhood", 
        "gemini", 
        "coinmarketcap", 
        "cointelegraph", 
        "decrypt.co", 
        "niftygateway", 
        "beta.cent.co", 
        "mintable.app", 
        "trevornoah", 
        "twitter.com/jack", 
        "twitter.com/hamillhimself", 
        "twitter.com/elonmusk", 
        "messi", 
        "50cent", 
        "loganpaul", 
        "twitch.tv/trymacs", 
        "sequoiacap", 
        "earlybird", 
        "indexventures", 
        "parsec.finance", 
        "federalreserve.gov", 
        "sec.gov", 
        "fridaysforfuture.org", 
        "ipcc.ch", 
        "venturebeat", 
        "greyscale.co", 
        "britannica", 
        "goldmansachs", 
        "disney", 
        "en.wikipedia.org/wiki/Rocket_Raccoon", 
        "xkcd", 
        "akb48.co.jp", 
        "tvtropes.org", 
        "reddit.com/r/Bitcoin", 
        "reddit.com/r/ethereum", 
        "cyberpunk.net", 
        "mario.nintendo", 
        "thelastofus.fandom.com/wiki/Ellie", 
        "epicgames.com/fortnite", 
        "gatherer.wizards.com", 
        "kraken", 
        "deviantart.com/tag/chloeprice", 
        "larvalabs.com/cryptopunks", 
        "linkedin", 
        "messari.io", 
        "imgur", 
        "samsung", 
        "fandom", 
        "geeksforgeeks.org", 
        "discordapp", 
        "wellsfargo", 
        "fidelity", 
        "investopedia", 
        "theoceancleanup", 
        "seashepherd.org", 
        "greenpeace.org", 
        "gitcoin.co", 
        "uniswap.org", 
        "aave", 
        "chain.link", 
        "makerdao", 
        "bitcoin.org", 
        "polygon.technology", 
        "filecoin.io", 
        "thegraph", 
        "sushi", 
        "wired", 
        "4ocean", 
        "cookpad", 
        "allrecipies", 
        "delish", 
        "thekitchn"
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
        uint256 prob = rand % 10000;

        if (prob < 100) {
            output = domainsRare[rand % domainsRare.length];
        } else if (prob < 1000 ) {
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
        uint256 prob = rand % 10000;

        if (prob < 100) {
            value = rand % 2 + 8;
        } else if (prob < 1000) {
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
        uint256 prob = rand % 10000;

        uint256 index;

        if (prob < 100) {
            index = rand % 2 + 6;
        } else if (prob < 1000 ) {
            index = rand % 2 + 4;
        } else {
            index = rand % 4;
        }

        return sourceArray[index];
    }

    string _description = 'Metaverse Loot Places (for Adventurers). These tokens let you claim ownership of web based metaverse places AND they define individual properties for these places.';

    function tokenURI(uint256 tokenId) external view returns (string memory) {
        require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");

        string memory svg = '<svg xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMinYMin meet" viewBox="0 0 350 350"><style>.base { fill: white; font-family: serif; font-size: 14px; }</style><rect width="100%" height="100%" fill="black" />';
        svg = Strings.cat(svg, '<text x="10" y="20" class="base">');
        svg = Strings.cat(svg, getDomain(tokenId));
        svg = Strings.cat(svg, '</text><text x="10" y="40" class="base">');
        svg = Strings.cat(svg, getStrength(tokenId));
        svg = Strings.cat(svg, '</text><text x="10" y="60" class="base">');
        svg = Strings.cat(svg, getResource(tokenId));
        svg = Strings.cat(svg, '</text><text x="10" y="80" class="base">');
        svg = Strings.cat(svg, getSecurity(tokenId));
        svg = Strings.cat(svg, '</text><text x="10" y="100" class="base">');
        svg = Strings.cat(svg, getMagic(tokenId));
        svg = Strings.cat(svg, '</text><text x="10" y="120" class="base">');
        svg = Strings.cat(svg, getFaction(tokenId));
        svg = Strings.cat(svg, '</text><text x="10" y="140" class="base">');
        svg = Strings.cat(svg, getInfo(tokenId));
        svg = Strings.cat(svg, '</text><text x="10" y="160" class="base">');
        svg = Strings.cat(svg, getEnvironment(tokenId));
        svg = Strings.cat(svg, '</text></svg>');

        string memory attrs = '[{"trait_type": "Domain", "value": "';
        attrs = Strings.cat(attrs, getDomain(tokenId));
        attrs = Strings.cat(attrs, '"}, {"trait_type": "Strength", "value": "');
        attrs = Strings.cat(attrs, getStrength(tokenId));
        attrs = Strings.cat(attrs, '"}, {"trait_type": "Resource", "value": "');
        attrs = Strings.cat(attrs, getResource(tokenId));
        attrs = Strings.cat(attrs, '"}, {"trait_type": "Security", "value": "');
        attrs = Strings.cat(attrs, getSecurity(tokenId));
        attrs = Strings.cat(attrs, '"}, {"trait_type": "Magic", "value": "');
        attrs = Strings.cat(attrs, getMagic(tokenId));
        attrs = Strings.cat(attrs, '"}, {"trait_type": "Faction", "value": "');
        attrs = Strings.cat(attrs, getFaction(tokenId));
        attrs = Strings.cat(attrs, '"}, {"trait_type": "Info", "value": "');
        attrs = Strings.cat(attrs, getInfo(tokenId));
        attrs = Strings.cat(attrs, '"}, {"trait_type": "Environment", "value": "');
        attrs = Strings.cat(attrs, getEnvironment(tokenId));
        attrs = Strings.cat(attrs, '"}]');

        string memory json = '{"name": "Place #';
        json = Strings.cat(json, Strings.uint2str(tokenId));
        json = Strings.cat(json, '", "description": "');
        json = Strings.cat(json, _description);
        json = Strings.cat(json, '", "attributes":');
        json = Strings.cat(json, attrs);
        json = Strings.cat(json, ', "image": "data:image/svg+xml;base64,');
        json = Strings.cat(json, Base64.encode(bytes(svg)));
        json = Strings.cat(json, '"}');

        return Strings.cat('data:application/json;base64,', Base64.encode(bytes(json)));
    }

    function contractURI() public view returns (string memory) {
        string memory json = '{"name": "Metaverse places for adventurers on web pages", "description": "';
        json = Strings.cat(json, _description);
        json = Strings.cat(json, '", "external_link": "https://www.weblin.io/LootPlaces", "image": "https://www.weblin.io/images/lootplaces/contract.jpg", "seller_fee_basis_points": 200, "fee_recipient": "0x510F5dD4f91Ee303332B6EAC96bCCE510f05E0E2"}');

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