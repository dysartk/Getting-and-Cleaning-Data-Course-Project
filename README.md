This ReadMe file serves as the path for this assignment and describes the merging and
processing of the data files downloaded from:
Method of producing the final tidy data set.

First set the working directory to the created directory for the data files.
setwd() command.

Call the appropriate packages.
The following R packages are used in the creation of the 
	dplyr
	tidyr
	data.table

Reading the test datasets. 
Using the read.table command the subject, test and train datasets are read into R and 
assigned to an object for further manipulation.

Assigning column names to the subject and y data sets.
Using colnames() the individual subject and y data sets get a column name.
Subject and Label respectively.

Redfine all of the data frames as table dataframes.
All of the data frame objects are at this point redefined as table data frames using 
the tbl_df() command. This is done to enable the use of the dplyr package.

Adding the Descriptive Activity Labels to both of the y_test and y_train datasets.
2 new data frames are created from the original y_test and y_train datasets. These 
data frames now have a column labeled Training_Labels that contains a more descriptive 
character string from the original data set. The mutate command and a string of ifelse 
statements are used.
                                                                          
Joining the Subject and y datasets
Simply using the cbind command the appropriate subject and y data files are combined for 
each of the test and train sets. 2 data frames are created.

Joining the test and training data in the x files with the previous table data frame.
Next the data frames(2) from the last step are combined with the x_test and X_train data 
sets. 2 data sets remain as data frames.

Combine the Test and Train combined sets via rbind or full_join.
Lastly the Test and Train data sets are combined together. I saw there were 3 options 
here; rbind, merge and full_join(or other members of the join family from the dplyr 
package. They all work to combine the 2 data sets from the laststep. Because 
the method I have used to this point has created essentially duplicate data sets with 
duplicate columns rbind is an option. I used all three methods including 
merge during the development phase. However, rbind and full_join were significantly 
faster and lead to identical output data frames. I used the methods interchangeably.
Merge was very slow and actually lead to a different data frame. I confirmed all of this 
with the identical command.

Select the columns of interest. All mean and standard deviation columns.
Using the select() command I simply selected from the last data frame the columns of 
interest. I visually inspected the features.txt file and selected all of the rows with 
mean or sd in the list. After completing the assignment I realized I likely could have 
read the file into R. Assigned the values to a vector and then searched though for the 
mean and sd strings. Here I have left the manual method and have ended with 82 columns.

Label the columns with more descriptive terms from the features.txt file.
Using the last data frame I then added column names to the 82 columns via the colnames() 
command. This was meticulous and done with a substantial series of commands. I will
definitely look for an easier method in the future. However, they are all labeled as 
described in the Code Book.

Remove the original numeric Label Coding column.
Left over in the data frame is the original numeric code for the Training_Labels column. 
This is removed in this step with the select() command. Another data frame is created 
here simply -Label.

Gather the columns for all of the measures into one column and create a column
for all of the mean values.
In this next step the 82 measurement columns are condensed into one column with the 
measures becoming an identifier column for the dataset. The gather() function allows 
this to be completed. The value of each measure is placed in a new column, Value.
The data set now contains 844,518 rows

Group the table on the 3 identifiers.
Three grouping variables are added to the data set via the group_by() command.

Summarize the data for the final output.
Finally a data frame named final is created using the summarize() command with the last 
column created entitled mean that takes the mean of Value and creating the last column.
14,760 rows are now present on the last data from. This is equivalent to the wider final 
form of 180 rows of 82 measure columns. 

Write the tidy data set. 
Using the write.table command as instructed the last data file is created.
-----------------------------------------------------------------------------------------
This portion of the original README.txt is included here to maintain the integrity 
of the original data files.

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones#

The original README.txt file contained this information of importance. It is included 
here for completeness so that it is retained.

DITEN - Universit‡ degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws
==================================================================

The experiments have been carried out with a group of 30 volunteers within an age bracket
 of 19-48 years. Each person performed six activities
  (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) 
  wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded 
  accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial 
  angular velocity at a constant rate of 50Hz. The experiments have been video-recorded 
  to label the data manually. The obtained dataset has been randomly partitioned into 
  two sets, where 70% of the volunteers was selected for generating the training data 
  and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise
 filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap
  (128 readings/window). The sensor acceleration signal, which has gravitational and
   body motion components, was separated using a Butterworth low-pass filter into body 
   acceleration and gravity. The gravitational force is assumed to have only low 
   frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. 
   From each window, a vector of features was obtained by calculating variables from 
   the time and frequency domain. See 'features_info.txt' for more details. 

For each record it is provided:
======================================

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated 
body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

The dataset includes the following files:
=========================================

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are
 equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity
 for each window sample. Its range is from 1 to 30. 

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the
 smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128
  element vector. The same description applies for the 'total_acc_x_train.txt' 
  and 'total_acc_z_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained
 by subtracting the gravity from the total acceleration. 

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured
 by the gyroscope for each window sample. The units are radians/second.  
 
-----------------------------------------------------------------------------------------