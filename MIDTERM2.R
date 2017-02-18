library(tm)
library(SnowballC)
library(wordcloud)
library(RColorBrewer)
library(plyr)
library(stringr)

document="before_you_leap.txt"
text<-readLines(document)
sample<-Corpus(VectorSource(text))
inspect(sample)
toSpace <- content_transformer(function (x , pattern ) gsub(pattern, " ", x))
sample <- tm_map(sample, toSpace, "/")
sample <- tm_map(sample, toSpace, "@")
sample <- tm_map(sample, toSpace, "\\|")
#Convert all text to lower case
sample <- tm_map(sample, content_transformer(tolower))
# Remove numbers
sample <- tm_map(sample, removeNumbers)
# Remove english common stopwords
sample <- tm_map(sample, removeWords, stopwords("english"))
# Remove your own stop word
# specify your stopwords as a character vector
sample <- tm_map(sample, removeWords, c("and", "can","just","book","one","like")) 
# Remove punctuations
sample <- tm_map(sample, removePunctuation)
#Remove extra white spaces
sample <- tm_map(sample, stripWhitespace)
# Text stemming to extract root words
sample <- tm_map(sample, stemDocument)

dtm <- TermDocumentMatrix(sample)
a <- as.matrix(dtm)
b <- sort(rowSums(a),decreasing=TRUE)
c <- data.frame(word = names(b),freq=b)
head(c, 10) #optional step

wordcloud(words = c$word, freq = c$freq, min.freq = 3, max.words=200, random.order=FALSE, rot.per=0.35, colors=brewer.pal(8, "Dark2"))
display.brewer.all()
display.brewer.pal(n=8, name= 'Dark2')
brewer.pal(n=8, name="Dark2")

dtm2 <- removeSparseTerms (dtm, sparse = 0.95) #removes words that are in the bottom 95% of dtm
m2 <- as.matrix(dtm2)
#cluster terms
distMatrix <- dist(scale(m2))
fit <- hclust(distMatrix, method = "ward.D2")
plot(fit)
rect.hclust(fit, k=3) #the k=7 specifies the number of clusters/sub-sections in your word associations

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

yourscore=score.sentiment (text, positives, negatives, .progress='text')
View(yourscore)
#you can now create visualizations of your sentiment score
hist(yourscore$score)
