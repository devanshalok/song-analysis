library(ggplot2,quietly=TRUE)
library(plyr,quietly=TRUE)
library(e1071, quietly=TRUE)
library(randomForest, quietly=TRUE)
library(rpart, quietly=TRUE)

env<-new.env()
env$dt<-read.csv("msd_pop.csv")

#splitting the dataset

test<-0.15
valid<-0.15
train<-0.7
env$nrow<-nrow(env$dt)
cat(paste("Number of rows:",env$nrow,"\n"))

env$sample<-env$train<-sample(env$nrow,train*env$nrow)
env$validate<-sample(setdiff(seq_len(env$nrow),env$train),valid*env$nrow)
env$test<-setdiff(setdiff(seq_len(env$nrow),env$train),test*env$nrow)

#varaible selection

env$inp<-c("loudness","tempo","time_signature","key","mode","duration")
env$num<-c("loudness","tempo","time_signature","key","mode","duration")
env$target<-"popular"
env$ident<-"track_id"
env$ignore<-c("artist_name","title","energy","danceability","song_hotttnesss")

#decision tree

print("Classifying using decision tree...")
env$dtfit<-rpart(popular~.,data=env$dt[env$train,c(env$inp,env$target)],method="class")
print("Finished classifying using Decision Tree")

#svm

print("Classifying using SVM...")
env$svmfit<-svm(popular~.,data=env$dt[env$train,c(env$inp,env$target)])
print("Finished classifying using SVM")

#random forest

print("Classifying using Random Forest...")
env$rffit<-randomForest::randomForest(popular~.,data=env$dt[env$train,c(env$inp,env$target)],ntree=10,mtry=2,importance=TRUE,na.action=randomForest::na.roughfix,replace=FALSE)
print("Finished classifying using Random Forest")

#plot and graphs

print("Obtain the response from the classifyers...")
env$dtpr<-predict(env$dtfit,newdata=na.omit(env$dt[env$test,c(env$inp,env$target)]))
env$svmpr<-predict(env$svmfit,newdata=na.omit(env$dt[env$test,c(env$inp,env$target)]))
env$rfpr<-predict(env$rffit,newdata=na.omit(env$dt[env$test,c(env$inp,env$target)]))

#plot tree

cat(paste("Saving a plot of the decision Tree \n"))
jpeg('pop_dt_plot.jpg')
plot(env$dtfit,uniform=TRUE,main="Classification Tree for popularity")
text(env$dtfit,use.n=TRUE,all=TRUE,cex=.8)
dev.off()

#Plot count of popularity distribution

print("Creating a popularity distribution")
jpeg('popularity_distribution.jpg')
g1<-ggplot(env$dt, aes(x=factor(1),fill=factor(popular)))+geom_bar(width = 1)
plot(g1+coord_polar(theta="y"))
dev.off()
print("Saved popular distribution plot")
