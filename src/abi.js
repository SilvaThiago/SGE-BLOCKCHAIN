module.exports = function (){
	return [
    {
      "constant": false,
      "inputs": [
        {
          "internalType": "uint32",
          "name": "auctionType",
          "type": "uint32"
        },
        {
          "internalType": "uint32",
          "name": "auctionStart",
          "type": "uint32"
        },
        {
          "internalType": "uint32",
          "name": "biddingTime",
          "type": "uint32"
        },
        {
          "internalType": "uint256",
          "name": "min",
          "type": "uint256"
        },
        {
          "internalType": "uint32",
          "name": "power",
          "type": "uint32"
        },
        {
          "internalType": "uint32",
          "name": "powerStart",
          "type": "uint32"
        },
        {
          "internalType": "uint32",
          "name": "powerEnd",
          "type": "uint32"
        }
      ],
      "name": "createAuction",
      "outputs": [
        {
          "internalType": "contract Auction",
          "name": "",
          "type": "address"
        }
      ],
      "payable": false,
      "stateMutability": "nonpayable",
      "type": "function"
    }
  ]};