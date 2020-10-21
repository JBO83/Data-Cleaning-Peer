# Codebook - Tidy data Peer project

The goal here is to make data, that are not as such in a tidy format, tidy.

Original description of the input data can be found here:

[](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

And the raw data can be found here:

[](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

## Needed packages

dplyr

## Tidying the data

As per instruction we begin by combining the data on the training and test set.

This is done with the folllowing code:

`data_set<-rbind(read.table("UCI HAR Dataset/train/X_train.txt"),read.table("UCI HAR Dataset/test/X_test.txt"))`

It is then required that we only take variables that has mean or std in them.

First we need the names:

`feature_label<-read.table("UCI HAR Dataset/features.txt")`

and then we find the index of the relevant names:

`index_no <- grep("mean\\(|std\\(", feature_label$V2)`

use the select function to grap the subset:

`data_set <- select(data_set, index_no)`

For tidying data we need the subset of names as well:

`index_name <- grep("mean\\(|std\\(", feature_label$V2, value = TRUE)`

We are now set to create the full data frame with subject, activity and variables data:

`data_name<-rbind(read.table("UCI HAR Dataset/train/y_train.txt"),read.table("UCI HAR Dataset/test/y_test.txt"))
subject<-rbind(read.table("UCI HAR Dataset/train/subject_train.txt"),read.table("UCI HAR Dataset/test/subject_test.txt"))`

`df_full<-cbind(subject,cbind(data_name,data_set))`



We now need to change all the names of activities and variables such that it comply with data being tidy:

`names(df_full) <-c("subject","activity",index_name)
activity_labels<-read.table("UCI HAR Dataset/activity_labels.txt")
df_full$activity<- activity_labels$V2[df_full$activity]`

`names(df_full) <- sub("^t", "time", names(df_full))
names(df_full) <- sub("^f", "frequency", names(df_full))
names(df_full) <- sub("Acc", "Accelerometer", names(df_full))
names(df_full) <- sub("Gyro", "Gyroscope", names(df_full))
names(df_full) <- sub("Mag", "Magnitude", names(df_full))
names(df_full) <- sub("mean\\(\\)", "Mean", names(df_full))
names(df_full) <- sub("std\\(\\)", "Std", names(df_full))`



Job done. we now have a tidy data frame.



Last assignment is to create a reduced data frame showing the mean for each variable and group them by subject and activity. This done using chained commands:

`df_reduced<- df_full %>%
  group_by(subject,activity) %>%
  summarise_all(list(mean=mean))`

This data frame can then be written to a text file.

`write.table(df_reduced,file="df_reduced.txt",row.names = FALSE)`