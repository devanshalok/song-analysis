setwd("C:/users/aasth/ONeDrive/Desktop")
newf <- read.csv("popularity.csv", na.strings = "", header = T)
newf1 <- read.csv("msd_pop.csv", na.strings = "", header = T)

pop <- newf$popularity
uniq <- newf$unique_words

m <- newf1$mode
d <- newf1$duration
sh <- newf1$song_hotttnesss

#Input Processing:
a1 <- readline(prompt="Enter the lyrics of  your song:")
b = strsplit(a1, " ")
words = length(b[[1]])
words
uw = length(unique(b[[1]]))
uw

a2 <- readline(prompt = "Enter the mode of the song(0/1):")
a3 <- readline(prompt = "Enter the duration of the song (in seconds):")
a2 <- as.integer(a2)
a3 <- as.integer(a3)
