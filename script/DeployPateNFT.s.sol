//SPDX-License-Identifier:MIT

pragma solidity ^0.8.20;

import {Script,console} from "forge-std/Script.sol";
import {PateNFT} from "../src/PateNFT.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract DeployPateNFT is Script{
    function run() external returns(PateNFT){
        string memory coolSvg = vm.readFile("./img/coolNft.svg");
        string memory angrySvg = vm.readFile("./img/angryNft.svg");
        
        vm.startBroadcast();
        PateNFT pateNFT = new PateNFT(svgToImageURI(coolSvg),svgToImageURI(angrySvg));
        vm.stopBroadcast();
        return pateNFT;

    }
    function svgToImageURI(string memory svg) public pure returns(string memory){
        string memory baseURL = "data:image/svg+xml;base64,";
        string memory svgBase64Encoded = Base64.encode(bytes(string(abi.encodePacked(svg))));
        return string(abi.encodePacked(baseURL, svgBase64Encoded));
    }
}