install.packages("tm")
install.packages("SnowballC")
install.packages("wordcloud")
install.packages("RColorBrewer")
library(tm)
library(SnowballC)
library(wordcloud)
library(RColorBrewer)
document="obama.txt"
text<-readLines(document)
sample<-Corpus(VectorSource(df$message))
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
sample <- tm_map(sample, removeWords, c("and", "can","just")) 
# Remove punctuations
sample <- tm_map(sample, removePunctuation)
#Remove extra white spaces
sample <- tm_map(sample, stripWhitespace)
# Text stemming to extract root words
sample <- tm_map(sample, stemDocument)


View(df)
wordcloud(words = df$word, freq = df$freq, min.freq = 1, max.words=200, random.order=FALSE, rot.per=0.35, colors=brewer.pal(8, "Dark2"))
display.brewer.all()
display.brewer.pal(n=8, name= 'Dark2')
brewer.pal(n=8, name="Dark2")
write.csv(df,file="wordcount.csv")
