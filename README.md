Getting and Cleaning Data - Course Project
=== 
August 2014, v.1.0


### Information from original documentation:
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. 
Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. 
Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). 
The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. 
The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. 
From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 


### The dataset includes the following files:
* 'README.md':  It explains how all of the scripts work and how they are connected. 
* 'CodeBook.md': It's a describtion the variables, the data, and any transformations or work performed to clean up the data. 
* 'output.txt': A tidy data set.
* 'run_analysis.R': A script with the performed analysis.


### How does the script work
* READING DATA: At first, the files are writing from defalut directory, in which should be a folder "UCI HAR Dataset".
* MERGING DATA: It creates three data frames: the first with X_test and X_train, the second with y_test and y_train and the third with subject_test and subject_train. After that it creates one big data frame called 'dataset' from previous three data frames. At the end it adds the names of columns.
* MEAN & STD: It creates a new data frame 'datasetMS' from columns only with "mean()" or "std()" and additinal subjects and activities.
* ACTIVITIES NAMES: It creates a temporary data frame with names of activities and adds a new column with them to 'datasetMS'.
* DESCRITPIVE VARIABLE NAMES: It makes the names of columns more writable. 
* TIDY DATA: It creates a new data frame 'datasetMSfinal' with the mean of each variable for each subject and activity and writes it to 'output.txt'.
* DELETING USELESS FILES: It removes temporary datas.
.
