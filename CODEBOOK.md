# Getting and Cleaning Data - Course Project

This code book describes the variables, data, and the transformations performed by the script *run_analysis.R*.

##The data source

The original data can be found at  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and the description of these data can be obtained at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

##Data Set Information

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained data set has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

## What run_analysis.R does

The script run_analysis.R does the following. 

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## How run_analysis.R works

* Samsung data have to be in the working directory.
* Read the source data files located in (
    features.txt, 
    activity_labels.txt,
    subject_train.txt,
    x_train.txt,
    y_train.txt,
    subject_test.txtm,
    x_test.txtm,
    y_test.txt ).
* Assigin column names for the read data sets.
* Merge the data sets using cbind and rbind to create one data set.
* Extract data for the columns related with mean and standard deviation
* Replace the column names with a descriptive activity names
* Create a new data set with the averages of each variable for each activity and each subject.
* Write this data set to a file named *tidydata.txt*.
 
## The Variables

* *features*, *activity_labels*, *x_train*, *x_test*, *y_train*, *y_test*, *subject_train* and *subject_test* contains the data from the source files.
* *train* and *test* contains the merged data from the above data sets.
* *final* contains the merge from train and test. This variable will be evolueted among the processes until a tidy version of the data.
* *column_names* is the array of the column names of final. This variable will be used to filter data and to replace the column names with a descriptive name.
* *logical_vector* is an auxiliary array to filter the columns with mean and std.
* *tidyData* is the tidy data set with the average of each variable for each activity and each subject.

