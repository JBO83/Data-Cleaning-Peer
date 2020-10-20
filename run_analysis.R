library(dplyr)

##### Get train data
data_set<-read.table("X_train.txt")
data_name<-read.table("y_train.txt")
subject<-read.table("subject_train.txt")

#### Create train data frame
train_full<-cbind(subject,cbind(data_name,cbind(rowMeans(data_set),apply(data_set,1, sd, na.rm = TRUE))))

###Get test data
data_set<-read.table("X_test.txt")
data_name<-read.table("y_test.txt")
subject<-read.table("subject_test.txt")

###Create Test data frame
test_full<-cbind(subject,cbind(data_name,cbind(rowMeans(data_set),apply(data_set,1, sd, na.rm = TRUE))))

### Merge test and train data. Provide relevant names
df_full<-rbind(train_full,test_full)
names(df_full)<-c("subject","activity","mean","standard_deviation")
activity_labels<-read.table("activity_labels.txt")
df_full$activity<- activity_labels$V2[df_full$activity]

### Group by activity and get the mean of both mean and standard deviation.
df_reduced<- df_full %>%
  group_by(activity) %>%
  summarise(mean_mean=mean(mean),mean_standard_deviation=mean(standard_deviation))


### Write the output file
write.table(df_reduced,file="df_reduced.txt",row.names = FALSE)
