
# download date
dateDownloaded <- NULL
isDownloaded <- FALSE

# data handles
fullData <- NULL
trainingData <- NULL
trainingActivityLabels <- NULL
trainingSubjectLabels <- NULL

testData <- NULL
testActivityLabels <- NULL
testSubjectLabels <- NULL

features <- NULL
activityLabels <- NULL

# require the data.table package
library(data.table)

# download data
downloadData <- function() {

	print("Attempting to download and load data...")

	# set up source and destination paths
	source <- c("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip")
	destfile <- c("./data/har.zip")

	# download and load data
	if (!file.exists(destfile)) {

		print("Downloading data...")

		dir.create("./data")

		download.file(source, destfile = destfile, method = "curl")

		# update download date
		dateDownloaded <<- date()
		print("Download complete. Unzipping ...")

		# unzip the file in "data" directory
		unzip(destfile, exdir = "./data")
	}

	isDownloaded <- TRUE
	print("Data is downloaded and unzipped!")
}

loadData <- function() {

	# path variables
	base.path 				<- c("./data/UCI HAR Dataset/")

	# main data
	testData.path 			<- paste0(base.path, "test/X_test.txt")
	trainingData.path 		<- paste0(base.path, "train/X_train.txt")

	# activity labels
	testActivities.path		<- paste0(base.path, "test/y_test.txt")
	trainingActivities.path	<- paste0(base.path, "train/y_train.txt")

	# subject labels
	testSubjects.path		<- paste0(base.path, "test/subject_test.txt")
	trainingSubjects.path	<- paste0(base.path, "train/subject_train.txt")

	# list of features - will become the new variable names
	features.path 			<- paste0(base.path, "features.txt")
	activities.path 		<- paste0(base.path, "activity_labels.txt")

	# load data
	print("Loading training data ...")
	trainingData 			<<- read.table(trainingData.path)
	trainingSubjectLabels 	<<- read.table(trainingSubjects.path)
	trainingActivityLabels 	<<- read.table(trainingActivities.path)

	print("Loading test data ...")
	testData 				<<- read.table(testData.path)
	testSubjectLabels 		<<- read.table(testSubjects.path)
	testActivityLabels 		<<- read.table(testActivities.path)

	# load list of features - will become the new variable names
	print("Loading other data ...")
	features 				<<- read.table(features.path)
	activityLabels  		<<- read.table(activities.path)

	print("Data fully loaded!")
	#printStatus()
}

cleanData <- function() {

	print("Cleaning Data ...")

	# convert data frames into data tables
	features <<- data.table(features)
	testData <<- data.table(testData)
	trainingData <<- data.table(trainingData)
	testActivityLabels <<- data.table(testActivityLabels)
	trainingActivityLabels <<- data.table(trainingActivityLabels)
	trainingSubjectLabels <<- data.table(trainingSubjectLabels)
	testSubjectLabels <<- data.table(testSubjectLabels)

	# rename variable names in features
	setnames(features, names(features), c("id", "name"))

	# rename variable names in main data set with name of features
	varNames <- as.character(features$name)
	setnames(testData, names(testData), varNames)
	setnames(trainingData, names(trainingData), varNames)

	# add subject identifiers
	testData[, subject := testSubjectLabels]
	trainingData[, subject := trainingSubjectLabels]

	# add activity identifiers
	testData[, activityCode := testActivityLabels]
	trainingData[, activityCode := trainingActivityLabels]

	#printStatus()

	# extract only the measurements related to means and standard deviations
	selectedFeatures <- grep("[Mm]ean|std|subject|activityCode", names(testData), ignore.case = TRUE)
	testData <<- testData[ , { selectedFeatures }, with = FALSE]
	trainingData <<- trainingData[ , { selectedFeatures }, with = FALSE]
}

printStatus <- function() {
	print(paste("training:", nrow(trainingData), ncol(trainingData), sep = " "))
	print(tail(names(trainingData)))

	print(paste("test:", nrow(testData), ncol(testData), sep = " "))
	print(tail(names(testData)))
}

mergeData <- function() {

	print("Merging data ...")

	# merge training and test data
	setkey(trainingData, subject)
	setkey(testData, subject)

	commonColumns <- intersect(names(trainingData), names(testData))
	fullData <<- merge(trainingData, testData, by = commonColumns, all = TRUE)

	print(paste("Merge complete! The full data set has", nrow(fullData), "observations", sep = " "))
}

addActivityLabels <- function() {

	print("Adding activity labels ...")

	print(paste("The full data set has", nrow(fullData), "observations", sep = " "))
	print(paste("activityLabels has", nrow(activityLabels), "observations", sep = " "))

	fullData[, activityLabel := activityLabels[fullData$activityCode, 2]]
}

writeData <- function() {

	print("Writing data...")

	output <- fullData[,lapply(.SD, mean), by = c("activityLabel", "subject")]

	write.table(output, file = "./data/output.csv",
		row.names = FALSE,
		col.names = TRUE,
		sep = ",",
		quote = FALSE)

	print("Data is written!")
}

# Download and load data
run_analysis <- function() {

	downloadData()

	loadData()

	cleanData()

	mergeData()

	addActivityLabels()

	# create tidy dataset with average of each variable for each activity and subject
	writeData()

}