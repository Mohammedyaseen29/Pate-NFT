//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";


contract PateNFT is ERC721{
    //error
    uint256 private _tokenIdCounter;
    string private _cool;
    string private _angry;
    enum Mood{
        Cool,
        Angry
    }
    mapping (uint => Mood) private tokenIdToMood;
    constructor(string memory cool,string memory angry) ERC721("PateNFT","PTE"){
        _tokenIdCounter = 0;
        _cool = cool;
        _angry = angry;
    }
    function mintNft() public{
        _safeMint(msg.sender, _tokenIdCounter);
        tokenIdToMood[_tokenIdCounter] = Mood.Cool;
        _tokenIdCounter++;
    }

    function flipMood(uint256 tokenId) public{

        address owner = ownerOf(tokenId);

        _checkAuthorized(owner, msg.sender,tokenId);

        if(tokenIdToMood[tokenId] == Mood.Cool){
            tokenIdToMood[tokenId] = Mood.Angry;
        }
        else {
            tokenIdToMood[tokenId] = Mood.Cool;
        }
    }

    function _baseURI() internal pure override returns(string memory){
        return "data:application/json;base64,";
    }

    function tokenURI(uint tokenId) public view override returns(string memory){
        string memory imageURI;
        if(tokenIdToMood[tokenId] == Mood.Cool){
            imageURI = _cool;
        }
        else {
            imageURI = _angry;
        }
        return string(
            abi.encodePacked(
            _baseURI(),
            Base64.encode(
                    bytes(
                        abi.encodePacked(
                            '{"name":"', 
                            name(),
                            '", "description":"Neon Sentinel is a dynamic cyberpunk guardian NFT that shifts between calm vigilance and blazing fury, reflecting dual moods in a futuristic world.",',
                            '"image":"', 
                            imageURI, 
                            '", "attributes":[',
                                '{"trait_type":"Type","value":"Dynamic NFT"},',
                                '{"trait_type":"Mood","value":"Cool / Angry"},',
                                '{"trait_type":"Background","value":"Neon City / Red Fury"},',
                                '{"trait_type":"Emotion Core","value":"Calm / Rage"},',
                                '{"trait_type":"Eyes","value":"Blue Glow / Red Blaze"},',
                                '{"trait_type":"Armor","value":"ChromeTech Shell"},',
                                '{"trait_type":"State","value":"Passive / Combat"},',
                                '{"trait_type":"Edition","value":"1 of 1"},',
                                '{"trait_type":"Theme","value":"Cyberpunk"}',
                            ']}'
                        )
                    )
                )
            )
        );
    }
}