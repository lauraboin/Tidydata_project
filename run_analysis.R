#PART 1: MERGE TRAINING AND TEST SETS TO CREATE ONE DATA SET
#Step 1: Download and unzip data to local
#Step 2: Read data
#set working directory
library(dplyr)
library(data.table)

# READ FEATURES DATA
features <- read.table('features.txt', header=FALSE)
# READ ACTIVITY DATA
activity <- read.table('activity_labels.txt', header=FALSE)
colnames(activity)<-c('id','actions') #rename activity columns to id and actions(walk,lay,etc.)

# READ TRAINING DATA
xtrain <- read.table('train\\X_train.txt', header=FALSE) #column numbers matches 'features'
ytrain <- read.table('train\\y_train.txt', header=FALSE)
subjecttrain <- read.table('train\\subject_train.txt', header=FALSE)
subjecttrain<-subjecttrain %>% rename(subjectID=V1) #to avoid V1 confusion
#7352 observations

# READ TEST DATA
xtest <- read.table('test\\X_test.txt', header=FALSE) #column numbers matches 'features'
ytest <- read.table('test\\y_test.txt', header=FALSE) #activity
subjecttest <- read.table('test\\subject_test.txt', header=FALSE)
subjecttest <- subjecttest %>% rename(subjectID=V1) #to avoid V1 confusion
#2947 observations

#Step 3:Add column names to both train and test data
features <- features[,2] #select only col 2 containing feature names
feat_transpose <-t(features) #transpose features
colnames(xtrain) <- feat_transpose #apply transposed feature name to xtrain
colnames(xtest) <- feat_transpose #apply transposed feature name to xtest
#now xtrain and xtest have column names



#Step 4: Merge training set and test set to create one dataset
#observe data dimensions to merge (first stage) accordingly by rbind (vertical combine)
combineX <- rbind(xtrain, xtest)
combineY <- rbind(ytrain, ytest)
combinesubj<-rbind(subjecttrain, subjecttest)
#combination has 10299 rows

#Merge (2nd stage) by cbind (horizontal combine)
combine2 <- cbind(combineY,combineX, combinesubj) #except activity
#10299 obs, 561 variables

#Complete the merge with activity
completedata <- merge(combine2, activity, by.x = 'V1', by.y = 'id')

#END OF PART 1

#PART 2: EXTRACT ONLY MEAN AND S.D. FOR EACH MEASUREMENT
#Step 1: Apply column names
colNames <- colnames(completedata) #assign column names
#Step 2: Subset out from 'completedata' retaining columns 'actions' and 'subjectID' and
#those containing "mean" or "std" in the column names.
subdata <- completedata %>% select(actions, subjectID, grep("\\bmean\\b|\\bstd\\b",colNames))

#PART 3:USE DESCRIPTIVE NAMES FOR ACTIVITIES IN DATASET
#Transform actions to a factor variable
class(subdata$actions) #class is character
subdata$actions <- as.factor(subdata$actions) #transformed to factor

#PART 4:LABEL THE DATASET WITH DESCRIPTIVE VARIABLE NAMES
#view column names of subdata
colnames(subdata)
#substitute abbreviations with descriptive names
colnames(subdata) <- gsub("^t", "time", colnames(subdata))
colnames(subdata) <- gsub("^f", "frequency", colnames(subdata))
colnames(subdata) <- gsub("Acc", "Accelerometer", colnames(subdata))
colnames(subdata) <- gsub("Gyro", "Gyroscope", colnames(subdata))
colnames(subdata) <- gsub("Mag", "Magnitude", colnames(subdata))
colnames(subdata) <- gsub("BodyBody", "Body", colnames(subdata))
colnames(subdata) <- gsub("tBody", "TimeBody", colnames(subdata))

#PART 5:FROM DATASET ABOVE (subdata), CREATE A 2ND INDEPENDANT TIDY DATASET
#WITH AVERAGE OF EACH VARIABLE FOR EACH ACTIVITY AND SUBJECT

#Step 1:Check subjectID class
class(subdata$subjectID)  #integer
subdata$subjectID <- as.factor(subdata$subjectID) #transform to factor
#Step 2:Create tidy data
tidydata <- aggregate(. ~subjectID + actions, subdata, mean)
#Step 3:Generate .txt file as final output
write.table(tidydata, file = "tidydata.txt",row.name=FALSE)



