
#This function will read the test and train datasets from the 
# UCI HAR Dataset and combine them into one main dataset. 
# Only mean and standard deviation observations will be retained. 
# The activities will be described as text instead of a numeric ID. 
# The end product is a dataframe grouped on subject and activity where 
# all the observations are averaged. 

run_analysis <- function(basepath = './UCI HAR Dataset')
{
    
    #LaF is a package designed for rapidly reading large ASCII files
    #It creates a connector to the file which can be used to create a connector
    #afterwards. 
    if(!"LaF" %in% installed.packages())
    {
        install.packages("LaF")
    }
    library(LaF)
    
    #A check is made to see if dplyr is already installed. If this is not the case, it will
    #install dplyr
    if(!"dplyr" %in% installed.packages())
    {
        install.packages("dplyr")
    }
    library(dplyr)
    
    #The activity labels are being read in and placed in the activitiesfile variable
    activitiesfilename <- paste(basepath, "activity_labels.txt", sep="/")
    activitiesfile <- read.csv(activitiesfilename, header = FALSE, sep=" ", stringsAsFactors = FALSE, col.names=c("activityid", "activity"))
    
    #The headers are being read from the features.txt file. They contain the names for the various observations in the 
    #training and test datasets. 
    headerfilename <- paste(basepath, "features.txt", sep="/")
    headerfile <- read.csv(headerfilename, header = FALSE, sep=" ", stringsAsFactors = FALSE)
    #the headerfile contains both a number and an activity column. Since the numbers are sequential, we can remove these
    #and rely on the index instead, thereby changing the dataframe to a vector. 
    headers <- headerfile[,2]
    #create a logical vector where a variable in the headers vector can contain either std() or mean() to filter on
    #standard deviation and mean respectively. 
    validcolumns <- grepl("(std()|mean())", headers)
    #use the logical vector to filter out all the unwanted observations in the header file. This vector can be used 
    #later on to add headers to the dataset. 
    validheaders <- headers[validcolumns]
    
    #readdataset is an internal function responsible for reading and formatting the 
    #test and train datasets. Since both datasets are so similar, it's more convenient to write
    #a single function to handle both sets. 
    #the end result is a dataset where the the observations have been filtered on mean() and std()
    #and where the subject and activities IDs have been added as seperate columns on the left. 
    #It takes the type variable for indication on wether it needs to read the train or test dataset. The variable
    #should match the proper subfolder in the UCI datasetfolder. 
    readdataset <- function( type)
    {
        #create a path to the proper subfolder
        path <-  paste(basepath, type, sep="/")
        
        #Read in the observations. Filename is being determined by the type variable. 
        xfilename <- paste(paste("X", type, sep="_" ), "txt", sep=".")
        #Create a path to the file proper by combining xfilename and path. 
        xfilepath = paste(path, xfilename, sep="/")
        #Observations will be read in as a fixed width file. We need to the amount of widths later on. 
        #Documentation mentions that there are 561 observations. Every observation is 16 characters wide. 
        xwidths <- rep(16, each=561)
        #To speed up reading we will provide a vector stating that every observation is of a numeric type
        #It is also a requirement for the laf_open_fwf function. 
        xclasses <- rep("numeric", each= 561)
        #We open up a connector to the required file. 
        xfileconnector  <- laf_open_fwf(xfilepath, column_widths =xwidths,  column_types = xclasses)
        #We read all rows and columns from the fileconnector and store it in variable xfile. 
        xfile <- xfileconnector[,]
        #We only select the columns that have been selected earlier to contain "std()" and "mean()" strings. 
        xfile <- xfile[,validcolumns]
        #We add the proper column names to the xfile dataframe. 
        colnames(xfile) <- validheaders
        
        #We read the Y dataset with a fixed width
        yfilename <- paste(paste("y", type, sep="_" ), "txt", sep=".")
        yfilepath = paste(path, yfilename, sep="/")
        yfile <- read.fwf(yfilepath, 2, colClasses = "integer", col.names ="activityid")
        #We merge yfile with the activity labels we defined earlier and only select
        #the labels column at the end. 
        yfile <- merge(activitiesfile, yfile, x.by="activityid", y.by="activityid")
        yfile <- yfile[,2]
        
        #The subjects are being selected here and added to their own dataframe. 
        subjectfilename <- paste(paste("subject", type, sep="_" ), "txt", sep=".")
        subjectfilepath = paste(path, subjectfilename, sep="/")
        subjectfile <- read.fwf(subjectfilepath, 2, colClasses="integer", col.names="subjectid")
        
        #all three dataframes are now being combined to one. 
        result  <- cbind( subjectfile, yfile, xfile)
        #Activity lost it's column name when it got converted to vector. It's being added again here. 
        colnames(result)[2] <- "activity"
        #return the result. 
        result
    }
    
    #read the traindata
    traindata <- readdataset("train")
    #read the testdata
    testdata <- readdataset("test")
    #merge both datasets
    data <- rbind(traindata, testdata)
    
    #turn the dataframe into a dplyr table for easier manipulation. 
    data <- tbl_df(data)
    
    #A result table is being created based on the data table. 
    #First we group the data based on subjectid and activity
    result  <- group_by(data, subjectid, activity)
    #Then we average every other column with the summarise_each function. 
    result <- summarise_each(result, funs(mean))
    #Because we like to make sure our is data ordered, we put in an arrange at no extra cost :)
    result <- arrange(result, subjectid, activity)
    
    #The result is a table with 81 columns containing 79 averaged observations grouped
    #on the subjectid and the activity performed. 
    result
    
}
