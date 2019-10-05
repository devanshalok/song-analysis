getwd()
setwd("C:/users/aasth/ONeDrive/Desktop")

a <- read.csv("unique_word.csv", na.strings = "", header = T)

#Preprocessing

names(a)
idf <- a$IDF_trimean
lns <- a$lyric_LNS
#unique <- a$unique_words
popu = (idf+lns)/2

a$popularity <- popu
ae <- na.omit(a)
ae <- ae[!duplicated(ae[, c('song','artist')]),]
View(ae)

#amount of missings in each column
#library(VIM)
#aggr(ld2)

write.csv(ae, file = "popularity.csv")

