const hre = require("hardhat");

const main = async()=>{
    const [owner, randomPerson] = await hre.ethers.getSigners();
    const tweet = await hre.ethers.getContractFactory('Tweets');
    const tweetContract = await tweet.deploy();
    await tweetContract.deployed();
    console.log("Contract Deployed at : ", tweetContract.address);
    let t = await tweetContract.connect(randomPerson).addTweet("Hello Ethereum", "https://www.investopedia.com/terms/g/gwei-ethereum.asp");
    await t.wait();
    let t2 = await tweetContract.getTweet(0);
    console.log(t2);
}

const runMain = async()=>{
    try {
        await main();
        process.exit(0);
    } catch (error) {
        console.log(error);
        process.exit(1);
    }
}

runMain();