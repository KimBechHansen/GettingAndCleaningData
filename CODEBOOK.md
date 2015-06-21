Solution to the "Getting and Cleaning Data" Course Project

The dataset is obtained from this site:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

and is described here:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

In order to create my solution I did this:

1. I start off by setting the working directory
2. Then I read in the X_xxxx.txt files and join them in a collected file
3. I read the subject_xxxx.txt files and join them in a collected file
4. I column-bind the two collected files into one data frame
5. I read in the y_xxxx.txt files and join them in in a collected file
6. I give the activity column a header/name
7. I read in the activity_label file and create headers
8. Merge the activities and activity_labels by activity
9. Read in the features file, and transpose the resulting feature-matrix to use as headers in the data frame
10. Do a little clean-up in the names...here I only remove empty parenthesis....many more could probably be done. But I prefer original titles
11. Give the data frame some headers
12. Label the columns and create the final data frame and re-arrange the columns, so the data frame start with subject and activity
13. I Create means and standard deviatiopns for each measurement and places the in the meansAndSds variable, using the apply function and transposing the result
14. Order data frame by subject og activity
15. Create means by subject and activity, using the aggregate function and a by-list og subject and activity
15a. Aggregate does NOT keep the ordering, frustrating :-(
15b. The result is wide, if preferred, do a transpose and the result will be long instead.....
16. I Write result to file in the current directory, using no row.names as per requested, using the write.table
