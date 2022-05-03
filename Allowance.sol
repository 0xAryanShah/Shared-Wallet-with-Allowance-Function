// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/math/SafeMath.sol";

contract Allowance is Ownable{
    using SafeMath for uint;
    event AllowanceChanged(address indexed _forwho,address indexed _bywhom,uint _oldamt,uint _newamt);
    mapping(address=>uint) public allowance;

    modifier ownerOrAllowed(uint _amt){
        require(msg.sender == owner() || allowance[msg.sender]>=_amt,"You are not Allowed");
        _;
    }

    function addAllowance(address _whom,uint _amt) public onlyOwner{
        emit AllowanceChanged(_whom,msg.sender,allowance[_whom],_amt);
        allowance[_whom]=_amt;
    }

    function reduceAllowance(address _who,uint _amt) internal {
        emit AllowanceChanged(_who,msg.sender,allowance[_who],allowance[_who].sub(_amt));
        allowance[_who]= allowance[_who].sub(_amt);
    }

}