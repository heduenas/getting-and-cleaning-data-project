if (!require("dplyr"))
{
  install.packages("dplyr")
  require("dplyr")
}

# load raw data (RAW DATA SHOULD BE ON A DIRECTORY CALLED "UCI HAR Dataset")
X_train <- read.table("UCI HAR Dataset/train/X_train.txt", header=FALSE,sep="")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", header=FALSE,sep="")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", header=FALSE,sep="")

X_test <- read.table("UCI HAR Dataset/test/X_test.txt", header=FALSE,sep="")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", header=FALSE,sep="")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", header=FALSE,sep="")

# merge data
data.train <- cbind(y_train, subject_train, X_train)
data.test <- cbind(y_test, subject_test, X_test)
data <- rbind(data.train, data.test)

# use meaningful feature names
feature.names <- read.table("UCI HAR Dataset/features.txt", header = F, sep = "", stringsAsFactors = F)
names(data)[-(1:2)] <- feature.names[, 2]
names(data)[1] <- "Activity"
names(data)[2] <- "Subject"

# filter mean and standard deviation features
features_subset <- grepl("mean|std", feature.names)
data <- data[, c(T, T, features_subset)]

# use maningful activity labels
activity.names <- read.table("UCI HAR Dataset/activity_labels.txt", header = F, sep = "", stringsAsFactors = F)
data$Activity <- factor(data$Activity, labels = activity.names[, 2])

# generate and write tidy data set
tidy.data <- data.frame(matrix(rep(0, 180*ncol(data)), ncol = ncol(data)))
colnames(tidy.data) = colnames(data)
for(i in 3:ncol(data))
{
  tidy.data[, c(1, 2, i)] <- aggregate(data[, i] ~ Activity + Subject, data = data, FUN = mean)
}

write.table(tidy.data, file="tidy_data.txt", row.name=FALSE)