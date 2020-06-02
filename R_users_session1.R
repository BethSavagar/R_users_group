
# R Users Group: Session 1 (Introduction)

# Exercises: 

#############################################################################################
#1. Import the measles dataset into the R environment, assigning it to an appropriate variable name.
#*Set your working directory to the folder where the data is stored as your first step*


#Set working directory:
setwd("~/OneDrive - Royal Veterinary College/PhD_year1/R_users_group")

#Read in dataset and assign to an appropriate variable "measles_data"
measles_data <- read.csv("measlesreportedcasesbycountry.csv")

#############################################################################################

#2. Explore the dataset: 
  #What information is contained within the dataset?
  #What variables are there within the dataset (what are the column names) and what type of data is stored within each column?
  #What are the dimensions of the dataset, what do these numbers correspond to?
  #Provide some summary descriptive statistics for the dataset


#What information is contained within the dataset?
View(measles_data)
head(measles_data)

#What variables are there within the dataset and what type of data is stored within each column
colnames(measles_data)
str(measles_data)
lapply(measles_data, class)

#What are the dimensions of the dataset and what do these numbers correspond to?
dim(measles_data) #rows (countries) and columns (variables)


#Provide some summary stats for the dataset
summary(measles_data)

#############################################################################################

#3. Further investigations
#which country recorded the highest number of measles cases in 2019 and how many cases were recorded?
  #How many countries had 0 measles cases in 2019?
  #How many cases has Belgium confirmed so far in 2020, store your answer in the variable "Belgium_cases_2019"?
  #Add a column to the dataset which contains the proportion of suspected cases which have been confirmed for 2020

#which country had the highest number of cases in 2019?
max_cases_2019 <- which.max(measles_data$Total.confirmed.measles.cases.2019) #find the index
measles_data[max_cases_2019, 1] #which country?
measles_data[max_cases_2019, "Total.confirmed.measles.cases.2019"] #how many cases

#How many countries recorded no measles cases in 2019
No_cases_2019 <- length(which(measles_data$Total.confirmed.measles.cases.2019 == 0))

#How many cases has Belgium confirmed so far in 2020?
Belgium_cases_2020 <- measles_data[measles_data$Member.State == "Belgium", "Total.suspected.measles.cases.2020"]

#How many countries recorded have recorded fewer cases than Belgium so far in 2020?
length(which(measles_data$Total.suspected.measles.cases.2020<Belgium_cases_2019))

#Add a new column with the proportion of suspected cases that have been confirmed for 2020
measles_data$proportion_confirmed_2020 <- (measles_data$Total.confirmed..measles.cases.2020)/(measles_data$Total.suspected.measles.cases.2020)

#############################################################################################

#4. Investigate data for the Americas
#Create a new dataframe containing only information for the Americas (AMRO) region
#Remove the data for 2019 and remove all rows containing NAs
#Recode the data in the column for suspected cases as a binary variable, with values above the median coded as "high" and values below the median coded as "low". (First copy the column so that the orginal data is not lost)


#Create a new dataframe containing only the Americas region
americas <- measles_data[measles_data$Region=="AMRO", ]

#Remove the data for 2019
americas <- americas[,-6]

#Remove NAs
americas <- na.omit(americas)

#Recode suspected cases as binary variable
americas_median <- median(americas$Total.suspected.measles.cases.2020)
americas$suspected_cases_binary <- americas$Total.suspected.measles.cases.2020
americas$suspected_cases_binary <- ifelse(americas$suspected_cases_binary>=americas_median, "High", "Low")


