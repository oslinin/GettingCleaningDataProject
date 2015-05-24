run_analysis.R creates a dataset with average of each variable for each activity and each subject.
The input is the Human Activity Recognition Using Smartphones Dataset v1.0.
The output is tidy.txt, which contains the average of each variable for each activity and each subject.

The script reads the test and train data, rbinds them, exctracts only the mean and standard deviation variables, adds a column for subject and a column for activity, and creates a pivot table of subject+activity ~ variable.