// SPDX-License-Identifier: MIT

pragma solidity >=0.6.0 <0.8.0;

//import Open Zepplin contracts
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract NFT is ERC721 {
    using Strings for uint256;
    uint256 public tokenId;
    enum Status{win, lose}
    string public baseExtension = ".json";

    mapping(uint256 => Status) public tokenIdToStatus;
    constructor(string memory _nameOfToken, string memory _tokenSymbol) ERC721(_nameOfToken, _tokenSymbol) public {
        tokenId = 0;
    }
    
    //use the mint function to create an NFT
    function mint()
    public
    returns (uint256)
    {

        
        Status status = Status(tokenId);
        tokenIdToStatus[tokenId] = status;
        _safeMint(msg.sender, tokenId);
        tokenId += 1;
        return tokenId;
    }
    function setTokenURI(uint256 tokenId, string memory _tokenURI) public {
        require(_isApprovedOrOwner(_msgSender(), tokenId), "ERC721: caller is not owner or not approved");
        _setTokenURI(tokenId, _tokenURI);
    }
}

    //the token URI function will contain the logic to determine what URI to show
/*
    function tokenURI(uint256 _tokenId, string memory aUri, string memory bUri) public view virtual override returns (string memory)
    {
        require(
        _exists(_tokenId),
        "ERC721Metadata: URI query for nonexistent token"
        );
        
        //if the block timestamp is divisible by 2 show the aURI
        if (block.timestamp % 2 == 0) {
            return bytes(aUri).length > 0
            ? string(abi.encodePacked(aUri, _tokenId.toString(), baseExtension))
            : "";
        }

        //if the block timestamp is NOT divisible by 2 show the bURI
            return bytes(bUri).length > 0
                ? string(abi.encodePacked(bUri, _tokenId.toString(), baseExtension))
                : "";
    }
}
*/