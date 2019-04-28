library(ggplot2)
library(plyr)
library(rpart,quietly=TRUE)
#library(e1071,quietly=TRUE)
library(randomForest,quietly=TRUE)

env<-new.env()

env$data<-read.csv(file="msd_year.csv",header=TRUE)

#splitting of dataset
test<-0.15
valid<-0.15
train<-0.7
env$nrow<-nrow(env$data)
print(paste("Number of rows:",env$nrow,"\n"))

env$sample<-env$train<-sample(env$nrow,train*env$nrow)
env$validate<-sample(setdiff(seq_len(env$nrow),env$train),valid*env$nrow)
env$test<-setdiff(setdiff(seq_len(env$nrow),env$train),test*env$nrow)

#Choose variables

env$inp<-c("loudness","tempo","time_signature","key","mode","duration")
env$num<-c("loudness","tempo","time_signature","key","mode","duration")
env$target<-"decade"
env$ident<-"track_id"

#graphs and plots

print("Creating a year distribution pie")
jpeg('year_distribution.jpg')
g1<-ggplot(env$data, aes(x=factor(1),fill=factor(decade)))+geom_bar(width=1)
plot(g1+coord_polar(theta="y"))
dev.off()
print("Saved year distribution plot")

#Plot correlation bw loudness and year
print("Creating a correlation plot between loudness and year")
jpeg('loudness_year.jpg')
g<-ggplot(env$data, aes(x=decade,y=loudness))
plot(g+geom_violin(alpha=0.5,color="gray")+geom_jitter(alpha=0.5,aes(color=decade),position=position_jitter(width = 0.1))+coord_flip())

dev.off()
print("Saved loudness and year correlation")

#Plot correlation bw duration and year
print("Creating a correlation plot between duration and year")
jpeg('duration_year.jpg')
g<-ggplot(env$data, aes(x=decade,y=duration))

plot(g+geom_violin(alpha=0.5,color="gray")+geom_jitter(alpha=0.5, aes(color=decade),position = position_jitter(width = 0.1))+coord_flip())
dev.off()
print("Saved duration and year correlation")

                                                     #Analysis 

#Decision Tree model

print("Classifying a decision tree")
env$datafit<-rpart(decade~.,data=env$data[env$train,c(env$inp,env$target)],method="class")

# SVM

print("Classifying using SVM...")
env$svmfit<-svm(decade~.,data=env$data[env$train,c(env$inp,env$target)])
print("Finished classifying using SVM")

# Random Forest

print("Classifying using Random Forest...")
env$rffit<-randomForest::randomForest(decade~.,data=env$data[env$train,c(env$inp,env$target)],ntree=10,mtry=2,importance=TRUE,na.action=randomForest::na.roughfix,replace=FALSE)

print("Finished classifying using Random Forest")

#Plot of results

print("Obtain the response from the classifyers...")
env$datapr<-predict(env$datafit,newdata=na.omit(env$data[env$test,c(env$inp,env$target)]))
env$svmpr<-predict(env$svmfit,newdata=na.omit(env$data[env$test,c(env$inp,env$target)]))
env$rfpr<-predict(env$rffit,newdata=na.omit(env$data[env$test,c(env$inp, env$target)]))


#Plot prediction and observation line on test-set
obs<-subset(env$data[env$test,c(env$inp,env$target)],select=env$target)

with(env$data,plot(obs,env$datapr))
lines(mtcars$wt, fitted(m1), col="blue")

newdat = data.frame(wt=mtcars$wt, mpgpred=fitted(m1))
newdat = newdat[order(newdat$wt),]
lines(newdat, col="red", lwd=4)

