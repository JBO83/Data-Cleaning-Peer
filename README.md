# Read me for Data Cleaning Peer Assignment:

## Goal: 

Tidy up data from different files and create some summary statistics

## Pseudocode

- Data is read into r as a data frame.
- Data from the train and test data are merged
  - Only data concerning mean and standard deviation is kept for each observation.
- Names of columns and activities are changed to meaningful names.
- Finally a reduced data frame is produced, which takes the mean of all variables and group them by subject and activity.