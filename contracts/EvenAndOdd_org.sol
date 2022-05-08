// SPDX-License-Identifier: MIT

pragma solidity >=0.6.0 <0.8.0;

//import Open Zepplin contracts
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Strings.sol";


contract NFT2 is ERC721 {

    using Strings for uint256;

    uint256 private _tokenIds;
    string public baseExtension = ".json";

    //create two URIs. 
    //the contract will switch between these two URIs
    string aUri = "https://ipfs.io/ipfs/QmSJZEUkFzv2G6FX3QqeHAemcjYeLgin5UNi6bPG9DPCst?filename=0-WIN";
    string bUri = "https://ipfs.io/ipfs/Qmd1zsHWSEVw3U4Bj4DAB4LcQ2QqsSVbKp2R2sniozDEMp?filename=1-LOSE";
    
    constructor() ERC721("NAMEOFTOKEN", "TOKENSYMBOL") public {}
    
    //use the mint function to create an NFT
    function mint()
    public
    returns (uint256)
    {
        _tokenIds += 1;
        _mint(msg.sender, _tokenIds);
        return _tokenIds;
    }
    
    //the token URI function will contain the logic to determine what URI to show
    function tokenURI(uint256 tokenId) public view virtual override returns (string memory)
    {
        require(
        _exists(tokenId),
        "ERC721Metadata: URI query for nonexistent token"
        );
        
        //if the block timestamp is divisible by 2 show the aURI
        if (block.timestamp % 2 == 0) {
            return bytes(aUri).length > 0
            ? string(abi.encodePacked(aUri, tokenId.toString(), baseExtension))
            : "";
        }

        //if the block timestamp is NOT divisible by 2 show the bURI
            return bytes(bUri).length > 0
                ? string(abi.encodePacked(bUri, tokenId.toString(), baseExtension))
                : "";
    }
}