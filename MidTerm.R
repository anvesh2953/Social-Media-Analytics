library(twitteR)
library(ROAuth)

setup_twitter_oauth('JljNxaCg4iRkzLQgDDwhQrZwr', '414zSfszoJn8PvCtPKl6xfl4rluOMEDNKk5C5XJYLE1JkH5PEy', '82876458-eD94mRvi5NzIkqbsxusly9cM9JQ3qAUYAwntGiHcH', '54p14xZbmONeR6aY3irLDRtOMNRTpxbkNIz9ZWZM2azzi') 
tf<-userTimeline("BaahubaliMovie", n=2000)
Bahubali_22<-searchTwitter("@BaahubaliMovie", n=2000, lang="en", since="2016-10-22", until="2016-10-22")
Bahubali_21<-searchTwitter("@BaahubaliMovie", n=2000, lang="en", since="2016-10-21", until="2016-10-21")
df_22<-twListToDF(Bahubali_22)
df_21<-twListToDF(Bahubali_21)
df_user<-twListToDF(tf)
write.csv(df_22,"BB_22.csv")
write.csv(df_21,"BB_21.csv")
write.csv(df_user,"BB_user.csv")

library(graphTweets)

edges2 <- getEdges(data = df_22, tweets = "text", source = "screenName")
edges3 <- getEdges(data = df_21, tweets = "text", source = "screenName")

write.csv(edges2,"BB_edges_22.csv")
write.csv(edges3,"BB_edges_21.csv")

library(twitteR)
library(ROAuth)
setup_twitter_oauth('JljNxaCg4iRkzLQgDDwhQrZwr', '414zSfszoJn8PvCtPKl6xfl4rluOMEDNKk5C5XJYLE1JkH5PEy', '82876458-eD94mRvi5NzIkqbsxusly9cM9JQ3qAUYAwntGiHcH', '54p14xZbmONeR6aY3irLDRtOMNRTpxbkNIz9ZWZM2azzi') 
tf<-userTimeline("BaahubaliMovie", n=2000)
VA_11_3<-searchTwitter("@VirginAmerica", n=5000, lang="en", since="2016-10-24", until="2016-11-03")
df_11_3<-twListToDF(VA_11_3)
write.csv(df_11_3,"VA_11_3.csv")
