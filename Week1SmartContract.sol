// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts@4.7.3/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts@4.7.3/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts@4.7.3/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts@4.7.3/utils/Counters.sol";

contract VIpFancyCollection is ERC721, ERC721Enumerable, ERC721URIStorage {
    using Counters for Counters.Counter;
    uint256 MAX_SUPPLY = 10000;
    mapping(address => uint8) private _allowedList;
    uint8 MAX_MINT_ALLOWED = 5;


    Counters.Counter private _tokenIdCounter;

    constructor() ERC721("VIpFancyCollection", "MTK") {}

    function safeMint(address to, string memory uri) public  {
        uint256 tokenId = _tokenIdCounter.current();
        require(tokenId<MAX_SUPPLY,"No NFT Available to Mint");
        require(_allowedList[to]<MAX_MINT_ALLOWED, "You have minted the maximum allowed NFTs");
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
        uint8 X = _allowedList[to];
        _allowedList[to]= X+1;
    }

    // The following functions are overrides required by Solidity.

    function _beforeTokenTransfer(address from, address to, uint256 tokenId)
        internal
        override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId);
    }

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
}
