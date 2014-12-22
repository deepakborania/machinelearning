library("jsonlite")
train <- fromJSON("~/Documents/Datasets/Random Acts Of Pizza/train.json")
test <- fromJSON("~/Documents/Datasets/Random Acts Of Pizza/test.json")
received_pizza <- train$requester_received_pizza
train_new <- train[,intersect(names(train), names(test))]
train_new$giver_username_if_known[train_new$giver_username_if_known=="N/A"] <- NA
test$giver_username_if_known[test$giver_username_if_known=="N/A"] <- NA

source('~/Documents/DataSets/TwitterSentiment//scoreSentiment.R')

train_request_score <- score.sentiment(train_new$request_text_edit_aware,pos, neg, .progress="text")[,1]
train_new$req_senti_score <- train_request_score
test_request_score <- score.sentiment(test$request_text_edit_aware,pos, neg, .progress="text")[,1]
test$req_senti_score <- test_request_score

train_request_score <- score.sentiment(train_new$request_title,pos, neg, .progress="text")[,1]
train_new$req_title_senti_score <- train_request_score
test_request_score <- score.sentiment(test$request_title,pos, neg, .progress="text")[,1]
test$req_title_senti_score <- test_request_score

#remove vars after calculating their senti score
train_new <- train_new[,-c(1,2,3,4)]
test <- test[,-c(1,2,3,4)]

reqDates <- as.POSIXct(test$unix_timestamp_of_request_utc, origin="1970-01-01", tz="UTC")
test$req_month <- month(reqDates)
reqDates_train <- as.POSIXct(train_new$unix_timestamp_of_request_utc, origin="1970-01-01", tz="UTC")
train_new$req_month <- month(reqDates_train)




train_new$received_pizza<-received_pizza
write.csv(train_new, file="~/Documents/Datasets/Random Acts Of Pizza/train_new.csv")
write.csv(test, file="~/Documents/Datasets/Random Acts Of Pizza/test.csv")