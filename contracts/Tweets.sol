//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract Tweets{
    address public owner;
    uint256 private count;
    constructor (){
        owner = msg.sender;
        count = 0;
        console.log("Owner of Contract", owner);
    }
    struct tweet{
        address tweeter;
        string mesg;
        string img;
        uint256 id;
    }
    event tweetCreated(
        address tweeter,
        string mesg,
        string img,
        uint256 id
    );

    mapping(uint256 => tweet) tweets;

    function addTweet(string memory mesg , string memory img) public payable {
        require(msg.value<10, "Insufficient Balance");
        tweet storage newTweet = tweets[count];
        newTweet.tweeter = msg.sender;
        newTweet.mesg = mesg;
        newTweet.img = img;
        newTweet.id = count;
        count++;
        address randomPerson = msg.sender;
        console.log("Value tweeter Have", randomPerson.balance);
        payable(owner).transfer(msg.value);
        console.log("Value Owner Have", owner.balance);
        console.log("Value tweeter Have", randomPerson.balance);
        emit tweetCreated(
            newTweet.tweeter,
            newTweet.mesg,
            newTweet.img,
            newTweet.id
        );
    }

    function getTweet(uint256 id) public view returns(tweet memory){
        require(id<count,"Not Tweeted yet");
        tweet storage t = tweets[id];
        return t;
    }

}