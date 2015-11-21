# This script assumes the dataset found at
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# has been unzipped into a sibling directory to this script called 'data'.

library(dplyr)
library(tidyr)


# Load the wearable computing datasets.
data_location <- paste(getwd(), "/data/UCI HAR Dataset", sep='')

data_subject_train <- read.table(paste(data_location, "/train/subject_train.txt", sep=''))
data_subject_test  <- read.table(paste(data_location, "/test/subject_test.txt", sep=''))

data_x_train <- read.table(paste(data_location, "/train/x_train.txt", sep=''))
data_x_test  <- read.table(paste(data_location, "/test/x_test.txt", sep=''))

data_y_train <- read.table(paste(data_location, "/train/y_train.txt", sep=''))
data_y_test  <- read.table(paste(data_location, "/test/y_test.txt", sep=''))

# Convert data to dplyr data frames.
subject_train <- tbl_df(data_subject_train)
subject_test  <- tbl_df(data_subject_test)

x_train <- tbl_df(data_x_train)
y_train <- tbl_df(data_y_train)

x_test  <- tbl_df(data_x_test)
y_test  <- tbl_df(data_y_test)

# Combine training and test data.
subject_combined <- bind_rows(subject_train, subject_test)
x_combined <- bind_rows(x_train, x_test)
y_combined <- bind_rows(y_train, y_test)

# Save the features for processing.
data_features <- read.table(paste(data_location, "/features.txt", sep=''))
features      <- tbl_df(data_features)

# A series of operations that will parse the features data from this format:
#    V1                V2
# 1   1 tBodyAcc-mean()-X
# Into:
#    Column.Label   Measurement   Operation   Constraint
# 1  V1             tBodyAcc      mean        x
new_feature_column_names <- c("Measurement", "Operation", "Constraint")
features <- features %>%
    extract(V2,
        new_feature_column_names,
        regex="([[:alnum:]]+)-([[:alnum:]]+)[:punct:]{2}-([[:alnum:]]+)",
        remove = TRUE) %>%
    mutate(V1=paste("V", V1, sep=''))
colnames(features) <- c("Column.Label", new_feature_column_names)

# Filter features that represent only mean and standard deviation operations.
mean_std_features <- filter(features, Operation == "mean" | Operation == "std")

# Select only the columns of x_combined that represent mean and standard deviation operations.
x_mean_std <- select(x_combined, one_of(select(mean_std_features, Column.Label)[[1]]))

# Rename x_mean_std column names with meaningful values.
meaningful_column_labels = paste(mean_std_features$Measurement, mean_std_features$Operation, mean_std_features$Constraint, sep=".")
colnames(x_mean_std) <- meaningful_column_labels

# Update mean_std_features with the new column labels
mean_std_features <- mutate(mean_std_features, Column.Label=meaningful_column_labels)

# Add descriptive labels to y_combined.
data_y_labels <- read.table(paste(data_location, "/activity_labels.txt", sep=''))
y_labels      <- tbl_df(data_y_labels)
y_combined    <- full_join(y_combined, y_labels)

# Isolate the descriptive activity labels and add a meanful column label.
activity_labels <- select(y_combined,V2)
colnames(activity_labels) <- c("Activity.Labels")

# Add a meaningful column name to subject_combined.
colnames(subject_combined) <- c("Subject")

# Add columns for the activity and subject to x_mean_std.
tidy_data <- tbl_df(bind_cols(x_mean_std, activity_labels, subject_combined))

# Add Activity and Subject groups to tidy_data.
tidy_data_by_activity_and_subject <- group_by(tidy_data, Activity.Labels, Subject)

# Take the mean of each measurement in the tidy_data set grouped by subject and activity.
summarised_tidy_data <- summarise_each(tidy_data_by_activity_and_subject, funs(mean))

# Output the summarised data to the console.
write.table(summarised_tidy_data, )
