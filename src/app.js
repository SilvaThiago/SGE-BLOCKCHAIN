

const Web3 = require('web3');
const EthereumTx = require('ethereumjs-tx');

// const INFURA_API_KEY ='135f54a4610f4cadb599dde761d10e5f';

const infura = `HTTP://127.0.0.1:7545`;

const web3 = new Web3(new Web3.providers.HttpProvider(infura));

// web3.eth.defaultAccount ='0x68655B94854409D0a33e506Fe8F5ef97c48D3ad0';
web3.eth.defaultAccount = process.argv[2];

const abi = [
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
  ];

// const pk = '31EA2CBF59E7FABC2920B4A4044AFDEE1B538D193AC5EADAFEF015FC33070D39'; 

  const pk = process.argv[3];

// const toadd = 

  //Contract Address
  const address ='0x05CB95Ec6D068a9C0B481B7829Bc85adB8aB7dc2';

  //let myBalanceWei = web3.eth.getBalance(web3.eth.defaultAccount).toNumber()
  //let myBalance = web3.fromWei(myBalanceWei, 'ether')
  antes = Date.now();
  web3.eth.getTransactionCount(web3.eth.defaultAccount, function (err, nonce) {

	// console.log('nonce value is ' + nonce);
	const contract = new web3.eth.Contract(abi, address, {
	from: web3.eth.defaultAccount ,
	gasPrice: 20000000000,
	gas:  6721975,
	});

	

	const functionAbi = contract.methods.createAuction(1, 5000, 500000000, 30, 100, 5000, 500000000).encodeABI();

	var details = {
		"nonce":  nonce,
		"gasPrice": web3.utils.toHex(web3.utils.toWei('20000000000', 'wei')),
		"gas": 6721975,
		"to": address,
		"value":  0,
		"data": functionAbi,
	};

	const transaction = new EthereumTx(details);

	transaction.sign(Buffer.from(pk, 'hex') );

	
	var rawData = '0x' + transaction.serialize().toString('hex');
	// console.log(rawData);

	 // const transactionId = web3.eth.sendRawTransaction(rawData); 
	// console.log(transactionId)

  var duracao_total = 0;
  var antes = 0;
  
  antes = Date.now();
	web3.eth.sendSignedTransaction(rawData)
	.on('transactionHash', function(hash){
				//console.log(['transferToStaging Trx Hash:' + hash]);
	}).on('receipt', function(receipt){
						//console.log(['transferToStaging Receipt:', receipt]);
            duracao_total = Date.now() - antes;
            console.log("Duracao : " + duracao_total);

					}).on('error', console.error)



});


// console.log(abi);
