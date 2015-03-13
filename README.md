## The run_analysis script

#### Instructions

Running the script is straightforward. Simply load the file and execute run_analysis().

	source("run_analysis.R")
	run_analysis()

#### Under the hood

Under the hood, run_analysis() calls several other functions:

`downloadData()` looks for the files in your local directory. If you don't already have them, it will download and unzip them.

`loadData()` loads the various files into memory, including the main test and training data, subject labels, activity labels, and list of features.

`cleanData()` renames variables, adds columns to the test and training data sets, and extracts the only the mean and standard deviation columns for summary analysis and tidy data creation.

*At this point, we have postponed merging the data sets because there was no guarantee that the list of features would be exactly the same and in the same order for both the training and testing data. Therefore, the clean up step is performed on the training and test data sets 
separately.*

`mergeData()` merges the cleaned version of the training and test data sets on the subject column.

`addActivityLabels()` adds activity labels to the merged dataset based on the data in **activity_labels.txt**.

`cleanVariableNames()` removes punctuation from variable names and changes capitalization to reflect a cleaner naming convention.

`writeData()` writes the cleaned, merged dataset to a common-separated file nameed output.txt with column names and without row names.

#### Check out the code book
For more detail on the underlying data, check out the [codebook]("CodeBook.md")