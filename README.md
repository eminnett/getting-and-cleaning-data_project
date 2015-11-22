# Summarising and tidying the UCI HAR dataset
----

This document walks through the script `run_analysis.R` that attempts to load, tidy and summarise the UCI HAR dataset described [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) and that can be downloaded [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

The script has is written based upon the following assumptions:

- The [dataset](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) has been downloaded and unzipped inside a folder called 'data' that is a sibling of the script within the filesystem.
- The [dplyr](https://cran.r-project.org/web/packages/dplyr/index.html) package has been installed within the R workspace.
- The [tidyr](https://cran.r-project.org/web/packages/tidyr/index.html) package has been installed within the R workspace.

The initial step within the script is to load each of the 6 datasets (train and test data for the subject, x, and y tables). The subject table contains data regarding the subject each observation relates to, the x table contains all of the summarise device measurements, and the y table contains an integer classification for each observation that relates to the activity performed by the subject when the observation is recorded. After loading each dataset, the data is then wrapped by dplyr data frames in order to allow processing and analysis with dplyr and tidyr.

As we are only tidying the data and not explicitly performing any supervised machine learning algorithms on the data, we combine the training and test datasets into single data frames each for the subject, x and y tables.

We then load the feature labels from the original dataset. These act as human readable labels for each of the integer values found in the x table of measurements.

In order to make it easier to execute select and filtering operations upon the feature labels, the script performs a series of operations to transform the table that initially looks like:

```
    V1                V2
 1   1 tBodyAcc-mean()-X
```

And turn it into this:

```
    Column.Label   Measurement   Operation   Constraint
 1  V1             tBodyAcc      mean        x
```

The brief requests that the output summarised and tidy dataset only contains variables related to means and standard deviations. The next part of the script filters the features to meet this requirement.

Now that we have the filtered features, we select only the variables in the x table of measurements that match the filtered features.

By default the tables have loaded with generic variable names `V1` and so on. We now have enough information to replace these generic labels with more meaningful values. The next step in the script sets the labels with ones that match the pattern `tBodyAcc.mean.X`. In order to maintain the ability to map the features back to the column labels, the script updates features mapping with the new column label associated with each feature.

The next set of steps processes the y table of activity labels and subjects table to bind the human readable activity labels with the integer values as well as assigning more meaningful column labels to each of these two tables.

Now that we have meaningful data in each of the x, y and subjects tables, it is time to bind the columns of each of these into a single new table. The tidy dataset is starting to take shape.

The last data processing step is to compress the individual measurements and replace them with population means for each group of measurements. In order to accomplish this, the script first groups the data by activity and by subject. The script is then able to run a groupwise mean function call on each group of measurements. This last set of operations yields the summarised, tidy dataset as described in the brief.

The last step in the script exports the summarised, tidy dataset to `summarised_tidy_data.txt`.
