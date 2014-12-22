require(twitteR)
TwitterOAuth<-function(){
  reqURL <- "https://api.twitter.com/oauth/request_token"
  accessURL <- "https://api.twitter.com/oauth/access_token"
  authURL <- "https://api.twitter.com/oauth/authorize"
  
  consumerKey <- "fAQzLbmLIhgHLnM5RtfXY0PNk"
  consumerSecret <- "FH5x3f4Ttky57MM9pdxkg25decgxm9zGUY94TpIKpj8Ipkj3Dk"
  
  twitCred <- OAuthFactory$new(consumerKey=consumerKey,consumerSecret=consumerSecret,requestURL=reqURL,accessURL=accessURL,authURL=authURL)
  
  download.file(url="http://curl.haxx.se/ca/cacert.pem", destfile="cacert.pem")
  
  twitCred$handshake(cainfo="cacert.pem")
  
  registerTwitterOAuth(twitCred)
}
TwitterOAuth()