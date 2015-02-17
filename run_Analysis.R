#The assignment is as follows.
#
# You should create one R script called run_analysis.R that does the following. 
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each 
#    measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set 
#   with the average of each variable for each activity and each subject.
#
# The first step is to download the data set from the server. This step could be done from within R. 
# The file is a .zip file and could be read and stored within the current working directory. Then one
# could use some of the methods described on stackoverflow or briefly covered in the lectures. 
# However, since it isn't part of the assignment I chose to simply download the file and store it 
# in a folder inside the folder on my local drive I use for this course and use as my working directory
# for this course.
#
# First set the working directory to the created directory for the data files.
setwd("~/Documents/Magic Briefcase/R Working Directory/Getting_and_Cleaning_Data/UCI HAR Dataset")
# Call the appropriate packages.
library(dplyr)
library(data.table)
library(tidyr)
# Reading the test datasets. 
subject_test <- read.table("~/Documents/Magic Briefcase/R Working Directory/Getting_and_Cleaning_Data/UCI HAR Dataset/test/subject_test.txt", quote="\"")
x_test <- read.table("~/Documents/Magic Briefcase/R Working Directory/Getting_and_Cleaning_Data/UCI HAR Dataset/test/X_test.txt", quote="\"")
y_test <- read.table("~/Documents/Magic Briefcase/R Working Directory/Getting_and_Cleaning_Data/UCI HAR Dataset/test/y_test.txt", quote="\"")
# Reading the train datasets
subject_train <- read.table("~/Documents/Magic Briefcase/R Working Directory/Getting_and_Cleaning_Data/UCI HAR Dataset/train/subject_train.txt", quote="\"")
X_train <- read.table("~/Documents/Magic Briefcase/R Working Directory/Getting_and_Cleaning_Data/UCI HAR Dataset/train/X_train.txt", quote="\"")
y_train <- read.table("~/Documents/Magic Briefcase/R Working Directory/Getting_and_Cleaning_Data/UCI HAR Dataset/train/y_train.txt", quote="\"")
# Adding column names to subject files.
colnames(subject_test) <- "Subject"
colnames(subject_train) <- "Subject"
# Adding column names to the label files.
colnames(y_test) <- "Label"
colnames(y_train) <- "Label"
# Redfine all of the data.frames as table dataframes.
subject_test <- tbl_df(subject_test)
subject_train <- tbl_df(subject_train)
x_test <- tbl_df(x_test)
X_train <- tbl_df(X_train)
y_test <- tbl_df(y_test)
y_train <- tbl_df(y_train)
# Adding the Descriptive Activity Labels to both of the y_test and y_train datasets.
y_test2 <- mutate(y_test, Training_Labels = ifelse(Label == 1, "WALKING", 
                                                             ifelse(Label == 2, "WALKING_UPSTAIRS",
                                                                    ifelse(Label == 3, "WALKING_DOWNSTAIRS",
                                                                           ifelse(Label == 4, "SITTING",
                                                                                  ifelse(Label == 5, "STANDING",
                                                                                         "LAYING"))))))
y_train2 <- mutate(y_train, Training_Labels = ifelse(Label == 1, "WALKING", 
                                                   ifelse(Label == 2, "WALKING_UPSTAIRS",
                                                          ifelse(Label == 3, "WALKING_DOWNSTAIRS",
                                                                 ifelse(Label == 4, "SITTING",
                                                                        ifelse(Label == 5, "STANDING",
                                                                               "LAYING"))))))
# Joining the Subject and y datasets
Sy_test <- cbind(subject_test, y_test2)
Sy_train <- cbind(subject_train, y_train2)
# Joining the test and training data in the x files with the previous table data frame.
Test_combine <- cbind(Sy_test, x_test)
Train_combine <- cbind(Sy_train, X_train)
# Combine the Test and Train combined sets via rbind.
TT_combine <- rbind(Test_combine, Train_combine)
# Select the columns of interest. All mean and standard deviation columns.
M_SD_Select <- select(TT_combine, Subject, Label, Training_Labels, V1:V6, V41:V46, V81:V86, V121:V126, V161:V166, V201, V202, V214, V215, V227, V228, V240, V241, V253, V254, V266:V271, V294:V296, V345:V350, V373:V375, V424:V429, V452:V454, V503, V504, V516, V517, V529, V530, V542, V543, V552, V556, V557, V558, V559, V560, V561)
# Label the columns with more descriptive terms from the features.txt file.
colnames(M_SD_Select)[4:9] <- c("mean_bodyacc_x", "mean_bodyacc_y", "mean_bodyacc_z", "sd_bodyacc_x", "sd_bodyacc_y", "sd_bodyacc_z")
colnames(M_SD_Select)[10:15] <- c("mean_gravacc_x", "mean_gravacc_y", "mean_gravacc_z", "sd_gravacc_x", "sd_gravacc_y", "sd_gravacc_z")
colnames(M_SD_Select)[16:21] <- c("mean_bodyaccjerk_x", "mean_bodyaccjerk_y", "mean_bodyaccjerk_z", "sd_bodyaccjerk_x", "sd_bodyaccjerk_y", "sd_bodyaccjerk_z")
colnames(M_SD_Select)[22:27] <- c("mean_bodygyro_x", "mean_bodygyro_y", "mean_bodygyro_z", "sd_bodyaccgyro_x", "sd_bodygyro_y", "sd_bodygyro_z")
colnames(M_SD_Select)[28:33] <- c("mean_bodygyrojerk_x", "mean_bodygyrojerk_y", "mean_bodygyrojerk_z", "sd_bodygyrojerk_x", "sd_bodygyrojerk_y", "sd_bodygyrojerk_z")
colnames(M_SD_Select)[34:35] <- c("mean_bodyaccmag", "sd_bodyaccmag")
colnames(M_SD_Select)[36:37] <- c("mean_gravityaccmag", "sd_gravityaccmag")
colnames(M_SD_Select)[38:39] <- c("mean_bodyaccjerkmag", "sd_bodyaccjerkmag")
colnames(M_SD_Select)[40:41] <- c("mean_bodygyromag", "sd_bodygyromag")
colnames(M_SD_Select)[42:43] <- c("mean_bodygyrojerkmag", "sd_bodygyrojerkmag")
colnames(M_SD_Select)[44:49] <- c("mean_fbodyacc_x", "mean_fbodyacc_y", "mean_fbodyacc_z", "sd_fbodyacc_x", "sd_fbodyacc_y", "sd_fbodyacc_z")
colnames(M_SD_Select)[50:52] <- c("meanfreq_fbodyacc_x", "meanfreq_fbodyacc_y", "meanfreq_fbodyacc_z")
colnames(M_SD_Select)[53:58] <- c("mean_fbodyaccjerk_x", "mean_fbodyaccjerk_y", "mean_fbodyaccjerk_z", "sd_fbodyaccjerk_x", "sd_fbodyaccjerk_y", "sd_fbodyaccjerk_z")
colnames(M_SD_Select)[59:61] <- c("meanfreq_fbodyaccjerk_x", "meanfreq_fbodyaccjerk_y", "meanfreq_fbodyaccjerk_z")
colnames(M_SD_Select)[62:67] <- c("mean_fbodygyro_x", "mean_fbodygyro_y", "mean_fbodygyro_z", "sd_fbodyaccgyro_x", "sd_fbodygyro_y", "sd_fbodygyro_z")
colnames(M_SD_Select)[68:70] <- c("meanfreq_fbodygyro_x", "meanfreq_fbodygyro_y", "meanfreq_fbodygyro_z")
colnames(M_SD_Select)[71:72] <- c("mean_fbodyaccmag", "sd_fbodyaccmag")
colnames(M_SD_Select)[73:74] <- c("mean_fbodyaccjerkmag", "sd_fbodyaccjerkmag")
colnames(M_SD_Select)[75:76] <- c("mean_fbodygyromag", "sd_fbodygyromag")
colnames(M_SD_Select)[77:78] <- c("mean_fbodygyrojerkmag", "sd_fbodygyrojerkmag")
colnames(M_SD_Select)[80:85] <- c("mean_angle_bodyaccjerkmean_grav", "mean_angle_bodygyromean_grav", "mean_angle_bodygyrojerkmean_grav", "mean_angle_grav_x", "mean_angle_grav_y", "mean_angle_grav_z")
# Save this cleaned and labeled file as a text file with write.table.
write.table(M_SD_Select, file = "M_SD_Select", sep = " ", col.names = TRUE)
# Save this cleaned and labeled file as a .csv file with write.csv. Not asked for in the assignment 
# but I prefer .csv and wanted to write this file as this format as well.
write.csv(M_SD_Select, file = "M_SD_Select.csv")
# Remove the original numeric Label Coding column.
M_SD_Select2 <- select(M_SD_Select, -Label)
# Gather the columns for all of the measures into one column and create a column
# for all of the mean values.
tidy_M_SD_Select <- gather(M_SD_Select2, Measure, mean, -Subject, -Training_Labels)
#Write the tidy data set. 
write.table(tidy_M_SD_Select, file ="tidy_data_long.txt", sep = " ")
