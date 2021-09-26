pragma solidity =0.8.7;

/// @title The interface for the BlueStone Rental token
/// @notice The BlueStone Rental token extends the original NFT with rental ability
interface IBlueStoneRentalToken {

    /// @notice Return the address of the original NFT
    /// @return The address of the original NFT
    function originalTokenAddress() external view returns (address);

    /// @notice Return the max number of users for the rental token
    /// @return The max number of users for the rental token
    function userLimit() external view returns (uint256);

    /// @notice Add a user to the rental token
    /// @param tokenId The ID of the rental token
    /// param user The user who will be granted the user access of the rental token to
    function addUser(uint256 tokenId, address user);

    /// @notice Revoke a user from the rental token
    /// @param tokenId The ID of the rental token
    /// param user The user whose the user access of the rental token will be revoked
    function revokeUser(uint256 tokenId, address user);

    /// @notice Check if an address has user access of the rental token
    /// @param tokenId The ID of the rental token
    /// @param user The user who will be checked against the user access of the rental token
    /// @return True if the address has user access to the rental token; otherwise, false
    function isUser(uint256 tokenId, address user) external view returns (bool);

}
