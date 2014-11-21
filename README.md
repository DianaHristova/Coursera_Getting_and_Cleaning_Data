#**Human Activity Recognition Using Smartphones Dataset**

##**Goal**

Using data originally from:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
create an R script called run_analysis.R that does the followin: 
* Merges the training and the test sets of the original data to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement. 
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive variable names. 
* Creates a tidy data set with the average of each variable for each activity and each subject
* Writes the tidy data set to a .txt file

##**Files**

This repo includes: 
* README.md - outlining the objective and solution to this assignment
* codeBook.md - a codebook describing the variables, the data and the transformations
* run_analysis.R - the R code performing the required steps 


##**Steps in run_analysis.R**

The R code requires all original files to be downloaded and saved in the working directory. 
The R code does not use any libraries
The R code performs the following steps: 

* Read all the files for the traning and test datasets for the data, the labels, the subject numbers as well as the features
* Rbind into one file the data observations for the training and test sets
* Rbind into one file the activity labels for the training and test sets
* Rbind into one file the subject numbers for the training and test sets
* Change the column name of the subject dataset to "subject"
* Change the column name of the activity type dataset to "activityType"
* Create a vector called featureNames of the full list of features by subsetting the second column of the features table
* Use the featureNames vector to name the columns in the data observations dataset
* Subset the data observations dataset to include only columns with the mean (mean()) and standard deviation (std()) of each measurement using grepl. Meanfreq() is excluded as it is not the mean() of any of the measurements as the assignment instructs.
* Replace the numeric code in the activity labels dataset with the corresponding text for each activity
* Cbind the subject data to the activity labels data to the previously created subset of data observations for all mean() and std() of all measurements 
* Clean up the names of the variables by removing "()" from any variable name to avoid confusion with functions
* Spell out time, frequency, Accelerometer, Magnitude and Gyroscope to made variable names easier to interpret
* Create a tidy dataset of the average for each variable for each activity type and each subject, using the aggregate() function
* Write the new dataset into a .txt file called "tidyData.txt" using write.table 
