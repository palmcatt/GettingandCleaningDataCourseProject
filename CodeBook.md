CODEBOOK 
========

INTRODUCTION
------------
This Codebook.md describes the variables, the data and transformations that performed to clean up the data

DATA SOURCE
-----------
The data being used by this project, is provided via the course website, represent data collected from accerometers from the Samsung Galaxy S smartphone. Full description can be accessed via URL:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
(last accessed on 13th Nov 2016)

The data set saved under 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles$2FUCI%20HAR%20Dataset.zip
(last accessed on 13th Nov 2016)

DATA TRANSFORM
--------------
The original feature file contains 561-feature vectors, with time and frequency domain variables. Hence it would be more efficient to fixed the scope of the data range at the begining of the data processing.

VARIABLE: 
 - features 

After loading the feature list, based on the project requirement, ussing "mean" and "std" (standard deviation) to filte out the result. In other words, "mean" OR (i.e. "|") "std" should be grepped as target features. This will narrow the number of data columns from the original 561 to 79.

Kick off house-keeping actvitiy gets carried out to meet the naming rule, which also required by the project. Use "Mean" to replace "-mean", "Std" to replace "-std" and get rid of all "-()" characters.

VARIABLE: 
 - featuresExtracted 

To load the data sets:
1. Use featuresExtracted to Load the train/test, only get the mean/standard deviation measurements and save to "trainMeasure"/"testMeasure".
2. Directly load Activities value into "trainActivities"/"testActivities"
3. Directly load Subjects value into "trainSubjects"/"testSubjects"
4. Cbin Activities as 1st Column, Subject as 2nd Column and put rest together as full trainData & testData separately
5. Finally, merget the train-test data altogether, "append" the test data rows after the train data

VARIABLES:
 - trainMeasure
 - trainActivities
 - trainSubjects
 - trainData

 - testMeasure
 - testActivities
 - testSubjects
 - testData

 - allData
 
To make sure the columns of the data set using correct name, use colnames function to set 1st column with "subject", 2nd column with "activity" and rest using featuresExtracted.names

The last part of the script is to factorize "activity" and "subject", hence can perform mean against the values, and save it under "tidy.txt"

