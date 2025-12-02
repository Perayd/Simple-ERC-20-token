// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// If using Remix, you can import directly from GitHub (example uses OpenZeppelin v4.x).
// In a local project use `npm install @openzeppelin/contracts` and import from node_modules instead.
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.9.3/contracts/token/ERC20/ERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.9.3/contracts/access/Ownable.sol";

/// @title SimpleToken — a minimal, upgrade-safe-friendly ERC20 example
/// @notice This contract mints an initial supply to the deployer and allows owner to mint more.
contract SimpleToken is ERC20, Ownable {
    /// @dev initial supply in whole tokens (not wei). We'll multiply by 10**decimals()
    uint256 public constant INITIAL_SUPPLY_TOKENS = 1_000_000; // 1 million

    constructor() ERC20("SimpleToken", "SIM") {
        // mint initial supply to deployer
        _mint(msg.sender, INITIAL_SUPPLY_TOKENS * 10 ** decimals());
    }

    /// @notice Owner-only mint function — keep access restricted!
    /// @param to address to receive minted tokens
    /// @param amount number of tokens in token-wei (i.e., include decimals)
    function mint(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
    }

    /// @notice Convenience: burn tokens from caller
    /// @param amount number of tokens in token-wei (i.e., include decimals)
    function burn(uint256 amount) external {
        _burn(msg.sender, amount);
    }
}
