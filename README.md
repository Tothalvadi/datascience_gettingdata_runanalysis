# Course project week 4 for Getting Data 

Course project for the "Getting data" course. Included is a single R script which will read the UCI HAR dataset which can be found at this link: 
[https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip]

The purpose of this script is to combine the test and train datasets and present only the average and standard deviation observations. A complete description of the procedure is described in the codebook.md file accompanied in this repository. 

##Installation instructions:
1. Download and extract the dataset in a folder of your choice. 
2. Download and place the run_analysis.R script in the same or different folder

##Usage instructions
1. Source the run_analysis.R file 
2. call the run_analysis function with the location of the dataset folder where the "README.txt" file is located. 
3. A dplyr table will be returned with the assembled data. 

##Dependencies
run_analysis depends on the LaF and dplyr R packages. These will automatically be installed if they are not found on your computer. 


