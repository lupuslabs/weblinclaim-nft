pragma solidity ^0.5.0;

import "./ERC721Tradable.sol";
import "openzeppelin-solidity/contracts/ownership/Ownable.sol";

/**
 * @title LootPlaces
 * LootPlaces - a contract for my non-fungible Metaverse Loot Places as building blocks.
 */
contract LootPlaces is ERC721Tradable {

    constructor(address _proxyRegistryAddress)
        public ERC721Tradable("Metaverse Loot Places", "LOTPL", _proxyRegistryAddress)
    {
    }

}
