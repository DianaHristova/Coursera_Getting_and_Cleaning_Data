# all data files need to be downloaded and unzipped in the working directory
# read all the data
X_train<-read.table("X_train.txt")
X_test<-read.table("X_test.txt")
features<-read.table("features.txt")
subject_train<-read.table("subject_train.txt")
subject_test<-read.table("subject_test.txt")
Y_train<-read.table("Y_train.txt")
Y_test<-read.table("Y_test.txt")

# bind together the training and test data (X_all), the training and test activity type labels (Y_all)
# and the training and test subject numbers (subject_all)
X_all<-rbind(X_train,X_test)
Y_all<-rbind(Y_train,Y_test)
subject_all<-rbind(subject_train,subject_test)

# rename the columns in subject_all and Y_all
names(subject_all)[1]<-"subject"
names(Y_all)[1]<-"activityType"

# create a vector listing all the feature names
featureNames<-features[,2]

# use the featureNames vector to name the columns in the X_all data
names(X_all)<-featureNames

# subset X_all extracting only the columns measuring the mean and standard deviation of each measurement
X_all_subset<-X_all[,grepl("mean\\(\\)|std\\(\\)",names(X_all))]

# use descriptive activity names (based on info in activity_labels file) to convert the numeric coding
# in the training labels dataset to descriptive categories
Y_all$activityType<-sub("1","WALKING",Y_all$activityType)
Y_all$activityType<-sub("2","WALKING_UPSTAIRS",Y_all$activityType)
Y_all$activityType<-sub("3","WALKING_DOWNSTAIRS",Y_all$activityType)
Y_all$activityType<-sub("4","SITTING",Y_all$activityType)
Y_all$activityType<-sub("5","STANDING",Y_all$activityType)
Y_all$activityType<-sub("6","LAYING",Y_all$activityType)

# create a full dataset binding the subject number and the activity type to the data observations 
data_all<-cbind(subject_all,Y_all,X_all_subset)

# clean up column labels using more descriptive variable names by: 
# getting rid of () in column names
# spelling out time and frequency 
# spelling out Accelerometer, Magniture, and Gyroscope
names(data_all)<-sub("\\()","",names(data_all))
names(data_all)<-sub("^t","time",names(data_all))
names(data_all)<-sub("^f","frequency",names(data_all))
names(data_all)<-sub("Acc","Accelerometer",names(data_all))
names(data_all)<-sub("Mag","Magnitude",names(data_all))
names(data_all)<-sub("Gyro","Gyroscope",names(data_all))

# create a tidy data set aggregating the mean of each variable for each of the subjects and activity types
tidyData<-aggregate(data_all[,3:68],by=list(subject=data_all$subject,activityType=data_all$activityType),mean)

# write the tidy data set to a txt file as specified in the assignment
write.table(tidyData,"tidyData.txt",quote=FALSE,row.names=FALSE)
