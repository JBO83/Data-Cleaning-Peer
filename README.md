Data Cleaning Peer Assignment –read me
First the data is read into r as a data frame.
The relevant information is then combined in a train_full and test_full data frame, where only the mean and standard deviation is logged for each observation.
We then merge these data frames.
The names of the columns are changed and so is the integer representation of the activity.
Last a reduced data frame is produced, which takes the mean of the mean and the mean of the standard deviations and group them by activity.

