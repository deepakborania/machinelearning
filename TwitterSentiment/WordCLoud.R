require(plyr)
require(stringr)
source('~/Documents/DataSets/TwitterSentiment//twitterConnect.R')
tweets <- searchTwitter("beer",lang="en", n=200, cainfo="cacert.pem")
tweets.text = laply(tweets, function(t)t$getText())
clean_text <- clean.text(tweets.text)
tweet_corpus <- Corpus(VectorSource(clean_text))
tdm <- TermDocumentMatrix(tweet_corpus, control=list(removePunctuation = TRUE, 
                                                     stopwords = c("machine", "learning", stopwords("english")), 
                                                     removeNumbers = TRUE, tolower = TRUE))
m = as.matrix(tdm)
word_freqs = sort(rowSums(m), decreasing=TRUE)
dm = data.frame(word=names(word_freqs), freq=word_freqs)
wordcloud(dm$word, dm$freq, random.order=FALSE, colors=brewer.pal(8, "Dark2"),max.words=100)
