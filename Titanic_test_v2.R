library(gdata)
library(dummies)
library(plyr)
library(dplyr)
library(ggplot2)
library(tidyr) # Importing Packages
my_data <- read.csv("titanic3.csv")

#Looking at the data
head(my_data)
tail(my_data)
dim(my_data)
summary(my_data)
colnames(my_data)[1] <- "pclass"

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

#filling in missing data in the "survived" column
for(j in 1:1310){
  if(is.na(my_data$survived[[j]])){
    my_data$survived[[j]] = 0
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

# titanic is avaliable in your workspace
# 1 - Check the structure of titanic
str(my_data)

# 2 - Use ggplot() for the first instruction
ggplot(my_data, aes(x = pclass, fill = sex)) +
  geom_bar(position = "dodge")

# 3 - Plot 2, add facet_grid() layer
ggplot(my_data, aes(x = pclass, fill = sex)) +
  geom_bar(position = "dodge") +
  facet_grid(.~ survived)

# 4 - Define an object for position jitterdodge, to use below
posn.jd <- position_jitterdodge(0.5, 0, 0.6)

# 5 - Plot 3, but use the position object from instruction 4
ggplot(my_data, aes(x = pclass, y = age, col = sex)) +
  geom_point(size = 3, alpha = 0.5, position = posn.jd) +
  facet_grid(.~ survived)