milsongs<-read.csv("million song normalized.csv",header=TRUE)

#Removing duplicates
milsongs<-milsongs[!duplicated(milsongs[,c('artist_name','title')]),]

#just checking
ncol(milsongs)
sum(is.na(milsongs$song_hotttnesss))
milsongs[duplicated(milsongs[,c('artist_name','title')])]

#Sort data by hotness
print("Sorting dataset by hottnesss")
milsongs<-na.omit(milsongs[order(-milsongs$song_hotttnesss),])

#Insert new value with the most popular songs as 1, rest 0
print("Adding new variable, popular")

#Take top 25% of the hottest songs as popular
n=25
milsongs$popular<-ifelse(milsongs$song_hotttnesss<quantile(milsongs$song_hotttnesss,prob=1-n/100),0,1)
print(paste("Num samples:",nrow(milsongs)))

numUnPop<-length(milsongs$popular[milsongs$popular==0])
numPop<-length(milsongs$popular[milsongs$popular==1])
print(paste("Num Popular:",numPop,"Num unPopular:",numUnPop))

#Save dataset
print("Saving the new popular dataset")
write.csv(milsongs,"msd_pop.csv")
print("Saved!")
