# Example answers
# Willem van Veluw
# 28-09-2018

# Load packages ----
library(ISLR)
library(tidyverse)
library(haven)
library(readxl)

### Exercise 1 ---------------------------------
# Load objects
object_1 <- 1:5
object_2 <- 1L:5L
object_3 <- "-123.456"
object_4 <- as.numeric(object_2)
object_5 <- letters[object_1]
object_6 <- as.factor(rep(object_5, 2))
object_7 <- c(1, 2, 3, "4", "5", "6")

# Inspect classes ----
class(object_1)
# The data type of object_1 is "integer".

class(object_2)
# The data type of object_2 is "integer".

class(object_3)
# The data type of object_3 is "character".

class(object_4)
# The data type of object_4 is "numeric".

class(object_5)
# The data type of object_5 is "character".

class(object_6)
# The data type of object_6 is "factor".

class(object_7)
# The data type of object_7 is "character".


### Exercise 2 ---------------------------------
object_7 <- as.numeric(object_7)
class(object_7)
# The data type of object_7 is now transformed to "numeric".


### Exercise 3 ---------------------------------
objects <- list(object_1,object_2,object_3,object_4,object_5,object_6,object_7)
# A list can have different data types and each element does not have equal length.
# Also, giving the elements a name is optional.


### Exercise 4 ---------------------------------
objects_df <- data.frame(object_1, object_2, object_5)
# In a data frame each element must have the same length and has to have a name.


### Exercise 5 ---------------------------------
ncol(objects_df)
# The number of columns of the data frame is 3.

nrow(objects_df)
# The number of rows of the data frame is 5.


### Exercise 6 ---------------------------------
apps <- read_csv("googleplaystore.csv")


### Exercise 7 ---------------------------------
class(apps$Price)
# Yes, there are some types that I did not expect. For example, the type of data
# in column "Price" is "Character", while I expected it to be a double or integer.


### Exercise 8 ---------------------------------
head(apps)


### Exercise 9 ---------------------------------
students <- read_xlsx("students.xlsx")
head(students)
# The data frame consists of three columns with data types double, double and
# character respectively. 
# Maybe the first column, showing the student number, could have been of a 
# different type since we do not see these values as real numbers. We see them 
# more as a "label" for a student, so probably a character data type would be 
# more appropriate here.


### Exercise 10 --------------------------------
summary(students)
# The grades of the students are within the range 4.844 to 9.291.


### Exercise 11 ---------------------------------
filter(students, students$grade < 5.5)
# There are 3 students with a grade of lower than 5.5.


### Exercise 12 ---------------------------------
filter(students, students$grade > 8, students$programme == "A")
# There are 5 students with a grade larger than 8 for programme A.


### Exercise 13 ---------------------------------
arrange(students, students$programme, -students$grade )
# Sorting in anscending fashion is default. Use desc() or - to sort in descending
# order. Also note that arrange() sorts the first argument prior to the 
# second argument.


### Exercise 14 ---------------------------------
select(students, student_number, programme)
# First the data frame to select from and then the names of the columns.


### Exercise 15 ---------------------------------
students <- mutate(students, pass = grade > 5.5)
students_recoded <- mutate(students, programme = recode(programme, A = "Science", B = "Social Science"))
# We have add a new column with data to the data frame called "pass". We have
# also transformed the programme from code to actual terms. 


### Exercise 16 ---------------------------------
popular_apps <-
  read_csv("googleplaystore.csv") %>%
  mutate(Downloads = parse_number(Installs)) %>%
  filter(Downloads > 500000000) %>%
  arrange(-Rating) %>%
  select(Category, Rating, Reviews, Downloads, Size)
# Relevant columns are Category, Rating, Reviews, Downloads and Size.


### Exercise 17 ---------------------------------
popular_apps %>% 
  summarise(
    mean = mean(Rating),
    variance = var(Rating),
    min = min(Rating),
    max = max(Rating)
  )


### Exercise 18 ---------------------------------
mad <- function(x){
  median(abs(x - median(x)))
}

popular_apps %>% 
  summarise(
    mean = mean(Rating),
    variance = var(Rating),
    min = min(Rating),
    max = max(Rating),
    mad = mad(Rating)
  )


### Exercise 19 ---------------------------------
popular_apps %>% 
  group_by(Category) %>% 
  summarise(
    mean = mean(Rating),
    variance = var(Rating),
    min = min(Rating),
    max = max(Rating),
    mad = mad(Rating)
  )
# There are some categories with only one record. In the computation
# of variance, we divide by n-1, which equals zero for n = 1. Hence the
# NA's in the column of variance.


### Exercise 20 ---------------------------------
# Among the decent apps (with rating > 3.5), which category costs the most?
interesting_apps <-
  read_csv("googleplaystore.csv") %>% 
  filter(Rating >= 3.5) %>% 
  mutate(Price = parse_number(Price)) %>%
  select(Category, Rating, Price)

interesting_apps %>% 
  group_by(Category) %>% 
  summarise(
    mean = mean(Price),
    variance = var(Price),
    min = min(Price),
    max = max(Price)
  ) %>% 
  arrange(-mean) %>% View()

# We see that finance apps cost the most, with a mean of 8.39 EUR. Most
# categories do not cost that much: the mean price is below 1 EUR. 
# There are 5 categories that cost nothing: their mean equals zero.
# The question is however if the data is reliable: there is a very large
# variance among the finance, lifestyle and family apps. We may need more
# data from these categories to lower the sample variance.