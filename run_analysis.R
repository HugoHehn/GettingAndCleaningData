

## Check if path exists, download zip folder

if (!file.exists("./UCI HAR Dataset")){
        if (!file.exists("data.zip")) {
                download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "data.zip")
        }
        unzip("data.zip")
}

## Clean variable names in the Activity Labels file (convert to lowercase + remove underscores)
## Name variables in Activity Labels file

act_labels <- read.table("UCI HAR Dataset/activity_labels.txt", sep=" ", header=FALSE)
act_labels[,2] <- tolower(act_labels[,2])
act_labels[,2] <- gsub('[_]', '', act_labels[,2])
colnames(act_labels) <- c("activitynumber", "activitylabel")

## Clean variable names in the Features file (convert to lowercase + remove parentheses and dashes)
## Find variables containing means and standard deviations

feat <- read.table("UCI HAR Dataset/features.txt", sep=" ", header=FALSE)
feat[,2] <- tolower(feat[,2])
feat[,2] <- gsub('[-,()]', '', feat[,2])
colnames(feat) <- c("featurenumber", "featurelabel")

meansstd <- grep ("mean|std", feat[,2])


## Load and label files X_train, y_train and subject_train
## Subset data from the X_train file to only include mean and std variables

train_y <- read.table("UCI HAR Dataset/train/y_train.txt", header=FALSE)
colnames(train_y) <- c("activity")

train_x <- read.table("UCI HAR Dataset/train/X_train.txt")
train_x <- train_x[meansstd]
colnames(train_x) <- feat[meansstd,2]

train_subj <- read.table("UCI HAR Dataset/train/subject_train.txt", header=FALSE)
colnames(train_subj) <- c("volunteerid")


## Load and label files X_test, y_test and subject_test   
## Subset data from the X_test file to only include mean and std variables

test_y <- read.table("UCI HAR Dataset/test/y_test.txt", header=FALSE)
colnames(test_y) <- c("activity")

test_x <- read.table("UCI HAR Dataset/test/X_test.txt")
test_x <- test_x[meansstd]
colnames(test_x) <- feat[meansstd,2]

test_subj <- read.table("UCI HAR Dataset/test/subject_test.txt", header=FALSE)
colnames(test_subj) <- c("volunteerid")


## Merge files in training and test data frames separately (using cbind)
## Merge training and test data franes into one (using rbind)

train <- cbind(train_subj, train_y, train_x)
test <- cbind(test_subj, test_y, test_x)
merge <- rbind(train,test)

merge[,2] <- act_labels[merge[,2],2]


## Convert variables to factors in the merged data frame (when applicable)
## Write data to CSV file

merge[,1] <- as.factor(merge[,1])
merge[,2] <- as.factor(merge[,2])

write.csv(merge, "Merged and tidied data.csv")

## Melt and summarize averages for the merged data frame in a separate data frame
## Write data to CSV file

library(reshape2)
melt <- melt(merge, id=c("volunteerid", "activity"))
summary <- dcast(melt, volunteerid + activity ~ variable, mean)

write.csv(summary,"Summarized averages.csv")
