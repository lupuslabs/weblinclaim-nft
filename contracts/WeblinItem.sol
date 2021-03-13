pragma solidity ^0.5.0;

import "./ERC721Tradable.sol";
import "openzeppelin-solidity/contracts/ownership/Ownable.sol";

/**
 * @title WeblinItem
 * WeblinItem - a contract for my non-fungible WeblinItems.
 */
contract WeblinItem is ERC721Tradable {

    constructor(address _proxyRegistryAddress, string memory _baseURI)
        public
        ERC721Tradable("WeblinItem", "WI", _proxyRegistryAddress, _baseURI)
    {
    }

    function contractURI() public view returns (string memory) {
        return baseTokenURI();
    }
}
