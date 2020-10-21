library(dplyr)
# setwd("C:/Users/janus/OneDrive/Dokumenter/Kursus/Data Analyst/Data_Cleaning")

###Get test data
data_set<-rbind(read.table("UCI HAR Dataset/train/X_train.txt"),read.table("UCI HAR Dataset/test/X_test.txt"))
feature_label<-read.table("UCI HAR Dataset/features.txt")
# Select features of means and standard deviations
index_no <- grep("mean\\(|std\\(", feature_label$V2)
# Only have variables with mean or standard deviation
data_set <- select(data_set, index_no)
# Get the subset of names
index_name <- grep("mean\\(|std\\(", feature_label$V2, value = TRUE)

#get data names and subject for both test and train set
data_name<-rbind(read.table("UCI HAR Dataset/train/y_train.txt"),read.table("UCI HAR Dataset/test/y_test.txt"))
subject<-rbind(read.table("UCI HAR Dataset/train/subject_train.txt"),read.table("UCI HAR Dataset/test/subject_test.txt"))

###Combine test and train data in one dat frame
df_full<-cbind(subject,cbind(data_name,data_set))

# Provide relevant names
names(df_full) <-c("subject","activity",index_name)
activity_labels<-read.table("UCI HAR Dataset/activity_labels.txt")
df_full$activity<- activity_labels$V2[df_full$activity]

# Change variable names to more appropriate
names(df_full) <- sub("^t", "time", names(df_full))
names(df_full) <- sub("^f", "frequency", names(df_full))
names(df_full) <- sub("Acc", "Accelerometer", names(df_full))
names(df_full) <- sub("Gyro", "Gyroscope", names(df_full))
names(df_full) <- sub("Mag", "Magnitude", names(df_full))
names(df_full) <- sub("mean\\(\\)", "Mean", names(df_full))
names(df_full) <- sub("std\\(\\)", "Std", names(df_full))

### Group by activity and get the mean of both mean and standard deviation.
df_reduced<- df_full %>%
  group_by(subject,activity) %>%
  summarise_all(list(mean=mean))

### Write the output file
write.table(df_reduced,file="df_reduced.txt",row.names = FALSE)
