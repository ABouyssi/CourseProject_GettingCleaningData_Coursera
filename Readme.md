# Code book

## Overview

This file presents my (Adrien Bouyssi's) work for the course project of Getting and cleaning data (getdata-014) on Coursera.
It comprises two parts:

1. I first describe how the code works (what steps were taken to process the data) in the **Code documentation** section,

2. Then I describe the final results file (variables description) in the **Results documentation** section.

## Code documentation

The purpose of this code is to transform the *Human Activity Recognition Using Smartphones Dataset Version 1.0* from Smartlab to extract only the average of the mean and standard deviation for each measurements taken for each activity and subject.

The first step is to download and unzip the dataset from the url provided: *https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip*.

We then proceed to read the train and test data in their respective folders, as well as the activity and feature labels in the root folder. Here we can ignore the detailed data as we are not going to repeat the Fourier analysis.

We then go on to combining the training and test data into one data frame and label the columns according to the feature names read above. In this step we also filter only the variables relatin to the mean and standard deviation of the various measurements taken (using their variable names).

The next step is to convert activity and subject ids into more descriptive names. We will do this by creating two functions: *convlabs* and *convsubj* and applying them to the combined X and y datasets.

The last processing steps consist of:

1. Combining descriptive activity and subject names, as well as the associated variables for mean and standard deviations into a tidy data frame.
2. Renaming the columns so that the labels are a little more explicit,
3. Using the _dplyr_ and _reshape2_ packages to calculate the average of all the measurements by variable, subject and activity.

Finally, we export the results data fram into a text file.


## Results documentation

The __res_reshaped.txt__ file is made of two identification columns:

- _activitylabeldescriptive_: this labels the activity performed by the subject wearing a smartphone (Samsung Galaxy S II) on the waist. The possible six activities  are walking, walkingupstairs, walkingdownstairs, sitting, standing and laying.

- _subjectdescriptive_: this labels the subject performing the activity in the first column.There are 30 subjects numbered from 1 to 30.

... and 66 variable columns. Each variable column the represents the average of all the measurements taken for this activity, subject and measure. The measures are either the mean or standard deviation of:

- Triaxial body and gravity acceleration as well as body jerk acceleration (derived from body acceleration) and body acceleration magnitude using Euclidean distance in temporal domain (t-prefix).

- Triaxial angular aceleration and jerk acceleration (derived from body acceleration) from the gyroscope and angular acceleration magnitude using Euclidean distance in temporal domain (t-prefix).

A Fourier transform was applied to these measures so that the same acceleration, jerk acceleration for body and gyroscope are available in the frequency domain (f-prefix).

All the variable mentioned above have been normalized.
Units are: 
- acceleration: m/s^2
- jerk acceleration: m/s^3
- angular acceleration: rad/s^2
- angular jerk acceleration: rad/s^3
in the time domain and:
- acceleration: m*s^2
- jerk acceleration: m*s^3
- angular acceleration: rad*s^2
- angular jerk acceleration: rad*s^3
in the frequency domain.