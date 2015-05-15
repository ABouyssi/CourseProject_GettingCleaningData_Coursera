download.file(url = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
              , destfile = "Dataset.zip")

unzip("Dataset.zip")

# Read labels in the root folder (UCI HAR Dataset)
activity_labels = read.table("UCI HAR Dataset\\activity_labels.txt")
features = read.table("UCI HAR Dataset\\features.txt")

# Read training data in the train folder
# Read main training data 
subject_train = read.table("UCI HAR Dataset\\train\\subject_train.txt")
X_train = read.table("UCI HAR Dataset\\train\\X_train.txt")
y_train = read.table("UCI HAR Dataset\\train\\y_train.txt")


# Read test data in the train folder
# Read main test data 
subject_test = read.table("UCI HAR Dataset\\test\\subject_test.txt")
X_test = read.table("UCI HAR Dataset\\test\\X_test.txt")
y_test = read.table("UCI HAR Dataset\\test\\y_test.txt")


# Combine training and test data sets
subject = rbind(subject_train, subject_test)
X = rbind(X_train, X_test)
y = rbind(y_train, y_test)


# Add column names for matrix X
colnames(X) = features[,2]

# Extract mean and std columns from matrix X
col.mean = grep(pattern = "-mean()", x = colnames(X), fixed = TRUE)
col.std = grep("-std()", colnames(X))
X.extract = X[,c(col.mean, col.std)]

# Define function to convert activity numbers into activity labels
convlabs = function(x) {
  act_lab = tolower(activity_labels[x,2])
    gsub(pattern = "_", replacement = "", x = act_lab)
}
# Apply previously defined function to y vector
activitylabeldescriptive = as.factor(sapply(X = y[,1], FUN = convlabs))

#Define function to convert subject numbers into subject ids
convsubj = function(x) {
  paste0("subject", x)
}
#Apply previous function to the vector of subjects
subjectdescriptive = as.factor(sapply(X = subject, FUN = convsubj))


# Form the tidy dataset by adding subject ids, measurements
# and activity labels
X_tidy = cbind(subjectdescriptive,X.extract,activitylabeldescriptive)
colnames(X_tidy) = gsub(pattern = "-", replacement = "", x = colnames(X_tidy))
colnames(X_tidy) = gsub(pattern = "()", replacement = "", x = colnames(X_tidy),fixed = TRUE)
colnames(X_tidy)

install.packages("reshape2")
library(reshape2)

X_tidy_melted = melt(data = X_tidy
                     , id.vars = c("activitylabeldescriptive"
                                   , "subjectdescriptive")
                     )


install.packages("dplyr")
library(dplyr)

X_tidy_melted_df = tbl_df(X_tidy_melted)
results = X_tidy_melted_df %>% 
  group_by(variable, activitylabeldescriptive, subjectdescriptive) %>%
  summarize(value = mean(value)) %>%
  arrange(variable, activitylabeldescriptive, subjectdescriptive)

write.table(x = results, file = "results.txt", row.names = FALSE)
