install.packages("twitteR")
install.packages("ROAuth")
install.packages("tm")
install.packages("RColorBrewer")
install.packages("sentiment")
install.packages("wordcloud")
library("twitteR")
library("ROAuth")
library("RColorBrewer")
library("wordcloud")
library("tm")
library("sentiment")
# Download "cacert.pem" file
download.file(url="http://curl.haxx.se/ca/cacert.pem",destfile="cacert.pem")

#create an object "cred" that will save the authenticated object that we can use for later sessions
cred <- OAuthFactory$new(consumerKey='ociv7ePzy1B2atYM8063LPMxF',
                         consumerSecret='9zBvvDaiLGggIdyiNKoPi0llVPUiRpehlk8wFlJ1jniAQfIdgJ',
                         requestURL='https://api.twitter.com/oauth/request_token',
                         accessURL='https://api.twitter.com/oauth/access_token',
                         authURL='https://api.twitter.com/oauth/authorize')
cred<-setup_twitter_oauth('ociv7ePzy1B2atYM8063LPMxF', '9zBvvDaiLGggIdyiNKoPi0llVPUiRpehlk8wFlJ1jniAQfIdgJ', access_token= '82876458-Mo28r9Nz09cOfLTgyZcuaT5Ouujsw3yz9ghbZfqIx', access_secret='nCyvvilAxv1mf03JjTLpvlBNKQ1iYg6B8PmDhXh7cpxoA')

# Executing the next step generates an output --> To enable the connection, please direct your web browser to: <hyperlink> . Note:  You only need to do this part once


search.string <- "#PokemonGO"
no.of.tweets <- 1000

tweets <- searchTwitter(search.string, n=no.of.tweets, lang="en")
tweets_txt = sapply(tweets, function(x) x$getText())
tweets_txt = gsub("(RT|via)((?:\\b\\W*@\\w+)+)", "", tweets_txt)
tweets_txt = gsub("@\\w+", "", tweets_txt)
tweets_txt = gsub("[[:punct:]]", "", tweets_txt)
tweets_txt = gsub("[[:digit:]]", "", tweets_txt)
tweets_txt = gsub("http\\w+", "", tweets_txt)
tweets_txt = gsub("[ \t]{2,}", "", tweets_txt)
tweets_txt = gsub("^\\s+|\\s+$", "", tweets_txt)
catch.error = function(x)
{
  # let us create a missing value for test purpose
  y = NA
  # try to catch that error (NA) we just created
  catch_error = tryCatch(tolower(x), error=function(e) e)
  # if not an error
  if (!inherits(catch_error, "error"))
    y = tolower(x)
  # check result if error exists, otherwise the function works fine.
  return(y)
}
tweets_txt = sapply(tweets_txt, catch.error)
tweets_txt = tweets_txt[!is.na(tweets_txt)]
names(tweets_txt) = NULL
tweeta_class_emo = classify_emotion(tweets_txt, algorithm="bayes", prior=1.0)



# Create corpus
corpus=Corpus(VectorSource(tweets_txt))

# Convert to lower-case
corpus=tm_map(corpus,tolower)

# Remove stopwords
corpus=tm_map(corpus,function(x) removeWords(x,stopwords()))

# convert corpus to a Plain Text Document
corpus=tm_map(corpus,PlainTextDocument)

col=brewer.pal(6,"Dark2")
wordcloud(corpus, min.freq=25, scale=c(5,2),rot.per = 0.25,
          random.color=T, max.word=45, random.order=F,colors=col)
