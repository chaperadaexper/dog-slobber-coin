// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract Token {
	string public name;
	string public symbol;
	// Decimals
	uint256 public decimals = 18;
	// Total supply
	uint256 public totalSupply;

	// Track Balances
	mapping(address => uint256) public balanceOf;
	mapping(address => mapping(address => uint256)) public allowance;
	// Send Tokens
	event Transfer(
		address indexed from, 
		address indexed to, 
		uint256 value
		);
	event Approval(
		address indexed owner, 
		address indexed spender, 
		uint256 value
		);

	constructor(
		string memory _name,
		string memory _symbol,
		uint256 _totalSupply
		) 
	{
		name = _name;
		symbol = _symbol;
		totalSupply = _totalSupply * (10**decimals);
		balanceOf[msg.sender] = totalSupply;

	}

	function transfer(address _to, uint256 _value) 
		public 
		returns (bool success) 
	{
		return _transfer(msg.sender, _to, _value);
		// return true;
	}

	function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
		// Check approval
		require(_value <= allowance[_from][msg.sender]);
		// Reset allowance
		allowance[_from][msg.sender] = allowance[_from][msg.sender] - _value;
		// Send tokens
		return _transfer(_from, _to, _value);

	}

	function _transfer(address _from, address _to, uint256 _value) internal returns (bool success) {
		// Require sender has enough tokens to send
		require(balanceOf[_from] >= _value);
		require(_to != address(0));
		

		// Deduct from sender, credit to receiver
		balanceOf[_from] = balanceOf[_from] - _value;
		balanceOf[_to] = balanceOf[_to] + _value;

		// Emit event
		emit Transfer(_from, _to, _value);
		
		return true;
	}

	function approve(address _spender, uint256 _value) 
		public 
		returns (bool success) 
	{
		require(_spender != address(0));
		allowance[msg.sender][_spender] = _value;
		emit Approval(msg.sender, _spender, _value);
		return true;

	}

}
