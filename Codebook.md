# Samsung Tidy Data Codebook
These data were derived from data collected by the [UC Irvine Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). The original data were produced by having 30 participants perform a variety of activities while wearing a smartphone embedded with an accelerometer and a gyroscope. The tidy data dataset contains, for each subject and activity, an average of each mean and standard deviaiton movement measure in the original dataset. This dataset was generated using the R script, run_analysis.R.

##Processing
The script run_analysis.R performs three main tasks:  
1. Reading in the data found in the zipped files on the Machine Learning Repository
  1. Replacing the numeric activity codes with the string activity labels.  
  2. Replacing the variable numbers with variable names.  
     This required removing the parentheses and replacing the commas with periods. Neither parentheses or commas are allowed as element names.  
  3. Matching the subject ID to each line of data.
2. Manipulating and reshaping the data  
  1. The data was originally split between testing and training data sets. The script combines them into one data set.  
  2. Extract the mean and standard deviation measurements.  
     Measures of means were identified as containing the word "mean" in their title and measures of standard deviations were identified as containing the word "std" in their title.  
     Measures with the word "Mean" in their title were not considered mean measures. These measures represent an average across a signal window sample, rather than mean values of a single pattern.
3. Average the data so that every row represents one subject and each column represents the average movement measurements for a given activity.
4. Save the resulting data as a comma-separated values text file named "samsung_tidy_data.txt".  
  
##Variable Names
Each variable name represents a summary of the original data. For each mean and standard deviation measure, multiple trials were averaged within subjects and activities. Therefore, each variable in the tidy dataset is a combination of the one of six activities and the one of the 78 mean or standard deviation measures. The activities names can be found in the file, "activity_labels.txt" and the measurement names can be found in the file, "features.txt".