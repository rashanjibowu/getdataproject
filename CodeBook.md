# The Code Book


## The Data

The data represent the average of measurements from a gyroscope and accelerometer for each of 30 subjects for a subset of columns in a larger dataset. The subset of columns that populate this data set focus on the means and standard deviations of the many raw measurements taken on magnitude and direction from the gyroscope and accelerometer instruments.

## The Variables

In general, the variables below contain the means of all of the observations of the individual measurements in the original dataset. Many of the variables are suffixed with an X, Y, or Z, indicating the direction component of the measurement.

### Time Variables
###### Linear Acceleration - Direction
- **tBodyAccMean(X,Y,Z)**: Average body motion components of acceleration for respective axial direction
- **tBodyAccSTD(X,Y,Z)**: Average standard deviation of body modtion acceleration for respective axial direction
- **tGravityAccMean(X,Y,Z)**: Average linear acceleration due to gravity for respective axial direction
- **tGravityAccSTD(X,Y,Z)**: Average standard deviation of linar acceleration due to gravity for respective axial direction
- **tBodyAccJerkMean(X,Y,Z)**: Average of jerk signals of body linear acceleration for respective axial direction
- **tBodyAccJerkSTD(X,Y,Z)**: Average standard deviation of jerk signals for linear acceleration for respective axial direction

##### Angular Velocity - Direction
- **tBodyGyroMean(X,Y,Z)**: Average angular velocity of body motion for respective axial direction
- **tBodyGyroSTD(X,Y,Z)**: Average standard deviation of angular velocity of body motion for respective axial direction
- **tBodyGyroJerkMean(X,Y,Z)**: Average jerk signal of angular velocity of body motion for respective axial direction
- **tBodyGyroJerkSTD(X,Y,Z)**: Average standard deviation of jerk signals of angular velocity of body motion for respective axial direction

##### Linear Acceleration - Magnitude
- **tBodyAccMagMean**: Average magnitude of body motion linear acceleration
- **tBodyAccMagSTD**: Average standard deviation of measurements of body component of acceleration magnitude
- **tGravityAccMagMean**: Average magnitiude of gravity component of acceleration
- **tGravityAccMagSTD**: Average standard deviation of magnitude of body motion linear acceleration
- **tBodyAccJerkMagMean**: Average jerk signal of magnitude of body motion linear acceleration
- **tBodyAccJerkMagSTD**: Average standard deviation of jerk signal of magnitude of body motion linear acceleration

##### Angular Velocity - Magnitude

- **tBodyGyroMagMean**: Average of angular velocity magnitudes
- **tBodyGyroMagSTD**: Average standard deviation of angular velocity magnitudes
- **tBodyGyroJerkMagMean**: Average jerk signal of angular velocity magnitudes
- **tBodyGyroJerkMagSTD**: Average standard deviation of jerk signals of angular velocity magnitudes

### Frequency Variables
##### Linear Acceleration - Direction
- **fBodyAccMean(X,Y,Z)**: Average linear boddy acceleration for respective axial direction
- **fBodyAccSTD(X,Y,Z)**: Average standard deviation of linear boddy acceleration for respective axial direction
- **fBodyAccMeanFreq(X,Y,Z)**: Average frequency signal of body acceleration for respective axial direction
- **fBodyAccJerkMean(X,Y,Z)**: Average jerk signals for linear acceleration for respective axial direction
- **fBodyAccJerkSTD(X,Y,Z)**: Average standard deviation of jerk signals for linear acceleration for respective axial direction
- **fBodyAccJerkMeanFreq(X,Y,Z)**: Average frequency signal for jerk signal of body linear acceleration for respective axial direction

##### Angular Velocity - Direction

- **fBodyGyroMean(X,Y,Z)**: Average angular velocity of body motion for respective axial direction
- **fBodyGyroSTD(X,Y,Z)**: Average standard deviation of angular velocity of body motion for respective axial direction
- **fBodyGyroMeanFreq(X,Y,Z)**: Average frequency signal of angular velocity for respective axial direction

##### Linear Acceleration - Magnitude

- **fBodyAccMagMean**: Average magnitude of body motion linear acceleration
- **fBodyAccMagSTD**: Average standard deviation of magnitude of body motion linear acceleration
- **fBodyAccMagMeanFreq**: Average frequency signal of body motion linear acceleration magnitude
- **fBodyBodyAccJerkMagMean**: Average jerk signal of magnitude of body motion linear acceleration
- **fBodyBodyAccJerkMagSTD**: Average standard deviation of jerk signal of magnitude of body motion linear acceleration
- **fBodyBodyAccJerkMagMeanFreq**: Average frequency signal of jerk signals of body motion linear acceleration magnitudes

##### Angular Velocity - Magnitude

- **fBodyBodyGyroMagMean**: Average of angular velocity magnitudes
- **fBodyBodyGyroMagSTD**: Average standard deviation of angular velocity magnitudes
- **fBodyBodyGyroMagMeanFreq**: Average frequency signal of angular velocity magnitudes
- **fBodyBodyGyroJerkMagMean**: Average jerk signal of angular velocity magnitudes
- **fBodyBodyGyroJerkMagSTD**: Average standard deviation of jerk signals of angular velocity magnitudes
- **fBodyBodyGyroJerkMagMeanFreq**: Average frequency signal of jerk signals of angular velocity magnitudes


#### Angle Variables

- **angletBodyAccMeanGravity**: Average angle of gravity
- **angletBodyAccJerkMeanGravityMean**: Average angle of jerk of gravity
- **angletBodyGyroMeanGravityMean**: Average angle of gravity
- **angletBodyGyroJerkMeanGravityMean**: Average angle of jerk of gravity
- **angle(X,Y,Z)GravityMean**: Average angle of gravity for respective axial direction

#### Other Variables

- **subject**: Indicator for the person on whom the measurements were taken
- **activityLabel**: Label for the activity the subject was performing when the measurement was taken


## Transformations

To create this data set, I applied several transformations to the initial data set, including:

1. Rename data columns of features dataset **("features.txt")** to "id" and "name" for clarity
1. Rename variable names in main test and training datasets **("test/X_test.txt" and "train/X_train.txt")** to the values of the "name" column in the features **("features.txt")** data set
1. Add new column to the training and test datasets to identify the subjects and the activities using the datasets for subjects **("test/subject_test.txt" / "train/subject_train.txt")** and activities **("test/y_test.txt" / "train/y_train.txt")**
1. Subset the test and training datasets by extracting those column names that have "mean" and "std" in the name
1. Merge the test and training data set on the subject key
1. Convert the activity code column into an activity label column with more descriptive names using the activities labels **("activity_labels.txt")** dataset
1. Cleaned the resulting column names in the merged data set by: Removing dashes, parentheses, and commas
1. Cleaned the resulting column names in the merged data set by: Capitalizing "mean", "std", and "gravity" for a consistent naming convention
1. Removed activity code column because it is both duplicative of and less descriptive than the recently created activity label column