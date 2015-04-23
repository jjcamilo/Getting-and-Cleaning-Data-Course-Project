
setwd("C:\\Coursera\\Getting and Cleaning Data\\Project\\UCI HAR Dataset")

# 1. Merges the training and the test sets to create one data set.

# Reading the data from files
features <- read.table('./features.txt',header=FALSE)
activity_labels <- read.table('./activity_labels.txt',header=FALSE)

x_train <- read.table("train/X_train.txt",header=FALSE)
x_test <- read.table("test/X_test.txt",header=FALSE)

y_train <- read.table("train/y_train.txt",header=FALSE)
y_test <- read.table("test/y_test.txt",header=FALSE)

subject_train <- read.table("train/subject_train.txt",header=FALSE)
subject_test <- read.table("test/subject_test.txt",header=FALSE)

# Assigin column names to the data imported above

colnames(activity_labels) <- c('activityId','activityType')

colnames(x_train) <- features[,2] 
colnames(x_test) <- features[,2] 

colnames(y_train) <- "activityId"
colnames(y_test) <- "activityId"

colnames(subject_train) <- "subjectId"
colnames(subject_test) <- "subjectId"

# Create the train data set
train <- cbind(y_train,subject_train,x_train)

# Create the test data set
test <- cbind(y_test,subject_test,x_test)

# Create the final data set
final <- rbind(train,test)


# 2. Extract only the measurements on the mean and standard deviation for each measurement.  

# Create a logical vector that contains TRUE values for mean() & stddev() columns and FALSE for others 

column_names <- colnames(final)

# logical_vector <- grepl("-(mean|std)\\(\\)", column_names) 
logical_vector <- grepl("(-(mean|std)\\(\\)|activityId|subjectId)", column_names) 

# Verificar qual dos 2 é o correto !!!!!!!!
final <- final[logical_vector == TRUE]

# 3. Use descriptive activity names to name the activities in the data set

# Merge the final data set with the activity_labels table to include descriptive activity names 
final <- merge(final,activity_labels,by='activityId',all.x=TRUE)

# Updating the column_names vector to include the new column names after merge 

column_names <- colnames(final)

# 4. Appropriately label the data set with descriptive activity names.

for (i in 1:length(column_names))  
{ 
  column_names[i] <- gsub("^t","time",column_names[i]) 
  column_names[i] <- gsub("^f","frequency",column_names[i]) 
  column_names[i] <- gsub("Acc","Accelerometer",column_names[i]) 
  column_names[i] <- gsub("Gyro","Gyroscope",column_names[i]) 
  column_names[i] <- gsub("Mag","Magnitude",column_names[i]) 
  column_names[i] <- gsub("BodyBody","Body",column_names[i]) 
  column_names[i] <- gsub("gravity","Gravity",column_names[i]) 
} 

colnames(final) <- column_names
 
# 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject.  


# Create an auxiliary table, finalNoActivityType without the activityType column
finalNoActivityType <- final[,names(final) != 'activityType']

# Summarizing the finalNoActivityType table to include just the mean of each variable for each activity and each subject
tidyData <- aggregate(finalNoActivityType[,names(finalNoActivityType) != c('activityId','subjectId')],by=list(activityId=finalNoActivityType$activityId,subjectId = finalNoActivityType$subjectId),mean)

# Merging the tidyData with activity_labels to include activity names
tidyData <- merge(tidyData,activity_labels,by='activityId',all.x=TRUE)

tidyData <- tidyData[order(tidyData$activityId,tidyData$subjectId),]

# Export the tidyData set  
write.table(tidyData, './tidydata.txt',row.names=FALSE) 
