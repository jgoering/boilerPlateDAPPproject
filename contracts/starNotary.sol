pragma solidity ^0.4.23;

import 'openzeppelin-solidity/contracts/token/ERC721/ERC721.sol';

contract StarNotary is ERC721 {

    struct Star {
        string name;
    }
    function name() external pure returns (string) {
        return "JG star registry";
    }

    function symbol() external pure returns (string) {
        return "JGSR";
    }

    mapping(uint256 => Star) public tokenIdToStarInfo;
    mapping(uint256 => uint256) public starsForSale;

    function createStar(string _name, uint256 _tokenId) public {
        Star memory newStar = Star(_name);

        tokenIdToStarInfo[_tokenId] = newStar;

        _mint(msg.sender, _tokenId);
    }

// Add a function lookUptokenIdToStarInfo, that looks up the stars using the Token ID, and then returns the name of the star.

//

    function lookUptokenIdToStarInfo(uint256 _tokenId) public view returns (string) {
        return tokenIdToStarInfo[_tokenId].name;
    }

    function putStarUpForSale(uint256 _tokenId, uint256 _price) public {
        require(ownerOf(_tokenId) == msg.sender);

        starsForSale[_tokenId] = _price;
    }

    function exchangeStars(uint256 _firstTokenId, uint256 _secondTokenId) public {
        address owner1 = ownerOf(_firstTokenId);
        address owner2 = ownerOf(_secondTokenId);

        _removeTokenFrom(owner1, _firstTokenId);
        _addTokenTo(owner2, _firstTokenId);
        _removeTokenFrom(owner2, _secondTokenId);
        _addTokenTo(owner1, _secondTokenId);
    }
    function buyStar(uint256 _tokenId) public payable {
        require(starsForSale[_tokenId] > 0);

        uint256 starCost = starsForSale[_tokenId];
        address starOwner = ownerOf(_tokenId);
        require(msg.value >= starCost);

        _removeTokenFrom(starOwner, _tokenId);
        _addTokenTo(msg.sender, _tokenId);

        starOwner.transfer(starCost);

        if(msg.value > starCost) {
            msg.sender.transfer(msg.value - starCost);
        }
        starsForSale[_tokenId] = 0;
      }

    function transferStar(address _newOwner, uint256 _tokenId) public {
        require(ownerOf(_tokenId) == msg.sender);
        _removeTokenFrom(msg.sender, _tokenId);
        _addTokenTo(_newOwner, _tokenId);
    }

}
