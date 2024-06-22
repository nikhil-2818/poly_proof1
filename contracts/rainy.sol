// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import "erc721a/contracts/ERC721A.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract rainy is ERC721A, Ownable{

    mapping (uint => string) promptUsed;
    
    constructor() Ownable(msg.sender) ERC721A("Rainy", "RNY") {
        promptUsed[0] = "Pixelated image of a city with mountains during rainy weather.";
        promptUsed[1] = "Pixelated image of a chinese garden during rainy weather.";
        promptUsed[2] = "Pixelated image of a beach during rainy weather.";
        promptUsed[3] = "Pixelated image of a train stop in Japan during rainy weather.";
        promptUsed[4] = "Pixelated image of London market during rainy weather.";
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return 'https://chocolate-holy-whitefish-968.mypinata.cloud/ipfs/QmZPrA23efzZaFJvAsxugVnU1h21KRnb34LeEVZG5E2APF/?pinataGatewayToken=ReK_pW65exe6KenmZrwvpJ2EeZ2lB8Fsf_EPzCwFQ1aWm3X9u8er-OexRCZAR0Ep';
    }

    function whatPromptUsed(uint _tokenId) public view returns (string memory) {
        require (_tokenId < 5, "Invalid Token ID.");
        return promptUsed[_tokenId];
    }

    function mintFor(address _for, uint _qty) public payable onlyOwner {
        require(msg.value > (_qty * (0.05 ether)), "Not enough token sent.");
        require((_numberMinted(_for) + _qty) <= 2, "You can't mint more than 2.");
        _mint(_for, _qty);
    }

    function _sequentialUpTo() internal view virtual override returns (uint256) {
        return 4;
    }

    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        if (!_exists(tokenId)) _revert(URIQueryForNonexistentToken.selector);

        string memory baseURI = _baseURI();
        return bytes(baseURI).length != 0 ? string(abi.encodePacked(baseURI, _toString(tokenId), '.json')) : '';
    }

}