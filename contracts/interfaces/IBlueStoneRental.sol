pragma solidity =0.8.7;

/// @title The interface for the BlueStone Rental contract
/// @notice The BlueStone Rental contract implements the main features, e.g. list, un-list, rent, etc.
interface IBlueStoneRental {

    /// @notice List an NFT for renting out
    /// @param nft The original NFT contract
    /// @param tokenId The ID of the NFT to rent out
    /// @param minRentalDays The minimum number of days for each rental
    /// @param maxRentalDays The maximum number of days for each rental
    /// @param rentCurrency The acceptable currency for rent payment
    /// @param dailyRent The daily amount of rent
    /// @return rentalToken The contract address of the rental token
    /// @return rentalTokenId The token ID of the rental token
    /// @dev Lock the original NFT and generate a rental token using the Rental Token Factory.
    ///      Make sure the ownership of the rental token is the rental contract, NOT the caller.
    function list(
        address nft,
        uint256 tokenId,
        uint256 minRentalDays,
        uint256 maxRentalDays,
        address rentCurrency,
        uint256 dailyRent
    ) external returns (address rentalToken, uint256 rentalTokenId);

    /// @notice Delist an original NFT so that no more borrower can rent the corresponding rental token
    ///         from now on, but the existing rentals will stay valid till the end of the lease
    /// @param nft The original NFT contract
    /// @param tokenId The ID of the NFT to rent out
    /// @dev Make sure the caller is the original owner of the original NFT
    function delist(address nft, uint256 tokenId) external;

    /// @notice withdraw the original NFT from the rental contract when the NFT is not currently rented out
    /// @param nft The original NFT contract
    /// @param tokenId The ID of the NFT to rent out
    /// @dev Make sure the caller is the original owner of the original NFT and the NFT is not
    ///      currently rented out. Then transfer the NFT and the remaining rent to the caller
    function withdrawNFT(address nft, uint256 tokenId) external;

    /// @notice Rent a listing NFT and get the user access of the corresponding rental token
    /// @param nft The original NFT contract
    /// @param tokenId The ID of the NFT to rent
    /// @param rentalPeriod The number of days for this rental
    /// @param prepaidRent The amount of prepaid rent
    /// @return rentalToken The contract address of the rental token
    /// @return rentalTokenId The token ID of the rental token
    /// @dev Make sure the number of current user is less than the user limit.
    ///      Make sure the prepaid rent >= daily rent * min rental days
    function rent(
        address nft,
        uint256 tokenId,
        uint256 rentalDays,
        uint256 prepaidRent
    ) external returns (address rentalToken, uint256 rentalTokenId);

    /// @notice Borrower pays more rent before the remaining rent is running out
    /// @param nft The original NFT contract
    /// @param tokenId The ID of the original NFT
    /// @param borrower The address of the borrower whom the rent is paid for
    /// @param rent The amount of rent to pay
    /// @return The remaining rent for this rental
    function payRent(address nft, uint256 tokenId, address borrower, uint256 rent) external returns (uint256);

    /// @notice Return the remaining rent for a rental
    /// @param nft The original NFT contract
    /// @param tokenId The ID of the original NFT
    /// @param borrower The address of the borrower
    /// @return The remaining rent for this rental
    function remainingRent(address nft, uint256 tokenId, address borrower) external view returns (uint256);

    /// @notice The NFT owner collects the rent of a listing NFT
    /// @param nft The original NFT contract
    /// @param tokenId The ID of the original NFT
    function collectRent(address nft, uint256 tokenId) external;
}
