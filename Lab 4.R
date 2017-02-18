library(twitteR)
library(ROAuth)
library()
setup_twitter_oauth('JljNxaCg4iRkzLQgDDwhQrZwr', '414zSfszoJn8PvCtPKl6xfl4rluOMEDNKk5C5XJYLE1JkH5PEy', '82876458-eD94mRvi5NzIkqbsxusly9cM9JQ3qAUYAwntGiHcH', '54p14xZbmONeR6aY3irLDRtOMNRTpxbkNIz9ZWZM2azzi') 
tweets<-searchTwitter("VirginAmerica",n=1000, lang="en", since="2016-10-11", until="2016-10-11")
df1=twListToDF(tweets)

df1<-read.csv("Virgin_America_all.csv",stringsAsFactors = FALSE)

df1$text
k<-calculate_score(df1$text)
k<-calculate_total_presence_sentiment(df1$text)
View(k)
View(df1)
df1$senti<-k

require(reshape2)
df1$id2 <- rownames(df1) 
melt(df1$text)



tweets<-searchTwitter("VirginAmerica",n=1000, lang="en", since="2016-10-10", until="2016-10-10")
df2=twListToDF(tweets)

tweets<-searchTwitter("VirginAmerica",n=1000, lang="en", since="2016-10-09", until="2016-10-09")
df3=twListToDF(tweets)

library(graphTweets)

edges <- getEdges(data = df1, tweets = "text", source = "screenName")
edges2 <- getEdges(data = df2, tweets = "text", source = "screenName")
edges3 <- getEdges(data = df3, tweets = "text", source = "screenName")

df4=twListToDF(edges)
write.csv(edges,"VA_full_edges.csv")
write.csv(edges2,"VA_edges_10.csv")
write.csv(edges3,"VA_edges_09.csv")

