# **Twitter-Smart-Contract**
 Creating a smart contract that enables certain functionalities in Twitter.

## **State Variables**

- `Tweet` - This is a struct that contains information regarding a  tweet

- `User` - This is a struct that contains information regarding a user. In it is userTweets, a uint array containing the tweetIds of the Tweet structs that belong to this user and also address arrays and a mapping of addresses to message arrays

- `users` - This is a mapping that maps addresses to User structs. A new wallet address is mapped to a User struct whenever a user registers for an account

- `tweets` - This is a mapping that maps tweetIds to Tweet structs

- `nextTweetId` - This refers to the tweetId of the next Tweet. 
Everytime a new Tweet is created, this should be incremented by 1

- `Message` - This is a struct that contains information regarding a message

- `nextMessageId` - This refers to the messageId of the next Message. Everytime a new Message is created, this should be incremented by 1

## **Functionalities Implemented**

-  `registerAccount()` 
   
   The purpose of this function is to register an account using the wallet address that calls the function. The function takes in 1 input parameter - a string, which will be the name of the account.

- `accountExists()`
   
   This modifier does one thing - it checks if a wallet has already signed up for an account. This modifier takes in an input parameter of type address and checks if that specific address has already been registered in the users mapping.

- `postTweet()`
   
   The purpose of this function is, well, to post a Tweet! 
   In this function, we will add a new Tweet struct to the tweets mapping.

-  `readTweets()`
   
   This function’s job is to return an array of tweet structs that belong to a particular user.

- `followUser()`
   
   This function allows the user who called the function to follow another user. The function takes in one input parameter - an address, which is the address of the user that the caller of the function intends to follow.

- `getFollowing()`
   
   When this function is called, it should return the following array of the function caller.

- `getFollowers()`
  
  When this function is called, it should return the followers array of the function caller.

- `getTweetFeed()`
   
   It’ll return a Tweet array of ALL tweets in chronological order, i.e. index 0 of the returned array refers to the Tweet with tweetId = 0.

- `sendMessage()`
   
   The function takes as input two parameters - an address and a string. The address refers to the user that the function caller intends to send the message to and the string refers the content of the message.

- `getConversationWithUser()`
   
   This function is relatively simple, it takes as input only one parameter - an address. This function returns a Message array, which is the array of messages between the function caller and another user, which is the address specified in the input parameter.
