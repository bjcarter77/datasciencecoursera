Code Book


Data
	
	Raw data is found in zip file at:
		https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
	A full description is available at the site where the data was obtained:
		http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
	

Transformations
	
	The code "run_analysis.R" starts by reading all the files and then merges the test and train data into one dataset and then 		assigns descriptive activity names. Finally, it creates a second, independent tidy data set with the average of each variable for 	  each activity and each subject.

Variables

	The data from the downloaded files are assigned to x_train, y_train, x_test, y_test, subject_train, subject_test, features and 		activity_labels.
	The correct names for the x_test and x_train datasets, are contained in Features, these names are applied to the column names 		stored in x_train and x_test
	Train and Test data are merged into merge_train and merged_test and then all merged into SetAllInOne 
	A new table is created with SetAllInOne and assigned to ColNames
	The mean and standard deviation of ColNames are added with the vector mean_and_std and stored in setForMeanAndStd
	The stored data is then merged with activity_list into a sorted data set as per the mean and standard deviation in 			setWithActivityNames
	The second tidy data set, secTidySet, aggregates the data as per activityId and subjectId and then it is ordered in ascending 		order as per subjectID
