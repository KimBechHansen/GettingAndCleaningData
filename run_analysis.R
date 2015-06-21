#Solution to the "Getting and Cleaning Data" Course Project

#Set the working directory
setwd("GetData//UCI HAR Dataset")

#Read the X_xxxx.txt files and join them in a collected file
test_file<-read.fwf(file = "test/X_test.txt", width=c(seq(from=16,to=16,length.out=561)), colClasses="numeric", header=FALSE)
train_file<-read.fwf(file = "train/X_train.txt", width=c(seq(from=16,to=16,length.out=561)), colClasses="numeric", header=FALSE)
collected_file<-rbind(train_file, test_file)

#Read the subject_xxxx.txt files and join them in a collected file
file_test_subject<-read.csv("test/subject_test.txt", header = FALSE)
file_train_subject<-read.csv("train/subject_train.txt", header = FALSE)
collected_subject<-rbind(file_train_subject, file_test_subject)

#Bind the two collected files into one data frame
tf<-cbind(collected_subject, collected_file, deparse.level=0)

#Read the y_xxxx.txt files and join them in in a collected file
file_y_test<-read.csv("test/y_test.txt", header = FALSE)
file_y_train<-read.csv("train/y_train.txt", header = FALSE)
collected_y<-rbind(file_y_train, file_y_test)

#Give the activity column a header/name
names(collected_y)<-("activity")

#Read the activity_label file and create headers
file_labels<-read.csv("activity_labels.txt", header = FALSE, sep=" ")
names(file_labels)<-c("activity", "activity.label")

#Merge the activities and activity_labels by activity
labels<-merge(collected_y, file_labels, by="activity", sort=FALSE)

#Read in the features file, and transpose the resulting feature-matrix
features<-read.csv("features.txt", header=FALSE, sep=" ")
tFeature<-t(features)

#Do a little clean-up in the names...here I remove empty parenthesis....many more could probably be done. But I prefer original titles
tFeature["V2",]<-mgsub("()", "", tFeature["V2",])

#Give the data frame some headers
names(tf)<-c("Subject", tFeature["V2",])

#Label the columns
final_tf<-cbind(labels, tf)
#Arrange the columns 
final_tf<-final_tf[,c(3,1,2,4:564)]

#Create means and standard deviatiopns for each measurement
meansAndSds<-t(apply(tf[,-1],2,function(x) c(Mean=mean(x), SD=sd(x))))


#Order data frame by subject og activity
otf<-final_tf[order(final_tf[,"Subject"], final_tf[,"activity"], decreasing = FALSE),]

#Create means by subject and activity
#aggregate does NOT keep the ordering, frustrating :-(
agg<-aggregate(otf[,c(4:564)], by=list(otf$"Subject",otf$"activity"), FUN=function(x) Mean=mean(x))
#The result is wide, if preferred, do a transpose and the result will be long instead.....

#Write result to file in the current directory, using no row.names as per requested
write.table(agg, file = "summary_stats.txt", append = FALSE, quote = TRUE, sep = " ",
            eol = "\n", na = "NA", dec = ".", row.names = FALSE,
            col.names = TRUE, qmethod = "escape",fileEncoding = "")
