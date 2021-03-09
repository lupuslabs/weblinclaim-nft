pragma solidity ^0.5.11;

import "multi-token-standard/contracts/interfaces/IERC1155TokenReceiver.sol";



contract TestForReentrancyAttack is IERC1155TokenReceiver {
    // bytes4(keccak256("onERC1155Received(address,address,uint256,uint256,bytes)"))
    bytes4 constant internal ERC1155_RECEIVED_SIG = 0xf23a6e61;
    // bytes4(keccak256("onERC1155BatchReceived(address,address,uint256[],uint256[],bytes)"))
    bytes4 constant internal ERC1155_BATCH_RECEIVED_SIG = 0xbc197c81;
    // bytes4(keccak256("onERC1155Received(address,address,uint256,uint256,bytes)")) ^ bytes4(keccak256("onERC1155BatchReceived(address,address,uint256[],uint256[],bytes)"))
    bytes4 constant internal INTERFACE_ERC1155_RECEIVER_FULL = 0x4e2312e0;
    //bytes4(keccak256('supportsInterface(bytes4)'))
    bytes4 constant internal INTERFACE_ERC165 = 0x01ffc9a7;

    address public factoryAddress;
    uint256 private totalToMint;

    constructor() public {}

    function setFactoryAddress(address _factoryAddress) external {
        factoryAddress = _factoryAddress;
        totalToMint = 3;
    }




    function supportsInterface(bytes4 interfaceID)
        external
        view
        returns (bool)
    {
        return interfaceID == INTERFACE_ERC165 ||
            interfaceID == INTERFACE_ERC1155_RECEIVER_FULL;
    }


}
