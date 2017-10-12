library(gdata)
library(dummies)
library(plyr)
library(dplyr)
library(tidyr) # Importing Packages
my_data <- read.csv("titanic3.csv")

#Looking at the data
head(my_data)
tail(my_data)
dim(my_data)
summary(my_data)

#filling missing embarkment data, blanks should be S
for(i in 1:1310){
  if (my_data$embarked[[i]] == "C" | my_data$embarked[[i]] == "S" | my_data$embarked[[i]] == "Q") {
  } else {
    my_data$embarked[[i]] = "S"
  }
    
}

#using the mean age to fill in blank "Age" column values

for(j in 1:1310){
  if(is.na(my_data$age[[j]])){
    my_data$age[[j]] = 29.88
  } 
}

#using a for loop to add a dummy value to the "boat" column to indicate if they made it to a life boat

for(g in 1:1310){
  if(is.na(my_data$boat[[g]])){
    my_data$boat[[g]] = "NA"
  }
}


#adding a new column to show if the passenger had a cabin (1) or not (0)
class(my_data$cabin)
for(q in 1:1310){
  if(as.character(my_data$cabin[[q]] == "")){
    my_data$has_cabin_number[[q]] = 0
  } else{
    my_data$has_cabin_number[[q]] = 1
  }
}

summary(my_data)