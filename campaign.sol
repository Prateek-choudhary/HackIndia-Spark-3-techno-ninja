//SPDX-License-Identifier: Unlicensed

pragma solidity >0.7.0 <=0.9.0;

contract CampaignFactory{
  address[] public deployedCampaigns;

  event campaignCreated(
    string title,
    uint requiredAmount,
    address indexed owner,
    address campaignAddress,
    string imgURI,
    uint indexed timestamp,
    string indexed category
  );

  function createCampaign(
    string memory Campaigntitle,uint requiredCampaignAmount,
    string memory imgURI,
    string memory category,
    string memory storyURI) public
  {
      Campaign newCampaign = new Campaign(Campaigntitle,
      requiredCampaignAmount,
      imgURI, 
      storyURI);
      
      deployedCampaigns.push(address(newCampaign));

      emit  campaignCreated(Campaigntitle,
      requiredCampaignAmount,
      msg.sender, 
      address(newCampaign),
      imgURI,
      block.timestamp,
      category);
  }
   
}

contract Campaign{
   string public title;
   uint public requiredAmount;
   string public image;
   string public story;
   address payable public owner;
   uint public receivedAmount;

   event donate(address indexed donar,uint indexed  amount,uint indexed timestamp);

   constructor(
   string memory Campaigntitle, 
   uint requiredCampaignAmount,
   string memory imgURI,
   string memory storyURI
   ){
     title = Campaigntitle;
     requiredAmount = requiredCampaignAmount;
     image = imgURI;
     story = storyURI;
     owner = payable(msg.sender);
   }

   function donatehere() public payable{
      require(requiredAmount > receivedAmount, "required amount fullfilled");
     owner.transfer(msg.value);
     receivedAmount += msg.value;
     emit donate(msg.sender,msg.value,block.timestamp);
   }
}

