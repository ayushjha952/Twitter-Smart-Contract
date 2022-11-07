// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;
contract Twitter {

    struct Tweet {
        uint tweetId;
        address author;
        string content;
        uint createdAt;
    }

    struct Message {
        uint messageId;
        string content;
        address from;
        address to;
    }

    struct User {
        address wallet;
        string name;
        uint[] userTweets;
        address[] following;
        address[] followers;
        mapping(address => Message[]) conversations;
    }

    mapping(address => User) public users;
    mapping(uint => Tweet) public tweets;
    uint256 public nextTweetId;
    uint256 public nextMessageId; 

    function registerAccount(string calldata _name) external {
        //Check for empty string input
        bytes memory tempstring = bytes(_name);
        require(tempstring.length > 0, "Name cannot be an empty string");

        //Add new User struct to the users mapping
        User storage user = users[msg.sender];
        user.wallet=msg.sender;
        user.name=_name;
    }

    function postTweet(string calldata _content) external accountExists(msg.sender) {   
        // Using the nextTweetId get that tweet from the tweets mapping 
        Tweet storage tweet = tweets[nextTweetId];
        tweet.author=msg.sender;
        tweet.content=_content;
        tweet.createdAt=block.timestamp;
        tweet.tweetId=nextTweetId;
        User storage user = users[msg.sender];
        user.userTweets.push(nextTweetId);
        nextTweetId++;
    }

    function readTweets(address _user) view external returns(Tweet[] memory) {
        //Initialise userTweetIds, a uint array of tweet Ids that belong to the user
        uint[] memory userTweetIds = users[_user].userTweets;
        //Initialise userTweets, a Tweet array of length userTweetIds
        Tweet[] memory userTweets = new Tweet[](userTweetIds.length);
        //Loop through userTweetIds and add the tweet to userTweets
        for (uint i = 0; i < userTweetIds.length; i++) {
            userTweets[i] = tweets[userTweetIds[i]];
        }
        return userTweets;
    }

    modifier accountExists(address _user) {
        //get a pointer to the struct object from the users mapping, convert the name field into bytes type and check if the length of the bytes variable is not 0.
        User storage user = users[msg.sender];
        bytes memory tempstring = bytes(user.name);
        require(tempstring.length > 0, "This wallet does not belong to any account.");
        _;
    }
    
    function followUser(address _user) external {
        //to get the User struct of the function caller and push _user to the following array.
        User storage me = users[msg.sender];
        me.following.push(_user);
        //to get the User struct of the _user and push msg.sender to the followers array.
        User storage his = users[_user];
        his.followers.push(msg.sender);
    }

    function getFollowing() external view returns(address[] memory)  {
        return users[msg.sender].following;
    }

    function getFollowers() external view returns(address[] memory) {
        return users[msg.sender].followers;
    }

    function getTweetFeed() view external returns(Tweet[] memory) {
        //Initialize an empty Tweet array of length nextTweetId.
        Tweet[] memory allUserTweets = new Tweet[](nextTweetId);
        //get all tweets from the tweets mapping using nextTweetId and add them to the allUserTweets array.
        for (uint256 i = 0; i < nextTweetId; i++) {
            allUserTweets[i] = tweets[i];
        }
        return allUserTweets;
    }

    function sendMessage(address _recipient, string calldata _content) external {
        //Instantiate new Message struct
        Message memory message = Message(nextMessageId, _content, msg.sender, _recipient);
        //Push the new Message struct to the correct Message array of the function caller User struct
        User storage caller = users[msg.sender];    
        caller.conversations[_recipient].push(message);
        //Push the new Message struct to the correct Message array of the recipient User struct
        User storage recipient = users[_recipient];
        recipient.conversations[msg.sender].push(message);
        nextMessageId++;
    }

    function getConversationWithUser(address _user) external view returns(Message[] memory) {
        //Message array, which is the array of messages between the function caller and another user
        User storage caller = users[msg.sender];
        return caller.conversations[_user];
    }
}