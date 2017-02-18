library(Rfacebook)
fbauth<-fbOAuth(app_id = "1781322338793152", app_secret = "4aa9b69c52adeaaa17370e86dc0ec86a")
obama<-getPage(page="barackobama", token=fbauth, n = 30,reactions = TRUE)
post<-getPost(post=10154146135246749, n = 3, token=fbauth)
group<-getGroup(group_id=, token, n = 100, since = NULL, until = NULL)
reaction<-getReactions(post=obama$id[1], token=fbauth)
reaction
library(twitteR)
setup_twitter_oauth("JljNxaCg4iRkzLQgDDwhQrZwr", "414zSfszoJn8PvCtPKl6xfl4rluOMEDNKk5C5XJYLE1JkH5PEy", 
"82876458-eD94mRvi5NzIkqbsxusly9cM9JQ3qAUYAwntGiHcH", "54p14xZbmONeR6aY3irLDRtOMNRTpxbkNIz9ZWZM2azzi")
tweets<-searchTwitter(searchString="VirginAmerica",n=5000)
tweets[1]
install.packages("graphTweets")
library(graphTweets)
df=twListToDF(tweets)
write.csv(df,"virgin_america.csv")
edges=getEdges(data=df,tweets="text",source="screenName")
write.csv(edges,file="tweets.csv")
