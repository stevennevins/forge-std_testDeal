// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import {ERC20} from "solmate/tokens/ERC20.sol";
import {ERC721} from "solmate/tokens/ERC721.sol";
import {ERC1155} from "solmate/tokens/ERC1155.sol";

import {IERC20} from "forge-std/interfaces/IERC20.sol";
import {IERC721} from "forge-std/interfaces/IERC721.sol";
import {IERC1155} from "forge-std/interfaces/IERC1155.sol";

contract MockERC20 is ERC20("", "", 18) {}

contract MockERC721 is ERC721("", "") {
    function tokenURI(uint256) public pure override returns (string memory) {
        return "";
    }
}

contract MockERC1155 is ERC1155 {
    function uri(uint256) public pure override returns (string memory) {
        return "";
    }
}

contract DealTokensTest is Test {
    IERC20 paymentToken;
    IERC721 nft;
    IERC1155 edition;

    function setUp() public {
        nft = IERC721(address(new MockERC721()));
        edition = IERC1155(address(new MockERC1155()));
        paymentToken = IERC20(address(new MockERC20()));
    }

    function testDealERC20() public {
        deal(address(paymentToken), address(this), 100 ether);

        assertEq(paymentToken.balanceOf(address(this)), 100 ether);
    }

    function testDealERC721() public {
        dealERC721(address(nft), address(this), 1);
        assertEq(nft.balanceOf(address(this)), 1);
    }

    function testDealERC1155() public {
        dealERC1155(address(edition), address(this), 0, 100);
        assertEq(edition.balanceOf(address(this), 0), 100);
    }
}
