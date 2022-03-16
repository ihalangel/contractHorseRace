// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract Horses is ERC721, ERC721Enumerable, ERC721URIStorage, Pausable, Ownable, ERC721Burnable {
    using Counters for Counters.Counter;
      using Strings for uint256;
 //address payable owner;
    event NewHorse(string name, uint dna, uint hb1, uint hb2, uint hb3,  uint health, uint racelimit, uint monta);
   /** event TraineHorse
    event */

   error InvalidAmount();
   error NotOwner();

     
    uint  dnaDigits = 14;
    uint  dnaModulus = 10 ** dnaDigits;
    uint lvlDigits= 2;
    uint lvlDigits2= 4;
    uint  lvlget25= (10 ** lvlDigits) / 4;
    uint  lvlget00= 10 ** lvlDigits;
    uint  lvlget0000= 10 ** lvlDigits2;
    uint  eated = 0; 
    
    uint  pricelv1=5 ether;
    uint  pricelv2=3 ether;
    uint  pricelv3=2 ether;
    uint  pricelv4=1000000000000000000;
    uint  pricelv5=0.5 ether;
    uint256 public maxSupplyLv1 = 2;
    uint256 public maxSupplyLv2 = 3;
    uint256 public maxSupplyLv3 = 5;
    uint256 public maxSupplyLv4 = 5;
    uint256 public maxSupplyLv5 = 5;
    uint256 public maxSupplyLv6 = 5;
    uint256 public suplylvl1= 0;
    uint256 public suplylvl2= 0;
    uint256 public suplylvl3= 0;
    uint256 public suplylvl4= 0;
    uint256 public suplylvl5= 0;
    
    
 struct Races {
    uint winners;
    uint continues;
    uint skill;
    uint lastrace;//tine
    bool claim;
    uint[] raced;
  }


 struct  StatsGen{
 uint dna;
 uint dad;
 uint mom;
 uint birthdate;
 uint generation;
 }
  
struct  Stats{
   uint _hb1;
   uint _hb2;
   uint _hb3;
   uint lastfed; //tiempo de ultima comida
   uint health;  //Puntos de salud
   uint racelimit;
   uint monta;}
    
struct Horse {
        string name;
        uint hb1;
        uint hb2;
        uint hb3;
        StatsGen statsGen;
        Stats stats;
        Races races;   }

    Horse[] public horses;

    Counters.Counter private _tokenIdCounter;

    constructor() ERC721("MyToken", "MTK") {}

    function _baseURI() internal pure override returns (string memory) {
        return "https//www.polh.com/";
    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function safeMint(string calldata _name) public payable {
        uint valor= msg.value;
        uint hbx = _lvlbuyer(valor);
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(msg.sender, tokenId);
        _createminthorse(_name,hbx);
        
    }

      function _createminthorse(string memory _name,uint _hbx) internal {
        uint randDna = _gRamDna(_name);
        uint health = 100;
        uint monta = (randDna % lvlget00) + 25;
        uint hb1 = (_hbx + _gRamLv(_name));
        uint hb2 = (_hbx + _gRamLv("polka"));
        uint hb3 = (_hbx + _gRamLv("horse"));     
        uint racelimit= (randDna % lvlget0000) /2 +1000;
        Stats memory stats=Stats({_hb1:0 , _hb2:0 , _hb3:0, lastfed:block.timestamp, health:100,racelimit:racelimit ,monta:monta});
        StatsGen memory statsGen=StatsGen({ dna:0 , dad:0 , mom:0, birthdate:block.timestamp, generation:0});
        Races memory races= Races({ winners:0 , continues:0 ,skill:0,lastrace:block.timestamp ,claim: false, raced: new uint256[](0) });
        horses.push(Horse( _name, hb1, hb2, hb3,statsGen, stats, races));
        emit NewHorse(_name,randDna, hb1, hb2, hb3, health, racelimit, monta);
    }


    function _beforeTokenTransfer(address from, address to, uint256 tokenId)
        internal
        whenNotPaused
        override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    // The following functions are overrides required by Solidity.

    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }

    //Mette

  
    
    function _gRamDna(string memory _str) private view returns (uint) {
        uint rand = uint(keccak256(abi.encodePacked(_str , block.timestamp)));
        return rand % dnaModulus;
    }
    
    
    function _gRamLv(string memory _str) private view returns (uint) {
       uint rand = uint(keccak256(abi.encodePacked(_str, block.timestamp)));
        return rand % lvlget25;
        
    }               

    function _lvlbuyer(uint _value) internal returns (uint) {
       if (_value == pricelv1){
         require(maxSupplyLv1 > suplylvl1,"Items Sold"); 
           suplylvl1 = suplylvl1+1;
    
         return (175);    
         } 
         else if(_value== pricelv2){require(maxSupplyLv2 > suplylvl2,"Items Sold");
          suplylvl2 = suplylvl2+1;
         return (150);     
          }
        else if(_value== pricelv3){require(maxSupplyLv3 > suplylvl3,"Items Sold");
         suplylvl3 = suplylvl3+1;
         return (125);     
          }
        else if(_value== pricelv4){require(maxSupplyLv4 > suplylvl4,"Items Sold");
         suplylvl4 = suplylvl4+1;
         return (100);     
          }
        else if(_value==pricelv5){require(maxSupplyLv5 > suplylvl5,"Items Sold");
         suplylvl5 = suplylvl5+1;
         return (75);     
          } 
          revert InvalidAmount();
        
    }
    
    function _getStructRace(uint _tokenId) view public returns(uint winners,uint continues, uint skill){
    winners=horses[_tokenId].races.winners;
    continues=horses[_tokenId].races.continues;
    skill=horses[_tokenId].races.skill;
    }


    function _GetStructStastGen(uint _tokenId) view public returns(uint dna,uint dad, uint mom,uint birthdate, uint generation){
     dna=horses[_tokenId].statsGen.dna;
     dad=horses[_tokenId].statsGen.dad;
     mom=horses[_tokenId].statsGen.mom;
     birthdate=horses[_tokenId].statsGen.birthdate;
     generation=horses[_tokenId].statsGen.generation;

   }

     function _GetStructStast(uint _tokenId) view public returns(uint _hb1,uint _hb2, uint _hb3,uint lastfed, uint health, uint racelimit, uint monta){
       Horse storage p = horses[_tokenId];
       return (p.stats._hb1, p.stats._hb2, p.stats._hb3, p.stats.lastfed,p.stats.health,p.stats.racelimit,p.stats.monta); 
     
     /*_hb1=horses[_tokenId].stats._hb1;
     _hb2=horses[_tokenId].stats._hb2;
     _hb3=horses[_tokenId].stats._hb3;
     lastfed=horses[_tokenId].stats.lastfed;
     health=horses[_tokenId].stats.health;
     racelimit=horses[_tokenId].stats.racelimit;
     monta=horses[_tokenId].stats.monta;*/
     }

    function _feedHorse(uint _tokenId) public onlyOwner{
      horses[_tokenId].stats.lastfed=block.timestamp;
      uint health=horses[_tokenId].stats.health;
      horses[_tokenId].stats.health=health + 5;
        
     }

     function  _trainHorse(uint _tokenId) public {
     address owner = ERC721.ownerOf(_tokenId);
     require(_msgSender() == owner,"caller is not owner");
     horses[_tokenId].stats._hb1=5;
    }


   function _getRacesHorse(uint _tokenId, uint) public view returns(uint[] memory races) {
         Horse storage p = horses[_tokenId];
         return (p.races.raced);     
    }

 //  function _postArrival(uint _tokenId, uint carrera, uint_Arrival, uint _rewards);
     
 
}