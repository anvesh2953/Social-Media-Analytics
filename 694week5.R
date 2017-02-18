readtext=scan(file="obama.txt",what="character",sep="\n")
library(RSentiment)
total_score<-calculate_total_presence_sentiment(readtext)
senti<-calculate_sentiment(total_score)
View(senti)
sentiscore<-calculate_score(readtext)
View(sentiscore)
df<-data.frame(score=sentiscore,text=readtext)
View(df)

library(tm)
library(plyr)
library(stringr)
tweetdata<-read.csv("@honda tweets.csv")
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

yourscore=score.sentiment (tweetdata$text, positives, negatives, .progress='text')

#you can now create visualizations of your sentiment score
hist(yourscore$score)


