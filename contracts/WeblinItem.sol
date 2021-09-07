pragma solidity ^0.5.0;

import "./ERC721Tradable.sol";
import "openzeppelin-solidity/contracts/ownership/Ownable.sol";

/**
 * @title WeblinItem
 * WeblinItem - a contract for my non-fungible WeblinItems.
 */
contract WeblinItem is ERC721Tradable {

    constructor(address _proxyRegistryAddress)
        public
        ERC721Tradable("Loot Places", "LOTP", _proxyRegistryAddress)
    {
    }


}
