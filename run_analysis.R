#Getting Data Project

#Set file directories
main_dir = "/Users/student/Documents/Classes/JHDataScience/GettingData/Project/Repo/GettingData" #location of r file
data_dir = paste(main_dir,"/UCI HAR Dataset",sep = "")
test_dir = paste(data_dir,"/test",sep = "")
train_dir = paste(data_dir,"/train",sep = "")

#read in data

#Go to data directory and get labels
setwd(data_dir)
activity_labels = read.table("activity_labels.txt", col.names = c("ActID","ActLabel")) #relates activity IDs to activity label
feature_labels = read.table("features.txt", col.names = c("FeatID","FeatLabel")) #relates feature IDs to feature labels
#Clean up feature labels. Parentheses and commas are not allowed as element names
feature_labels$FeatLabel = gsub("()","",feature_labels$FeatLabel,fixed = TRUE) #remove parentheses
feature_labels$FeatLabel = gsub(",",".",feature_labels$FeatLabel,fixed = TRUE) #change comma to period
#Go to training directory and get training data
setwd(train_dir)
train_Ss = read.table("subject_train.txt", col.names = "SsID") #read in subject data
train_data = read.table("X_train.txt",col.names = feature_labels$FeatLabel) # read in observations
train_labels = read.table("y_train.txt",colClasses = "factor",col.names = "Activity") #read in activitity numbers
levels(train_labels$Activity) = activity_labels$ActLabel #convert numbers to labels
train = cbind(train_Ss,train_labels,train_data) #combine training data into one data frame

#Go to testing directory and get testing data
setwd(test_dir)
test_Ss = read.table("subject_test.txt", col.names = "SsID") #read in subject data
test_data = read.table("X_test.txt",col.names = feature_labels$FeatLabel) # read in observations
test_labels = read.table("y_test.txt",colClasses = "factor",col.names = "Activity") #read in activitity numbers
levels(test_labels$Activity) = activity_labels$ActLabel #convert numbers to labels
test = cbind(test_Ss,test_labels,test_data) #combine training data into one data frame

#Combine test and training data
data = rbind(train,test)

#Extract mean and standard deviation measurements. These variables include, "mean" or "std" in the title.
data_names = names(data)
mean_SD_data = data[,grepl("std",data_names)|grepl("mean",data_names)|grepl("SsID",data_names)|grepl("Activity",data_names)]

#Create new data set with the average of each variable for each activity and each subject.
library(reshape2)
mean_melt = melt(mean_SD_data,id.vars = c("SsID","Activity"))
mean_cast = dcast(mean_melt,SsID~Activity+variable,mean)
setwd(main_dir)
write.csv(mean_cast,file = "samsung_tidy_data.txt",row.names = FALSE)