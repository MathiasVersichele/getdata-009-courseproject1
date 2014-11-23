#setwd('/Users/mathiasversichele/git/getdata-009-courseproject1')

download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip', destfile='data.zip', method='curl')
unzip('data.zip')

act_labels <- read.table('./UCI HAR Dataset/activity_labels.txt')
names(act_labels) <- c('act_code', 'activity')

all_features <- as.character(read.table('./UCI HAR Dataset/features.txt')[,2])
features_colidxs <- grep('mean|std', all_features)

test_X <- read.table('./UCI HAR Dataset/test/X_test.txt')
test_y <- read.table('./UCI HAR Dataset/test/y_test.txt')
test_subject <- read.table('./UCI HAR Dataset/test/subject_test.txt')[,1]
names(test_X) <- all_features
test <- test_X[,features_colidxs]
test['y'] <- test_y
test['subject'] <- test_subject
test <- merge(test, act_labels, by.x='y', by.y='act_code')

train_X <- read.table('./UCI HAR Dataset/train/X_train.txt')
train_y <- read.table('./UCI HAR Dataset/train/y_train.txt')
train_subject <- read.table('./UCI HAR Dataset/train/subject_train.txt')[,1]
names(train_X) <- all_features
train <- train_X[,features_colidxs]
train['y'] <- train_y
train['subject'] <- train_subject
train <- merge(train, act_labels, by.x='y', by.y='act_code')

test['train'] <- FALSE
train['train'] <- TRUE

all_data <- rbind(train, test)
library(reshape)
all_data_molten <- melt(all_data, id.vars=c('subject', 'activity'))
tidy_data <- cast(subject + variable ~ activity, data = all_data_molten, fun = mean)

write.table(tidy_data, file='tidy_data.txt', row.names=F)