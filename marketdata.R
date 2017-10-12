library(gdata)
library(dummies)
library(plyr)
library(dplyr)
library(tidyr) # Importing Packages
my_data <- read.table("refineoriginal.csv", sep  = ",", header = TRUE, colClasses = "character")
my_data
names(my_data)
dim(my_data)
#renaming columns for ease
colnames(my_data)[1] <- "company"
colnames(my_data)[2] <- "Productcode"
my_data

#standardizing names in the "company" column
my_data[1] <- gsub(pattern = "phillips|philips|fillips|phillps|phlips|phllips|phillipS", replacement = "Phillips", my_data$company)
my_data[1] <- gsub(pattern = "akzo|AKZo|akz0|ak zo|AKZO", replacement = "Akzo", my_data$company)
my_data[1] <- gsub(pattern = "Van Houten|van houten", replacement = "van Houten", my_data$company)
my_data[1] <- gsub(pattern = "unilver|unilever", replacement = "Unilever", my_data$company)

#arranging data based on company name
my_data <- arrange(my_data, my_data$company)

# Creating 2 new columns from current column "productcode" which contains both product code and product number 
my_data$product_code <- c("v", "v", "p", "q", "q", "x", "x", "p", "p", "p", "x", "x", "x", "p", "v", "v", "x", "q", "q", "q", "x", "v","v", "x", "p") 
my_data$product_number <- c(43, 12, 34, 5, 9, 8, 5, 23, 5, 43, 3, 34, 12, 56, 67, 21, 3, 4, 6, 8, 45, 56, 65, 21, 23)
my_data$Productcode <-NULL

# Below is my attempt at adding a "product category" value based on the value in "product code"
#my_data %>%
# for(j in 1:dim(my_data[2])){
#    if(my_data$product_code[i] == "p"){
#      my_data$product_category[i] <- "Smartphone"
#    } else if(my_data$product_code[i] == "v"){
#      my_data$product_category[i] <- "TV"
#    } else if(my_data$product_code[i] == "x"){
#      my_data$product_category[i] <- "Laptop"
#    } else if(my_data$product_code[i] == "q"){
#      my_data$product_category[i] <- "Tablet"
#    } else {
#      break
#    }
#  }
# Filling the "product_category" column in by hand, is there a faster way to do this?
my_data$product_category <- c("TV", "TV", "Smartphone", "Tablet", "Tablet", "Laptop", "Laptop", "Smartphone", "Smartphone", "Smartphone", "Laptop", "Laptop", "Laptop", "Smartphone",
                          "TV", "TV", "Laptop", "Tablet", "Tablet", "Tablet", "Laptop", "TV","TV", "Laptop", "Smartphone")

#Creating a geocoding column that combines the "address", "city" and "country" columns 
my_data$geocoding <- paste(my_data$address, my_data$city, my_data$country, sep = ",")
my_data

#Creating dummy variables for "company" and "product_category"
my_data <- dummy.data.frame(my_data, names = "company")
my_data <- dummy.data.frame(my_data, names = "product_category")
my_data