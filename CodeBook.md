# Summarised Tidy Data (of the UCI HAR Dataset)
------
summarised_tidy_data.txt contains a summarised and tidied representation of the UCI HAR Dataset. At a high level, each measurement presented in the table represents the mean of all measurements for that variable grouped by the subject in question and the activity the subject was undertaking when the measurement was taken.

The following is the output upon loading the data into a dplyr data frame and printing it to the console:

```
Source: local data frame [180 x 50]

   Activity.Labels Subject tBodyAcc.mean.X tBodyAcc.mean.Y tBodyAcc.mean.Z
            (fctr)   (int)           (dbl)           (dbl)           (dbl)
1           LAYING       1       0.2215982     -0.04051395      -0.1132036
2           LAYING       2       0.2813734     -0.01815874      -0.1072456
3           LAYING       3       0.2755169     -0.01895568      -0.1013005
4           LAYING       4       0.2635592     -0.01500318      -0.1106882
5           LAYING       5       0.2783343     -0.01830421      -0.1079376
6           LAYING       6       0.2486565     -0.01025292      -0.1331196
7           LAYING       7       0.2501767     -0.02044115      -0.1013610
8           LAYING       8       0.2612543     -0.02122817      -0.1022454
9           LAYING       9       0.2591955     -0.02052682      -0.1075497
10          LAYING      10       0.2802306     -0.02429448      -0.1171686
..             ...     ...             ...             ...             ...
Variables not shown: tBodyAcc.std.X (dbl), tBodyAcc.std.Y (dbl), tBodyAcc.std.Z
  (dbl), tGravityAcc.mean.X (dbl), tGravityAcc.mean.Y (dbl), tGravityAcc.mean.Z
  (dbl), tGravityAcc.std.X (dbl), tGravityAcc.std.Y (dbl), tGravityAcc.std.Z
  (dbl), tBodyAccJerk.mean.X (dbl), tBodyAccJerk.mean.Y (dbl),
  tBodyAccJerk.mean.Z (dbl), tBodyAccJerk.std.X (dbl), tBodyAccJerk.std.Y
  (dbl), tBodyAccJerk.std.Z (dbl), tBodyGyro.mean.X (dbl), tBodyGyro.mean.Y
  (dbl), tBodyGyro.mean.Z (dbl), tBodyGyro.std.X (dbl), tBodyGyro.std.Y (dbl),
  tBodyGyro.std.Z (dbl), tBodyGyroJerk.mean.X (dbl), tBodyGyroJerk.mean.Y
  (dbl), tBodyGyroJerk.mean.Z (dbl), tBodyGyroJerk.std.X (dbl),
  tBodyGyroJerk.std.Y (dbl), tBodyGyroJerk.std.Z (dbl), fBodyAcc.mean.X (dbl),
  fBodyAcc.mean.Y (dbl), fBodyAcc.mean.Z (dbl), fBodyAcc.std.X (dbl),
  fBodyAcc.std.Y (dbl), fBodyAcc.std.Z (dbl), fBodyAccJerk.mean.X (dbl),
  fBodyAccJerk.mean.Y (dbl), fBodyAccJerk.mean.Z (dbl), fBodyAccJerk.std.X
  (dbl), fBodyAccJerk.std.Y (dbl), fBodyAccJerk.std.Z (dbl), fBodyGyro.mean.X
  (dbl), fBodyGyro.mean.Y (dbl), fBodyGyro.mean.Z (dbl), fBodyGyro.std.X (dbl),
  fBodyGyro.std.Y (dbl), fBodyGyro.std.Z (dbl)
```
------
### Each Variable in more detail:

The first two variables classify a single set of measurements made by the wearable device.

- `Activity.Labels` The activity performed when the observation is made. One of: `LAYING, SITTING, STANDING, WALKING, WALKING_DOWNSTAIRS, WALKING_UPSTAIRS`
- `Subject` The integer id of the subject for whom the measurement is made. The values range from 1 to 30.

The remaining variables each represent the population mean of all measurements of the same variable grouped by `Activity.Labels` and `Subject`. These variables are defined by 4 pieces of information. Rather than duplicating descriptions in a redundant fashion, I am opting to describe these 4 pieces of information and their variations, that when combined, make up all 48 variables.

Each variable is written in the form `tBodyAcc.mean.X` where the 4 components are as follows:

```
Domain Signal     Measurement    Operation   Constraint
't'               'BodyAcc'      'mean'      'X'
```

#### Domain Signal

The domain signal component of the variable can take one of two values. These description have been copied with the feature descriptions that accompanied the original UCI HAR data set.

- `t` The time domain signals were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise.
- `f` The frequency domain signals were calculated by applying a Fast Fourier Transform (FFT) to some of time domain signals.

#### Measurement

The measurement can take one of the following 5 values:

- `BodyAcc` The accelerometer measurement isolated as a body acceleration signal.
- `GravityAcc` The accelerometer measurement isolated as a gravity acceleration signal.
- `BodyAccJerk` The linear acceleration derived in time (ie the acceleration of the acceleration).
- `BodyGyro` The gyroscope measurement isolated as a body acceleration signal.
- `BodyGyroJerk` The angular velocity derived in time (ie the acceleration of the rate of rotation).

#### Operation

Two operations applied as a part of the original data set have been included in this summary data set:

- `mean` The mean value.
- `std` The standard deviation.

#### Constraint

The constraint of the measurement can take one of these three values:

- `X` The x axis signal relative to the device.
- `Y` The y axis signal relative to the device.
- `Z` The z axis signal relative to the device.
