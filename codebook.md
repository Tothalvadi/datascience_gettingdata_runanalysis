#Codebook for run_analysis script
This codebook describes the contents of the run_analysis return object and how it is created. 

##Format
The format of the return object is a dplyr table containing two identifying columns and 79 observations.

##Process
The UCI HAR dataset contains test and training data. These datasets have been merged by the run_analysis script as a single dataframe. The activity labels in y_test.txt and y_train.txt have been replaced with the proper activity descriptions found in the activity_labels.txt file. Column headers voor the X_train.txt and the X_test.txt files have been added from the features.txt file. 
Only certain columns in the X files are selected. Only average and standard deviation columns are required. A filter is therefore based on wether or not the column header either contains a "mean()"(average function) or an "std()"(standard deviation function) string. 

A summary will be performed on the datasets after they have been combined into one. A grouping will be performed on the subjectid and the activity columns. All the other columns will be averaged with the mean() function. The result is a 40 x 81 dplyr table containing the grouping elements and the averaged observations. 


##Columns
Table contains 81 columns. The first two contain identifiers to describe the conditions in which the observation took place.
Columns 3 through 81 contain the observations. 

###Identifiers
|No.|Column header|Type|Description|
|---|----------|----------|------------------------------------------------------------------------|
|1|subjectid|Integer|A unique identifier for the different subjects who partook in the experiment.|
|2|activity|Character|A description of the activity undertaken.| 

###Observations
The observations are described in the features_info.txt file contained in the UCI HAR dataset. I will include a small excerpt 
to describe the columns below: 

>The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 
>
>Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 
>
>Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 
>
>These signals were used to estimate variables of the feature vector for each pattern:
>'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

For each feature only the average(mean) and standard deviation(std) have been selected. 



|No.|Column header|Type|
|---|----------------|----------------| 
|3|tBodyAcc-mean()-X|Numeric|
|4|tBodyAcc-mean()-Y|Numeric|
|5|tBodyAcc-mean()-Z|Numeric|
|6|tBodyAcc-std()-X|Numeric|
|7|tBodyAcc-std()-Y|Numeric|
|8|tBodyAcc-std()-Z|Numeric|
|9|tGravityAcc-mean()-X|Numeric|
|10|tGravityAcc-mean()-Y|Numeric|
|11|tGravityAcc-mean()-Z|Numeric|
|12|tGravityAcc-std()-X|Numeric|
|13|tGravityAcc-std()-Y|Numeric|
|14|tGravityAcc-std()-Z|Numeric|
|15|tBodyAccJerk-mean()-X|Numeric|
|16|tBodyAccJerk-mean()-Y|Numeric|
|17|tBodyAccJerk-mean()-Z|Numeric|
|18|tBodyAccJerk-std()-X|Numeric|
|19|tBodyAccJerk-std()-Y|Numeric|
|20|tBodyAccJerk-std()-Z|Numeric|
|21|tBodyGyro-mean()-X|Numeric|
|22|tBodyGyro-mean()-Y|Numeric|
|23|tBodyGyro-mean()-Z|Numeric|
|24|tBodyGyro-std()-X|Numeric|
|25|tBodyGyro-std()-Y|Numeric|
|26|tBodyGyro-std()-Z|Numeric|
|27|tBodyGyroJerk-mean()-X|Numeric|
|28|tBodyGyroJerk-mean()-Y|Numeric|
|29|tBodyGyroJerk-mean()-Z|Numeric|
|30|tBodyGyroJerk-std()-X|Numeric|
|31|tBodyGyroJerk-std()-Y|Numeric|
|32|tBodyGyroJerk-std()-Z|Numeric|
|33|tBodyAccMag-mean()|Numeric|
|34|tBodyAccMag-std()|Numeric|
|35|tGravityAccMag-mean()|Numeric|
|36|tGravityAccMag-std()|Numeric|
|37|tBodyAccJerkMag-mean()|Numeric|
|38|tBodyAccJerkMag-std()|Numeric|
|39|tBodyGyroMag-mean()|Numeric|
|40|tBodyGyroMag-std()|Numeric|
|41|tBodyGyroJerkMag-mean()|Numeric|
|42|tBodyGyroJerkMag-std()|Numeric|
|43|fBodyAcc-mean()-X|Numeric|
|44|fBodyAcc-mean()-Y|Numeric|
|45|fBodyAcc-mean()-Z|Numeric|
|46|fBodyAcc-std()-X|Numeric|
|47|fBodyAcc-std()-Y|Numeric|
|48|fBodyAcc-std()-Z|Numeric|
|49|fBodyAcc-meanFreq()-X|Numeric|
|50|fBodyAcc-meanFreq()-Y|Numeric|
|51|fBodyAcc-meanFreq()-Z|Numeric|
|52|fBodyAccJerk-mean()-X|Numeric|
|53|fBodyAccJerk-mean()-Y|Numeric|
|54|fBodyAccJerk-mean()-Z|Numeric|
|55|fBodyAccJerk-std()-X|Numeric|
|56|fBodyAccJerk-std()-Y|Numeric|
|57|fBodyAccJerk-std()-Z|Numeric|
|58|fBodyAccJerk-meanFreq()-X|Numeric|
|59|fBodyAccJerk-meanFreq()-Y|Numeric|
|60|fBodyAccJerk-meanFreq()-Z|Numeric|
|61|fBodyGyro-mean()-X|Numeric|
|62|fBodyGyro-mean()-Y|Numeric|
|63|fBodyGyro-mean()-Z|Numeric|
|64|fBodyGyro-std()-X|Numeric|
|65|fBodyGyro-std()-Y|Numeric|
|66|fBodyGyro-std()-Z|Numeric|
|67|fBodyGyro-meanFreq()-X|Numeric|
|68|fBodyGyro-meanFreq()-Y|Numeric|
|69|fBodyGyro-meanFreq()-Z|Numeric|
|70|fBodyAccMag-mean()|Numeric|
|71|fBodyAccMag-std()|Numeric|
|72|fBodyAccMag-meanFreq()|Numeric|
|73|fBodyBodyAccJerkMag-mean()|Numeric|
|74|fBodyBodyAccJerkMag-std()|Numeric|
|75|fBodyBodyAccJerkMag-meanFreq()|Numeric|
|76|fBodyBodyGyroMag-mean()|Numeric|
|77|fBodyBodyGyroMag-std()|Numeric|
|78|fBodyBodyGyroMag-meanFreq()|Numeric|
|79|fBodyBodyGyroJerkMag-mean()|Numeric|
|80|fBodyBodyGyroJerkMag-std()|Numeric|
|81|fBodyBodyGyroJerkMag-meanFreq()|Numeric|
