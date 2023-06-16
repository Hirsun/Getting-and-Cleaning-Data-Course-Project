# Getting-and-Cleaning-Data-Course-Project

This R script does the following to process the Human Activity Recognition Using Smartphones dataset: 
1. **Initialize:**  Checks if a data directory exists in the working directory. If not, it creates one. 
2. **Download and Unzip Dataset:**  Downloads the dataset ZIP file from the given URL and unzips it into the data directory. 
3. **Reading Data Files:**  Reads the dataset files (trainings tables, testing tables, feature vector, and activity labels) into R. 
4. **Renaming Columns:**  Appropriately renames columns of the imported tables for clarity and easy merging. 
5. **Merging Data:**  Combines the training and testing sets into one dataset. 
6. **Extracting Mean and Standard Deviation Measurements:**  Subsets the merged dataset to only include measurements of the mean and standard deviation. 
7. **Merging with Activity Labels:**  Merges the subsetted data with the activity labels to have descriptive activity names. 
8. **Creating Independent Tidy Data Set:**  Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
9. **Exporting Data:**  Writes the tidy data set to a .txt file.
## Codebook

The variables in the tidy data set are as follows: 
- `subjectId`: Identifier for each subject who performed the activity. Its range is from 1 to 30. 
- `activityId`: Identifier for each activity performed. It links to the `activityType` variable. 
- `activityType`: Descriptive name for each activity performed. Activities include WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, and LAYING.

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise.

The set of variables that were estimated from these signals are: 
- Mean: `mean()`: Mean value 
- Standard deviation: `std()`: Standard deviation

The complete list of variables in this tidy dataset is included in the `secTidySet.txt` file. The values are normalized and bounded within [-1,1].
