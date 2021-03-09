pragma solidity ^0.5.0;

import "./ERC721Tradable.sol";
import "openzeppelin-solidity/contracts/ownership/Ownable.sol";

/**
 * @title WeblinClaim
 * WeblinClaim - a contract for my non-fungible WeblinClaims.
 */
contract WeblinClaim is ERC721Tradable {
    constructor(address _proxyRegistryAddress)
        public
        ERC721Tradable("WeblinClaim", "CLAIM", _proxyRegistryAddress)
    {}

    function baseTokenURI() public pure returns (string memory) {
        return "https://webit.vulcan.weblin.com/Claim/";
    }

    function contractURI() public pure returns (string memory) {
        return "https://webit.vulcan.weblin.com/Claim";
    }
}
