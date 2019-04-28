library(ggplot2, quietly=TRUE)

milsongs<-read.csv("million song normalized.csv",header=TRUE)

#Remove duplicates
print("Removing duplicates...")
milsongs<-milsongs[!duplicated(milsongs[,c('artist_name','title','track_id')]),]

#Remove where year is zero
print("Removing columns where year is 0...")
cleanYMS<-milsongs[apply(milsongs[11],1,function(z) any(z!=0)),]

#Decade splitting
print("Reducing to five classes")
cleanYMS$decade<-ifelse(cleanYMS$year>=2005,2005,ifelse(cleanYMS$year>=1995,1995,ifelse(cleanYMS$year>=1985, 1985,ifelse(cleanYMS$year>= 1975, 1975, 1965))))

print("Saving new clean dataset...")
write.csv(cleanYMS,"msd_year.csv")
print("Saved!")

cat(paste("Saving a plot for year distribution \n"))
jpeg('year_distribution_full.jpg')
c<-ggplot(cleanYMS,aes(factor(year)))
plot(c+geom_bar())
dev.off()
