WorkBook
================

The *run\_analysis.R* scripts prepare the data following five steps as
described in the README file and the course project’s definition.

1.  **Download the dataset**
      - Dataset was downloaded and extract under the folder called *UCI
        HAR Dataset*, as the name in the zip file.  
2.  **Loading data into R**
      - *features* comes from *features.txt*  
      - *activities* comes from *activity\_labels.txt*  
      - *subTest* comes from *subject\_test.txt*  
      - *xTest* comes from *x\_test.txt*  
      - *yTest* comes from *y\_test.txt*  
      - *subTrain* comes from *subject\_train.txt*  
      - *xTrain* comes from *x\_train.txt*  
      - *yTrain* comes from *y\_train.txt*
3.  **Merges the training and the test data sets**
      - *xTest* and *xTrain* was merged using rbind() function into a
        variable called xData  
      - *yTest* and *yTrain* was merged using rbind() function into a
        variable called yData  
      - *subTest* and *subTrain* was merged using rbind() function into
        a variable called subjectData  
      - mergerData was created using cbind() and mergind xData, yData
        and subjectData
4.  **Extracting measurements on the mean and sd for measurements**
      - extractData was created subsetting mergerData using two columns
        (subject and code) and the measurements on the mean and standard
        deviation for each measurement.
5.  **Using activity names to name the activities in the extract data**
      - The numbers in column code of extractData was replaced with
        correspondind second column from activities variable
6.  **Renaming the variables names**
      - code collum in extractData renamed into activities  
      - All Acc in column’s name replaced by accelerometer  
      - All Gyro in column’s name replaced by Gyroscope  
      - All BodyBody in column’s name replaced by Magnitude  
      - If the column’s name was started with f the name was replaced by
        Frequency  
      - If the column’s name was started with t the name was replaced by
        Time
7.  **Creating the tidy data**
      - finalTidyData was created by summarizind extractData taking the
        means of the variables for each activity and each subject.  
      - Export finalTidyData into TidyData.txt
