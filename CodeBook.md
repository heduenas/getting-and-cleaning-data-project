CookBook
========
This tidy data set is generated from UCI Human Activity Recognition Using Smartphones Dataset and extract it to working directory. **Please read the codebook for the original set for further understanding.**

We take only the mean and standard deviation variables from the original dataset and take the average of each variable for each activity and each subject. Namely we perform the following steps on the UCI data set:

1. Merge the training and the test sets to create one data set.
1. Extract only the measurements on the mean and standard deviation for each measurement. 
2. Create a second, independent tidy data set with the average of each variable for each activity and each subject.
