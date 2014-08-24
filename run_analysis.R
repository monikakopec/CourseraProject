###############################################################################################
###################################### GETTING AND CLEANING DATA - COURSE PROJECT #############
##################################################################### AUGUST 2014 #############

# You should create one R script called run_analysis.R that does the following. 
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

###############################################################################################
#################################################################### READING DATA #############

default<-getwd()
setwd("./UCI HAR Dataset")

activity_labels<-read.table("./activity_labels.txt")
features<-read.table("./features.txt")

# test
X_test<-read.table("./test/X_test.txt")
y_test<-read.table("./test/y_test.txt")
subject_test<-read.table("./test/subject_test.txt")
# original data :
# body_acc_x_test<-read.table("./test/Inertial Signals/body_acc_x_test.txt")
# body_acc_y_test<-read.table("./test/Inertial Signals/body_acc_y_test.txt")
# body_acc_z_test<-read.table("./test/Inertial Signals/body_acc_z_test.txt")
# body_gyro_x_test<-read.table("./test/Inertial Signals/body_gyro_x_test.txt")
# body_gyro_y_test<-read.table("./test/Inertial Signals/body_gyro_y_test.txt")
# body_gyro_z_test<-read.table("./test/Inertial Signals/body_gyro_z_test.txt")
# total_acc_x_test<-read.table("./test/Inertial Signals/total_acc_x_test.txt")
# total_acc_y_test<-read.table("./test/Inertial Signals/total_acc_y_test.txt")
# total_acc_z_test<-read.table("./test/Inertial Signals/total_acc_z_test.txt")

# train
X_train<-read.table("./train/X_train.txt")
y_train<-read.table("./train/y_train.txt")
subject_train<-read.table("./train/subject_train.txt")
# original data :
# body_acc_x_train<-read.table("./train/Inertial Signals/body_acc_x_train.txt")
# body_acc_y_train<-read.table("./train/Inertial Signals/body_acc_y_train.txt")
# body_acc_z_train<-read.table("./train/Inertial Signals/body_acc_z_train.txt")
# body_gyro_x_train<-read.table("./train/Inertial Signals/body_gyro_x_train.txt")
# body_gyro_y_train<-read.table("./train/Inertial Signals/body_gyro_y_train.txt")
# body_gyro_z_train<-read.table("./train/Inertial Signals/body_gyro_z_train.txt")
# total_acc_x_train<-read.table("./train/Inertial Signals/total_acc_x_train.txt")
# total_acc_y_train<-read.table("./train/Inertial Signals/total_acc_y_train.txt")
# total_acc_z_train<-read.table("./train/Inertial Signals/total_acc_z_train.txt")

# dim(activity_labels)
# dim(features)
# dim(X_train)
# dim(y_train)
# dim(subject_train)


###############################################################################################
#################################################################### MERGING DATA #############
############################## 1. Merges the training and the test sets to create one data set.

setwd(default)

# create 3 data frames for X's, subjects and y's
X<-X_train
X<-rbind(X,X_test)
subject<-subject_train
subject<-rbind(subject,subject_test)
y<-y_train
y<-rbind(y,y_test)

# create one big data frame with all variables
dataset<-cbind(X,subject,y)

# add column names
names(dataset)<-c(as.character(features[,2]),"Subject","Activity")


###############################################################################################
#################################################################### MEAN & STD ###############
#### 2. Extracts only the measurements on the mean and standard deviation for each measurement.

datasetMS<-dataset[,c(grep("(mean|std)[()]", names(dataset)), 562, 563)]


###############################################################################################
############################################################## ACTIVITIES NAMES ###############
#################### 3. Uses descriptive activity names to name the activities in the data set.

# create temporary data frame with name activities
dane<-rep(c(""),nrow(datasetMS))
for (i in 1:nrow(datasetMS)){
  if (datasetMS[i,ncol(datasetMS)]==1) {dane[i]=as.character(activity_labels[1,2])}
  if (datasetMS[i,ncol(datasetMS)]==2) {dane[i]=as.character(activity_labels[2,2])}
  if (datasetMS[i,ncol(datasetMS)]==3) {dane[i]=as.character(activity_labels[3,2])}
  if (datasetMS[i,ncol(datasetMS)]==4) {dane[i]=as.character(activity_labels[4,2])}
  if (datasetMS[i,ncol(datasetMS)]==5) {dane[i]=as.character(activity_labels[5,2])}
  if (datasetMS[i,ncol(datasetMS)]==6) {dane[i]=as.character(activity_labels[6,2])}
}

# add column with name activities
datasetMS<-cbind(datasetMS,dane)
names(datasetMS)[ncol(datasetMS)]<-"Activity_Labels"


###############################################################################################
#################################################### DESCRITPIVE VARIABLE NAMES ###############
######################### 4. Appropriately labels the data set with descriptive variable names.

# names(datasetMS)

# change abbreviations to full names
temp<-sub("Acc", "_Acceleration", names(datasetMS))
temp<-sub("Gyro", "_Gyroscope", temp)
temp<-sub("mean", "_Mean", temp) 
temp<-sub("std", "_StandardDev", temp) 
temp<-sub("Jerk", "_Jerk", temp) 
temp<-sub("Mag", "_Magnitude", temp) 
temp<-sub("^f", "FFT", temp)

# delete from names '-', '()' and 't' at the begginig
temp<-gsub("-|\\()", "", temp)
temp<-gsub("^t", "", temp)

# add new names
names(datasetMS)<-temp


###############################################################################################
##################################################################### TIDY DATA ###############
############################################### # 5. Creates a second, independent tidy data set
######################### with the average of each variable for each activity and each subject.

# create temporary data frame without name ativities
temp<-datasetMS[,-ncol(datasetMS)]

# create data frame with the mean of each variable for each subject and activity
dane<-aggregate.data.frame(temp, by = list(temp$Subject, temp$Activity), FUN ="mean")
datasetMSfinal<-dane[,-c(ncol(dane)-1,ncol(dane))]
names(datasetMSfinal)[1:2]<-c("Subject", "Activity")

# write to file 'output.txt'
write.table(datasetMSfinal, "output.txt", row.name=FALSE)


###############################################################################################
######################################################## DELETING USELESS FILES ###############

remove(temp)
remove(dane)
remove(i)
remove(default)
