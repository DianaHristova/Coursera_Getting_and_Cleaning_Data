X_train<-read.table("X_train.txt")
X_test<-read.table("X_test.txt")
features<-read.table("features.txt")
subject_train<-read.table("subject_train.txt")
subject_test<-read.table("subject_test.txt")
Y_train<-read.table("Y_train.txt")
Y_test<-read.table("Y_test.txt")
X_all<-rbind(X_train,X_test)
Y_all<-rbind(Y_train,Y_test)
subject_all<-rbind(subject_train,subject_test)

names(subject_all)[1]<-"subject"
names(Y_all)[1]<-"activityType"

featureNames<-features[,2]
names(X_all)<-featureNames
X_all_subset<-X_all[,grepl("mean\\(\\)|std\\(\\)",names(X_all))]


Y_all$activityType<-sub("1","WALKING",Y_all$activityType)
Y_all$activityType<-sub("2","WALKING_UPSTAIRS",Y_all$activityType)
Y_all$activityType<-sub("3","WALKING_DOWNSTAIRS",Y_all$activityType)
Y_all$activityType<-sub("4","SITTING",Y_all$activityType)
Y_all$activityType<-sub("5","STANDING",Y_all$activityType)
Y_all$activityType<-sub("6","LAYING",Y_all$activityType)

data_all<-cbind(subject_all,Y_all,X_all_subset)


names(data_all)<-sub("\\()","",names(data_all))
names(data_all)<-sub("^t","time",names(data_all))
names(data_all)<-sub("^f","frequency",names(data_all))
names(data_all)<-sub("Acc","Accelerometer",names(data_all))
names(data_all)<-sub("Mag","Magnitude",names(data_all))
names(data_all)<-sub("Gyro","Gyroscope",names(data_all))

tidyData<-aggregate(data_all[,3:68],by=list(subject=data_all$subject,activityType=data_all$activityType),mean)

write.table(tidyData,"tidyData.txt",quote=FALSE,row.names=FALSE)
