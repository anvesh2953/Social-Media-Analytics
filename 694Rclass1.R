install.packages("Rfacebook")
library(Rfacebook)
library(RSentiment)
fbauth<-fbOAuth(app_id = "1781322338793152", app_secret = "4aa9b69c52adeaaa17370e86dc0ec86a")



VA<-getPage(page="VirginAmerica", token=fbauth, n = 2500,reactions = FALSE)

reactions<-getReactions(post=VA$id, token=fbauth)
View(reactions)
write.csv(VA,file="VA_FB_Full.csv")
write.csv(reactions,file="NM_final_lab_react.csv")
View(VA)

post1 <- getPost(post=VA$id[24], n=200, token=fbauth)
View(post1)
write.csv(VA,file="VA_fbfull.csv")

post2 <- getPost(post=VA$id[23], n=200, token=fbauth)
View(post2)
write.csv(post,file="NM_post3_comments.csv")



post <- getPost(post='10152952912534411', n=200, token=fbauth)

df<-read.csv("toppost.csv")

react<-getReactions('10157929474545165', token=fbauth)
View(react)
library(tm)
write.csv(VA,file="VA_lab5.csv")
write.csv(p,file="VA_com_lab5.csv")
vp<-read.csv("VA_posts_lab5.csv");
View(vp)
totalscore<-calculate_total_presence_sentiment (VA$message)
sentiment <- calculate_sentiment(vp$x)
View(sentiment)
View(VA$message)
View(VA)


positives=scan("positive-words.txt", what="character", comment.char=";")
negatives=scan("negative-words.txt", what="character", comment.char=";")

score.sentiment = function(sentences, pos.words, neg.words, .progress='none')
{
  # First, we will use the laply function so that we can get the sentiment scores as an array list.
  # We will store the scores in a new variable called scores   
  
  scores = laply(sentences, function(sentence, pos.words, neg.words) {
    
    # Then, we clean all sentences to replace special characters and punctuations with a space. 
    # gsub() function is good for this cleansing
    
    sentence = gsub('[[:punct:]]', '', sentence)
    sentence = gsub('[[:cntrl:]]', '', sentence)
    sentence = gsub('\\d+', '', sentence)
    
    # next, we convert all text to lower case
    sentence = tolower(sentence)
    
    # We now split sentences into a list of words because we want to match the words to the sentiment words. 
    # We will use str_split function from the stringr package for this 
    # The function detects words from the sentence based on the spaces between words 
    
    wordlist = str_split(sentence, '\\s+')
    
    # We will then extract the separate words from the word list using unlist
    
    words = unlist(wordlist)
    
    # compare the words to the lexicon for the positive and negative words of positive & negative terms
    
    pos.matches = match(words, pos.words)
    neg.matches = match(words, neg.words)
    
    # match function returns TRUE or FALSE. We want to count the number of positive and negative matches
    
    pos.matches = !is.na(pos.matches)
    neg.matches = !is.na(neg.matches)
    
    # In any programming, TRUE is  1 and FALSE is 0. To get the total score we subtract FALSE from TRUE
    
    score = sum(pos.matches) - sum(neg.matches)
    
    return(score)}, pos.words, neg.words, .progress=.progress )
  scores.df = data.frame(score=scores, text=sentences)
  return(scores.df)
}

score=score.sentiment(VA$message,positives,negatives,.progress='text')
View(score) #to view the sentiment scoring for each tweet
write.csv(score,file = "score.csv")
hist(score$score) #to just view the score column


document<- "YOURFILE.txt"
text<-readLines(document)

sample<-Corpus(VectorSource(df$message))
inspect(sample)

df<-read.csv("SW_FB.csv");


toSpace <- content_transformer(function (x , pattern ) gsub(pattern, " ", x))
sample <- tm_map(sample, toSpace, "/")
sample <- tm_map(sample, toSpace, "@")
sample <- tm_map(sample, toSpace, "\\|")

sample <- tm_map(sample, content_transformer(tolower))
# Remove numbers
sample <- tm_map(sample, removeNumbers)
# Remove english common stopwords
sample <- tm_map(sample, removeWords, stopwords("english"))
# Remove your own stop word
# specify your stopwords as a character vector
sample <- tm_map(sample, removeWords, c("blabla1", "blabla2")) 
# Remove punctuations
sample <- tm_map(sample, removePunctuation)
#Remove extra white spaces
sample <- tm_map(sample, stripWhitespace)
# Text stemming to extract root words
sample <- tm_map(sample, stemDocument)

dtm <- TermDocumentMatrix(sample) 
m <- as.matrix(dtm)
v <- sort(rowSums(m),decreasing=TRUE)
df <- data.frame(word = names(v),freq=v)
head(df, 10) #optional step

wordcloud(words = df$word, freq = df$freq, min.freq = 1, max.words=200, scale=c(4,0.1), random.order=FALSE, rot.per=0.35, colors=brewer.pal(8, "Dark2"))
dtm2 <- removeSparseTerms (dtm, sparse = 0.96) #removes words that are in the bottom 95% of dtm
m2 <- as.matrix(dtm2)
#cluster terms
distMatrix <- dist(scale(m2))
fit <- hclust(distMatrix, method = "ward.D2")
plot(fit)
rect.hclust(fit, k=6) 











