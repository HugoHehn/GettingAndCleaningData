
## Original dataset

Data has been retreived from the Center for Machine Learning and Intelligent Systems at UCI.

Detailed information on the original dataset (and the variables it contains) can be found here:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Contained within the zip folder are the following files (from "README.txt"):

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

## Variable descriptions from original dataset

As quoted from "features_info.txt":

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ

tGravityAcc-XYZ

tBodyAccJerk-XYZ

tBodyGyro-XYZ

tBodyGyroJerk-XYZ

tBodyAccMag

tGravityAccMag

tBodyAccJerkMag

tBodyGyroMag

tBodyGyroJerkMag

fBodyAcc-XYZ

fBodyAccJerk-XYZ

fBodyGyro-XYZ

fBodyAccMag

fBodyAccJerkMag

fBodyGyroMag

fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

mean(): Mean value

std(): Standard deviation

mad(): Median absolute deviation 

max(): Largest value in array

min(): Smallest value in array

sma(): Signal magnitude area

energy(): Energy measure. Sum of the squares divided by the number of values. 

iqr(): Interquartile range 

entropy(): Signal entropy

arCoeff(): Autorregresion coefficients with Burg order equal to 4

correlation(): correlation coefficient between two signals

maxInds(): index of the frequency component with largest magnitude

meanFreq(): Weighted average of the frequency components to obtain a mean frequency

skewness(): skewness of the frequency domain signal 

kurtosis(): kurtosis of the frequency domain signal 

bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.

angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean

tBodyAccMean

tBodyAccJerkMean

tBodyGyroMean

tBodyGyroJerkMean"


## Data transformations carried out to original data set

The transformation carried out has not changed the basic measurements of the original data, but mainly merged separate files and tidied headers. A separate file has also been produced containing summarized averages.

Units of each variable are intact from the original data. The transformation steps carried out are the following (also see script file run_analysis.R):

Data from activity_labels.txt:

1) Variable names converted to lowercase using tolower() function in R

2) Underscores removed in variable names using gsub() function in R

3) Column names changed to "activitynumber and "activitylabel"

Data from features.txt:

4) Variable names converted to lowercase using tolower() function in R

5) Parentheses and dashes removed in variable names using gsub() function in R

6) Column names changed to "activitynumber and "activitylabel"

Data from y_train.txt:

7) Column name changed to "activity"

Data from X_train.txt:

8) Data subseted to only include variables corresponding to columns containing the strings "mean" or "std" in the features.txt file (located using the grep() function).

9) Column names changed to corresponding names from features.txt file

Data from subject_train.txt:

10) Column name changed to "volunteerid"

Data from y_test.txt:

11) Column name changed to "activity"

Data from X_test.txt:

12) Data subseted to only include variables corresponding to columns containing the strings "mean" or "std" in the features.txt file (located using the grep() function).

13) Column names changed to corresponding names from features.txt file

Data from subject_test.txt:

14) Column name changed to "volunteerid"

Final steps to produce "Merged and tidied data.csv" file:

15) Transformed data from subject_train.txt, y_train.txt and X_train.txt merged into one data frame using cbind() function in R.

16) Transformed data from subject_test.txt, y_test.txt and X_test.txt merged into one data frame using cbind() function in R.

17) Merged data frames from step 15) and 16) merged into one data frame using rbind() in R.

18) Labels from activity_labels.txt applied to merged data frame

19) Columns "volunteerid" and "activity" in merged data frame converted to factors using as.factor() in R.

20) Merged data frame saved to CSV using write.csv() in R.

Final steps to produce "Summarized averages.csv" file:

21) Reshape2 package loaded in R

22) Merged data melted with melt() function using "volunteerid" and "activity" as ID variables.

23) Averages of each variable produced for each "volunteerid" and "activity" value using dcast() function.

24) Summarized data frame saved to CSV using write.csv() in R.
