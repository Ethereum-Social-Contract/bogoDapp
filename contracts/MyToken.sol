// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "./ERC20.sol";
import "./Ownable.sol";

contract MyToken is ERC20, Ownable {
    address public arbitrator;

    constructor(address _arbitrator) ERC20('Trillion Dollar Token', '4COMMA') {
        arbitrator = _arbitrator;
    }

    function compensateTheft(address thief, address rightfulOwner, uint256 amount) external {
        require(msg.sender == arbitrator);
        _transfer(thief, rightfulOwner, amount);
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }
}

