## Description:
## ============

# This script performs the following Analysis steps:
# - Read the Dataset
# - Merges the training and the test sets to create one single data set.
# - Extracts only the measurements on the mean and standard deviation for each measurement. 
# - Uses descriptive activity names to name the activities in the data set
# - Appropriately labels the data set with descriptive variable names. 
# - Creates a second, independent tidy data set with the average of each variable 
#   for each activity and each subject.

# NOTES: 
# Coding style follows the *Google's R Style guide* reported in:
# https://google-styleguide.googlecode.com/svn/trunk/Rguide.xml

# ---------------
# Analysis steps:
# ---------------

source("./utility.R")  # now `get.filepath` function is in the namespace

# 0. Get Current file directory

current.wd <- get.filepath()
folder.dataset <- file.path(current.wd, "dataset", "UCI HAR Dataset")
folder.train <- file.path(folder.dataset, "train")
folder.test <- file.path(folder.dataset, "test")


# 1. Merge training and test sets to create one single data set.
# --------------------------------------------------------------

message("Performing Step 1: Merging Datasets")

# 1.1 Merge labeled data (i.e., X)
xTrain <- read.table(file.path(folder.train, "X_train.txt"))
xTest <- read.table(file.path(folder.test, "X_test.txt"))
X <- rbind(xTrain, xTest)

# 1.2 Merge Subject data
subTrain <- read.table(file.path(folder.train, "subject_train.txt"))
subTest <- read.table(file.path(folder.test, "subject_test.txt"))
subjects <- rbind(subTrain, subTest)

# 1.3 Merge Labels
yTrain <- read.table(file.path(folder.train, "y_train.txt"))
yTest <- read.table(file.path(folder.test, "y_test.txt"))
y <- rbind(yTrain, yTest)

# --------------------------------------------------------------------
# 2. Extracts the measurements of the mean and the standard deviation 
#    for each measurement.
# --------------------------------------------------------------------

message("Performing Step 2: Get Mean and Std of Measurements")

# Read the features
features <- read.table(file.path(folder.dataset, "features.txt"))

# Grep Mean and Std features only
features.selected <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])
X <- X[, features.selected]  # subset X by selecting only mean and std
names(X) <- features[features.selected, 2]
names(X) <- gsub("\\(|\\)", "", names(X))  # Remove brackets
names(X) <- gsub("\\-", " ", names(X))  # Replace dashes w/ blank spaces

# -------------------------------------------------------------------------
# 3. Uses descriptive activity names to name the activities in the dataset
# -------------------------------------------------------------------------

message("Performing Step 3: Rename activities in the dataset")

# Read Activities
activities <- read.table(file.path(folder.dataset, "activity_labels.txt"))

y[,1] <- activities[y[,1], 2]
names(y) <- "activity"  # set names of labels (i.e., y) to 'activity'

# ---------------------------------------------------------------------
# 4. Appropriately labels the data set with descriptive activity names.
# ---------------------------------------------------------------------

message("Performing Step 4: Re-label the dataset w/ descriptive names")

names(subjects) <- "subject"
data.cleaned <- cbind(subjects, y, X)
write.table(data.cleaned, 
            file.path(current.wd, "merged_and_cleaned_dataset.txt"))

message("merged_and_cleaned_dataset.txt file created!")

# --------------------------------------------------------------------
# 5. Creates an independent tidy data set with the average of 
#    each variable for each activity and each subject.
# --------------------------------------------------------------------

message("Performing Step 5: Create the Tidy dataset")

subjects.unique <- unique(subjects)[,1]
subjects.len <-  length(subjects.unique)
activities.len <- length(activities[,1])
columns <- ncol(data.cleaned)

data.tidy <- data.cleaned[1:(subjects.len * activities.len), ]
row <- 1
for (s in 1:subjects.len) {
	for (a in 1:activities.len) {
	  data.tidy[row, 1] <- subjects.unique[s]
	  data.tidy[row, 2] <- activities[a, 2]
		subset <- data.cleaned[data.cleaned$subject==s & 
                        data.cleaned$activity==activities[a, 2], ]
		data.tidy[row, 3:columns] <- colMeans(subset[, 3:columns])
		row <- row+1
	}
}

# Write the Tidy Dataset to file
write.table(data.tidy, 
            file.path(current.wd, "tidy_dataset_with_average_values.txt"), 
            row.names = FALSE)

message("tidy_dataset_with_average_values.txt file created!")
