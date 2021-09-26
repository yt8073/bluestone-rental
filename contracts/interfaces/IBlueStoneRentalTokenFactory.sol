pragma solidity =0.8.7;

/// @title The interface for the BlueStone Rental token factory
/// @notice The BlueStone Rental token factory creates and generates rental tokens from original NFTs
interface IBlueStoneRentalTokenFactory {

    /// @notice Create a rental token contract for an original NFT
    /// @param nft The contract address of the the original NFT
    /// @param userLimit The max number of users for the rental token
    /// @return The contract address of the rental token for the original NFT
    function createRentalToken(address nft, uint256 userLimit) external returns (address);

    /// @notice Lock an original NFT and generate a rental token
    /// @param nft The contract address of the the original NFT
    /// @param tokenId The token ID of the original NFT
    /// @param to The address the rental token will be transferred to
    /// @return rentalToken The contract address of the rental token
    /// @return rentalTokenId The token ID of the rental token
    /// @dev Require the rental token contract for the original NFT exists
    function generateRentalToken(
        address nft,
        uint256 tokenId,
        address to
    ) external returns (address rentalToken, uint256 rentalTokenId);
}
