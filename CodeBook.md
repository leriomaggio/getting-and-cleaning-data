# Code Book

This code book describes the variables, the data, and any transformations or work performed to clean up the data.

## Source of the Data:

* Source of the original data:
  [https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip]().
* Original description:
  [http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones]().

## Dataset Information ##

(*adapted from the `README.txt` file in the Dataset package*)

**Human Activity Recognition Using Smartphones Dataset**

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. 
Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) 
wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, 
we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz.

The experiments have been video-recorded to label the data manually. 

The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for 
generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled 
in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, 
which has gravitational and body motion components, was separated using a 
[Butterworth low-pass filter](http://en.wikipedia.org/wiki/Butterworth_filter) into 
body acceleration and gravity. 
The gravitational force is assumed to have only low frequency components, 
therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained 
by calculating variables from the time and frequency domain. 

### The Data Package ###

The dataset includes the following files:

- `README.txt`
- `features_info.txt`: Shows information about the variables used on the feature vector.
- `features.txt`: List of all features.
- `activity_labels.txt`: Links the class labels with their activity name.
- `train/X_train.txt`: Training set.
- `train/y_train.txt`: Training labels.
- `test/X_test.txt`: Test set.
- `test/y_test.txt`: Test labels.

In particular, files contained in the `train` and in the `test` (sub)folders contains data that have been made available for 
training and testing respectively. However, since their description is the same, only training data will be described in the 
following:

- `train/subject_train.txt`: Each row refers to one (out of thirty) subject who performed the activity for each window sample. 
                             Therefore, values range from 1 to 30.      

- `train/Inertial Signals/total_acc_x_train.txt`: The acceleration signal from the smartphone accelerometer X axis in standard 
                                                    gravity units 'g'. Each row shows a `128` element vector. 
                                                    The same description applies for the `total_acc_x_train.txt` and for the
                                                    `total_acc_z_train.txt` files for the Y and Z axis.

- `train/Inertial Signals/body_acc_x_train.txt`: The body acceleration signal obtained by subtracting the gravity from the total acceleration.

- `train/Inertial Signals/body_gyro_x_train.txt`: The angular velocity vector measured by the gyroscope for each window sample. 
                                                  These values are expressed in `radians-per-second`. 

## Data Manipulation details

The `run_analysis.R` script performs the following operations to clean and transform the data:
     0. Read the dataset
     1. Merges the training and the test sets to create one single data set.
     2. Extracts only the measurements on the mean and standard deviation for each measurement. 
     3. Uses descriptive activity names to name the activities in the data set
     4. Appropriately labels the data set with descriptive variable names. 
     5. Creates a second, independent tidy data set with the average of each variable 
         for each activity and each subject.


### Merges the training and the test sets to create one single data set.

* `train/X_train.txt` & `test/X_test.txt`: this results in a `10299x561` data frame,
                                            as reported in the original description 
                                            ("Number of Instances: 10299" and "Number of Attributes: 561")

* `train/subject_train.txt` & `test/subject_test.txt`: this results in a `10299 x 1` data frame with subject IDs,

* `train/y_train.txt` & `test/y_test.txt`: this results in a `10299 x 1` data frame (as well) with activity IDs.

### Extracts only the measurements on the mean and standard deviation for each measurement. 

To perform this step, the script reads the file `features.txt`, and extracts only the measurements of the 
*mean* and the *standard deviation* of each measurement/example.

This results in a `10299 x 66` data frame, where `66` out of `561` features are selected and filtered in this step.

All measurements correspond to `numeric` (real) numbers in the range `(-1, 1)`.

### Uses descriptive activity names to name the activities in the data set ###

In this step, the script reads the file `activity_labels.txt`, and applies descriptive 
activity names to name the activities in the data set, namely:

- WALKING
- WALKING_UPSTAIRS
- WALKING_DOWNSTAIRS
- SITTING
- STANDING
- LAYING

### Appropriately labels the data set with descriptive variable names. ###

The script properly labels the dataset with descriptive names:
all feature names and activity names are converted to ,
underscores and brackets ("(", ")") are removed.

Finally, all the data are merged into a single `10299x68` data frame corresponding to:

- `10299x1` data frame of `subject IDs`;
- `10299x1` data frame of `activity labels`;
- `10299x68` data frame of `features`.

Subject IDs are `integers` with values in range `[1, 30]`.

Names of the attributes corresponds to:

- "tbodyacc-mean-x" 
- "tbodyacc-mean-y" 
- "tbodyacc-mean-z" 
- "tbodyacc-std-x" 
- "tbodyacc-std-y" 
- "tbodyacc-std-z" 
- "tgravityacc-mean-x" 
- "tgravityacc-mean-y" 
- "tgravityacc-mean-z" 
- "tgravityacc-std-x" 
- "tgravityacc-std-y" 
- "tgravityacc-std-z" 
- "tbodyaccjerk-mean-x" 
- "tbodyaccjerk-mean-y" 
- "tbodyaccjerk-mean-z" 
- "tbodyaccjerk-std-x" 
- "tbodyaccjerk-std-y" 
- "tbodyaccjerk-std-z" 
- "tbodygyro-mean-x" 
- "tbodygyro-mean-y" 
- "tbodygyro-mean-z"
- "tbodygyro-std-y"
- "tbodygyro-std-z"
- "tbodygyrojerk-mean-x"
- "tbodygyrojerk-mean-y"
- "tbodygyrojerk-mean-z"
- "tbodygyrojerk-std-x"
- "tbodygyrojerk-std-y"
- "tbodygyrojerk-std-z"
- "tbodyaccmag-mean"
- "tbodyaccmag-std"
- "tgravityaccmag-mean"
- "tgravityaccmag-std"
- "tbodyaccjerkmag-mean"
- "tbodyaccjerkmag-std"
- "tbodygyromag-mean"
- "tbodygyromag-std"
- "tbodygyrojerkmag-mean"
- "tbodygyrojerkmag-std"
- "fbodyacc-mean-x"
- "fbodyacc-mean-y"
- "fbodyacc-mean-z"
- "fbodyacc-std-x"
- "fbodyacc-std-y"
- "fbodyacc-std-z"
- "fbodyaccjerk-mean-x"
- "fbodyaccjerk-mean-y"
- "fbodyaccjerk-mean-z"
- "fbodyaccjerk-std-x"
- "fbodyaccjerk-std-y"
- "fbodyaccjerk-std-z"
- "fbodygyro-mean-x"
- "fbodygyro-mean-y"
- "fbodygyro-mean-z"
- "fbodygyro-std-x"
- "fbodygyro-std-y"
- "fbodygyro-std-z"
- "fbodyaccmag-mean"
- "fbodyaccmag-std"
- "fbodybodyaccjerkmag-mean"
- "fbodybodyaccjerkmag-std"
- "fbodybodygyromag-mean"
- "fbodybodygyromag-std"
- "fbodybodygyrojerkmag-mean"
- "fbodybodygyrojerkmag-std"

The result is saved as `merged_and_cleaned_dataset.txt`. 

### Create the Tidy Dataset

Finally, the script creates a second, and independent **tidy dataset** with the average
of each measurement for each activity and each subject.

The result is saved in the `tidy_dataset_with_average_values.txt` file, containing a `180x68` data frame, resulting
from `30` **subjects** and `6` **activities** (thus `180` rows, w/ averages).

Again, the data frame contains:
- `subject IDs` in the 1st column;
- `activity labels` in the 2nd column;
- the average of `features` in the next 66 columns.

**NOTE**: Please note that data in the tidy dataset are grouped by **subject**.
