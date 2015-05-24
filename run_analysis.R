setwd("C:/Users/Oleg/Documents/coursera/DataScience/Getting and Cleaning Data/project/UCI HAR Dataset")

#read data
x.test=read.table("test/X_test.txt")
y.test=read.table("test/Y_test.txt")
x.train=read.table("train/X_train.txt")
y.train=read.table("train/Y_train.txt")
activity.lavels=read.table("activity_labels.txt"); 
names(activity.lavels)=c("Activity Number", "Activity")
features=readLines("features.txt")
train.subject=read.table("train/subject_train.txt")
test.subject=read.table("test/subject_test.txt")

#merge test and train
x.merged=rbind(x.test, x.train)
y.merged=rbind(y.test, y.train); names(y.merged)="Activity Number"
subject.merged=rbind(test.subject, train.subject)

#include only std and mean
features.mean=which(grepl("mean\\(|std\\(", features, T))
x.merged.mean.std=x.merged[,features.mean]
names(x.merged.mean.std) = features[features.mean]

#y.merged=merge(y.merged,activity.lavels, by=1 )
require(reshape)

#make a pivot table
x.merged.mean.std$subject=subject.merged[[1]]
x.merged.mean.std$activity=y.merged[[2]]

x=melt(x.merged.mean.std, id.vars=c("subject", "activity"))
x=cast(x, subject+activity~..., fun.aggregate=mean, na.rm=T)
tidy=as.data.frame(x)
write.table(tidy, "tidy.txt",row.names=Fs)