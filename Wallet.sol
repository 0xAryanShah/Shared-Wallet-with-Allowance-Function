// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;
import "./Allowance.sol";
contract simpleWallet is Allowance{
 
    event MoneySent(address indexed _beneficiary,uint _amt);
    event MoneyReceived(address indexed _from,uint _amt);
    
    function withdrawMoney(address payable _to,uint _amt) public ownerOrAllowed(_amt){
        require(_amt<=address(this).balance,"Not Enough Money in the Contract");
        if(msg.sender != owner()){
            reduceAllowance(msg.sender,_amt);
        }
        emit MoneySent(_to,_amt);
        _to.transfer(_amt);
    }

    function renounceOwnership() public override pure{
        revert("Cant Renounce the Ownership of the Contract");
    }

    receive() external payable{
        emit MoneyReceived(msg.sender,msg.value);
    }
}