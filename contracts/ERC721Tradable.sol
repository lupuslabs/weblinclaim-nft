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
    string public baseURI;

    mapping (uint256 => string) private _properties;

    constructor(
        string memory _name,
        string memory _symbol,
        address _proxyRegistryAddress,
        string memory _baseURI
    ) public ERC721Full(_name, _symbol) {
        setBaseURI(_baseURI);
        proxyRegistryAddress = _proxyRegistryAddress;
    }

    /**
     * @dev Mints a token to an address with a tokenURI.
     * @param to address of the future owner of the token
     */
    function mint(address to, uint256 tokenId, string memory properties) public onlyOwner {
        _mint(to, tokenId);
        _properties[tokenId] = properties;
    }

    function properties(uint256 tokenId) public view returns (string memory) {
        return _properties[tokenId];
    }

    function baseTokenURI() public view returns (string memory) {
        return baseURI;
    }

    function setBaseURI(string memory uri) public onlyOwner {
        baseURI = uri;
    }

    function tokenURI(uint256 tokenId) external view returns (string memory) {
        return Strings.strConcat(baseTokenURI(), Strings.uint2str(tokenId), properties(tokenId));
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
