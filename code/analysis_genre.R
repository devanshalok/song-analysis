library(ggplot2, quietly=TRUE)
library(plyr, quietly=TRUE)
library(randomForest, quietly=TRUE)
library(e1071)
library(rpart,quietly=TRUE)

env<-new.env()

env$data<-read.csv("msd_pop.csv")
env$data<-read.table(file="genre MSD.txt",header=TRUE,sep=",",comment="#",quote=NULL,fill=TRUE)

#splitting dataset

test<-0.15
valid<-0.15
train<-0.7
env$nrow<-nrow(env$data)
cat(paste("Number of rows:",env$nrow,"\n"))

env$sample<-env$train<-sample(env$nrow,train*env$nrow)
env$validate<-sample(setdiff(seq_len(env$nrow),env$train),val*env$nrow)
env$test<-setdiff(setdiff(seq_len(env$nrow),env$train),test*env$nrow)

#variable selection

env$inp<-c("loudness","tempo","time_signature","key","mode","duration")
env$num<-c("loudness","tempo","time_signature","key","mode","duration")
env$target<-"genre"
env$ident<-"track_id"

pcme<-function(actual,cl)
{
  x<-table(actual,cl)
  nc<-nrow(x) #no of classes
  nv<-length(actual)-sum(is.na(actual)|is.na(cl)) #no of values
  tbl<-cbind(x/nv,Error=sapply(1:nc,function(r) round(sum(x[r,-r])/sum(x[r,]), 2)))
  names(attr(tbl,"dimnames")) <- c("Actual","Predicted")
  return(tbl)
}
                                       #analysis

#decision tree


print("Classifying using decision tree...")
env$datafit<-rpart(genre~.,data=env$data[env$train,c(env$inp,env$target)],method="class")
print("Finished classifying using Decision Tree")

#result for decision tree

env$datapr<-predict(env$datafit,newdata=env$data[env$test,c(env$inp,env$target)],type="class")

print(length(env$data))
print(length(env$test))
print(length(env$data[env$test,c(env$inp, env$target)]))
print(length(env$datapr))

perdata<-pcme(env$data[env$test,c(env$inp,env$target)]$genre,env$datapr)
round(perdata, 2)
cat(100*round(1-sum(diag(perdata),na.rm=TRUE),2))

errormatdata<-table(env$data[env$test,c(env$inp,env$target)]$genre,env$datapr,useNA="ifany",dnn=c("Actual","Predicted"))
write.table(errormatdata,file="genre_error_matrix_data.txt")

#randon forest
print("Classifying using Random Forest...")
env$rffit<-randomForest::randomForest(genre~.,data=env$data[env$train,c(env$inp,env$target)],ntree=10,mtry=2,importance=TRUE,na.action=randomForest::na.roughfix,replace=FALSE)
print("Finished classifying using Random Forest")

#results for random Forest
env$rfpr<-predict(env$rffit,newdata=env$data[env$test,c(env$inp,env$target)],type="class")


#Plot Error Matrix

errormatrf<-table(env$data[env$test,c(env$inp,env$target)]$genre,env$rfpr,useNA="ifany",dnn=c("Actual", "Predicted"))
write.table(errormatrf,file="genre_error_matrix_rf.txt")
perrf<-pcme(env$data[env$test,c(env$inp,env$target)]$genre,env$rfpr)
round(perdata,2)
cat(100*round(1-sum(diag(perrf),na.rm=TRUE),2))

#SVM

print("Classifying using SVM...")
env$svmfit<-svm(genre~.,data=env$data[env$train,c(env$inp,env$target)])
print("Finished classifying using SVM")

#Evaluate Results for SVM
env$svmpr<-predict(env$svmfit,newdata=env$data[env$test, c(env$inp, env$target)], type="class")
errormatsvm<-table(env$data[env$test,c(env$inp,env$target)]$genre,env$svmpr,useNA="ifany",dnn=c("Actual","Predicted"))
write.table(errormatsvm,file="genre_error_matrix_svm.txt")
persvm<-pcme(env$data[env$test,c(env$inp,env$target)]$genre,env$svmpr)
round(persvm,2)
cat(100*round(1-sum(diag(persvm),na.rm=TRUE),2))

                                          
                                       #plots and graph

#Plot tree
print("Saving a plot of the decision Tree...")
jpeg('genre_data_plot.jpg')
plot(env$datafit,uniform=TRUE,main="Classification Tree for genre")
text(env$datafit,use.n=TRUE,all=TRUE,cex=.8)
dev.off()

#Generate a Confusion Matrix
print("Saving a confusion Matrix of the decision Tree...")
jpeg('genre_data_confusion_matrix.jpg')
plot(env$datafit,uniform=TRUE,main="Classification Tree for genre")
text(env$datafit,use.n=TRUE,all=TRUE,cex=.8)
dev.off()

#Plot count of genre distribution
print("Creating a genre distribution pie")
jpeg('genre_distribution.jpg')
g1<-ggplot(env$data,aes(x=factor(1),fill=factor(genre)))+geom_bar(width=1)
plot(g1+coord_polar(theta="y"))
dev.off()
print("Saved year distribution plot")


#Plot relation between loudness and genre
print("Plot showing relation between loudness and genre")
jpeg('genre_loudness.jpg')
g<-ggplot(env$data, aes(x=genre,y=loudness))
plot(g+geom_violin(alpha=0.5,color="gray")+geom_jitter(alpha=0.5, aes(color=genre),position = position_jitter(width = 0.1))+coord_flip())
dev.off()
print("Saved loudness and genre relation")

