library(twitteR)
library(ROAuth)
library(RSentiment)
library(tm)
library(plyr)
library(stringr)
setup_twitter_oauth('JljNxaCg4iRkzLQgDDwhQrZwr', '414zSfszoJn8PvCtPKl6xfl4rluOMEDNKk5C5XJYLE1JkH5PEy', '82876458-eD94mRvi5NzIkqbsxusly9cM9JQ3qAUYAwntGiHcH', '54p14xZbmONeR6aY3irLDRtOMNRTpxbkNIz9ZWZM2azzi') 
adidas_tweets<-userTimeline('@adidasoriginals', n=30, includeRts=F, excludeReplies=T)
adidasdf<-twListToDF(adidas_tweets)
View(adidasdf)
write.csv(adidasdf,file="adidadtweets.csv")
ad_tweets<-searchTwitter("@adidasoriginals",n=1000,since='2016-09-21',until='2016-09-29')
addf<-twListToDF(ad_tweets)
write.csv(addf,file="addf.csv")
View(addf)


positives<-scan("positive-words.txt",what="character",comment.char=";")
negatives<-scan("negative-words.txt",what="character",comment.char=";")
score.sentiment=function(sentences,pos.words,neg.words,.progress='none'){
  scores=laply(sentences, function(sentence,pos.words,neg.words){
    sentence=gsub('[[:punct:]]','',sentence)
    sentence=gsub('[[:cntrl:]]','',sentence)
    sentence=gsub('\\d+','',sentence)
    sentence=tolower(sentence)
    wordlist=str_split(sentence,'\\s+')
    words=unlist(wordlist)
    pos.matches=match(words,pos.words)
    neg.matches=match(words,neg.words)
    pos.matches=!is.na(pos.matches)
    neg.matches = !is.na(neg.matches)
    score = sum(pos.matches) - sum(neg.matches)
    return(score)
  }, pos.words, neg.words, .progress=.progress )
  
  
  # We will convert the scores into a data frame so that it can be exported to csv or used in any other form
  scores_df = data.frame(score=scores, text=sentences)
  return(scores_df) }

yourscore=score.sentiment (addf$text, positives, negatives, .progress='text')
hist(yourscore$score)
