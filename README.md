Getting and Cleaning Data Coursera Project 
How run_analysis.R script works:

Data from he Human Activity Recognition Using Smartphones Data Set. Full description is available at: 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
Raw data source: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The code named "run_analysis.R" was written to do fulfill a five part requirement as below, with final outcome, 
a tidy extracted data that also returns .txt file. 

1.Merges the training and the test sets to create one data set. 
1a.Read files 1b.Name columns 1c.Merge data

2.Extracts only the measurements on the mean and standard deviation for each measurement. 
2a.Apply column names. 
2b.Subset out data with selected columns.

3.Uses descriptive activity names to name the activities in the data set. 
3a. Transform 'actions' column as factor.

4.Appropriately labels the data set with descriptive variable names. 
4a.Substitute abbreviations with descriptive names.

5:From the data set in step 4, creates a second, independent tidy data set with the average of 
each variable for each activity and each subject. 
5a.Create tidy data by splitting into subsets with summary statistics (mean) using the function aggregate(). 
5b. Generate .txt file as final output

Further description available on the script file.
