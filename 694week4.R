library(twitteR)
library(RCurl) 
library(ROAuth)
library(tm)
library (graphTweets)
library (plyr) #to split, merge data - useful during sentiment analysis
library (stringr) #for handling string(text)-based datasets - useful for sentiment analysis
setup_twitter_oauth('JljNxaCg4iRkzLQgDDwhQrZwr', '414zSfszoJn8PvCtPKl6xfl4rluOMEDNKk5C5XJYLE1JkH5PEy', '82876458-eD94mRvi5NzIkqbsxusly9cM9JQ3qAUYAwntGiHcH', '54p14xZbmONeR6aY3irLDRtOMNRTpxbkNIz9ZWZM2azzi') 
tweets<-searchTwitter("#trump", n=1000, lang="en", since="2016-09-01", until="2016-09-09")
length(tweets)

# user functions - get a particular user, get friends for a particular user, get location of a particular user
user<-getUser('anveshspeaks')
location<-user$getLocation()
friends<-user$getFriends()

#To convert and save the tweets file into csv, you need to first convert the file into a data frame, there are 2 options to do this:
df <- do.call("rbind", lapply(tweets, as.data.frame))
write.csv(df, file="tweets.csv")
#OR
df=twListToDF(tweets)
write.csv(df, file="tweets.csv")

# To retrieve a certain tweet number from the data frame file, you can use
writeLines(df$text[3])

#To retrieve only the text column in a twitter data file, first convert tweets to data frame (df), then convert to Corpus
text<-Corpus(VectorSource(df$text))
             
 #To retrieve and store all the user ID from the tweets as a data frame
userInfo <- lookupUsers(df$screenName)
userIDdf <- twListToDF(userInfo)

count=table(df$screenName)
barplot(count)

# if you want to now plot only those who tweeted more than a certain number of times
#create a subset first, I am using count>5 here. 
countsubset=subset(count,count>5) 

#now plot again, here we are plotting countsubset, cex.names specifies text size in the plot
barplot(countsubset,las=2,cex.names=0.3) 

# In order to search for tweets based on a certain location (geocode), you need to use the longitude and latitude for a location. Use mapdevelopers.com or google maps to find the longitude and latitude for a place of your choice

tweets<-searchTwitter("#Dekalb", n=100, geocode = '41.7565072,-88.1974137, 10mi')

# Note that the geocode parameter uses the longitude, latitude, and radius of interest

             
               