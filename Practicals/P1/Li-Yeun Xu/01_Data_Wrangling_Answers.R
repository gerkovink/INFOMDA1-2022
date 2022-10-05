# Answers
# Li-Yeun Xu
# 13-09-2022

# Load packages ----
library(ISLR)
library(tidyverse)
library(haven)
library(readxl)

# Create objects ----
object_1 <- 1:5
object_2 <- 1L:5L
object_3 <- "-123.456"
object_4 <- as.numeric(object_2)
object_5 <- letters[object_1]
object_6 <- as.factor(rep(object_5, 2))
object_7 <- c(1, 2, 3, "4", "5", "6")

# Inspect classes ----
class(object_1)
# Integer
class(object_2)
# Integer
class(object_3)
# Character
class(object_4)
# Numeric
class(object_5)
# Character
class(object_6)
# Factor
class(object_7)
# Character

# Convert object_7 back to a vector of numbers ----
object_7 <- as.numeric(object_7)

# Make a list called objects containing object 1 to 7
objects <- list(object_1, object_2, object_3, object_4, object_5, object_6, object_7)

# Make a data frame out of object_1, object_2, and object_5
dat <- data.frame(Var1 = object_1, Var2 = object_2, Var3 = object_5)
dat

# Useful functions for determining the size of a data frame
ncol(dat)
nrow(dat)

# Import and store the file “data/googleplaystore.csv”
apps <- read_csv("data/googleplaystore.csv")

# Did any column get a variable type you did not expect?
# Not really as it imports the values as they exactly are, 
# in which 'Installs' for example get turned into a character value, due to the '+' sign.

# Use the function head() to look at the first few rows of the apps dataset
# Import and store the file “data/students.xlsx”
students <- read_xlsx("data/students.xlsx")
# It is unexpected that the student_number is a double and not an integer
tail(students)
View(students)

# Create a summary of the three columns in the students dataset
summary(students)
# The lowest grade achieved by the students was a 4.844 and the highest grade was 9.291

# Show the students with a grade lower than 5.5
filter(students, grade < 5.5)

# Show only the students with a grade higher than 8 from programme A
filter(students, grade > 8, programme == 'A')

# Sort the students dataset such that the students from programme A are on top of the data frame 
# And within the programmes the highest grades come first.
arrange(students, programme, desc(grade))

# Show only the student_number and programme columns from the students dataset
select(students, student_number, programme)

# Change the codes in the programme column of the students dataset to their names
students_recoded <- mutate(students, programme = recode(programme, A = "Science", B = "Social Science"))

students_dataset <-
  read_xlsx("data/students.xlsx") %>% 
  mutate(prog = recode(programme, "A" = "Science", "B" = "Social Science")) %>% 
  filter(grade > 5.5) %>% 
  arrange(programme, -grade) %>% 
  select(student_number, prog, grade)
students_dataset

# Create a data processing pipeline for Popular Apps
popular_apps <- 
  read_csv("data/googleplaystore.csv") %>%
  mutate(Downloads = parse_number(Installs)) %>%
  filter(Downloads >= 500000000) %>%
  arrange(desc(Rating)) %>%
  select(Rating, Category, App, Genres, Installs, Type) %>% 
  distinct(.keep_all = TRUE)
popular_apps

# Show the median, minimum, and maximum for the popular apps dataset
popular_apps %>% 
  summarise(
    median = median(Rating),
    minimum = min(Rating),
    maximum = max(Rating)
  )

mad <- function(x) {
  median(abs(x - median(x)))
}
students_dataset %>% summarise(mad = mad(grade))

# Add the median absolute deviation to the summaries
popular_apps %>% 
  summarise(
    median = median(Rating),
    minimum = min(Rating),
    maximum = max(Rating),
    MAD = mad(Rating)
  )

students_dataset %>% 
  group_by(prog) %>% 
  summarise(
    mean = mean(grade), 
    variance = var(grade), 
    min = min(grade), 
    max = max(grade)
  )

# Create a grouped summary of the ratings per category in the popular apps dataset
popular_apps %>% 
  group_by(Category) %>%
  summarise(
    mean = mean(Rating), 
    median = median(Rating),
    minimum = min(Rating),
    maximum = max(Rating),
    MAD = mad(Rating)
  )

#Create an interesting summary based on the Google play store apps dataset

# Do paid apps get higher ratings then free apps?
apps %>% 
  filter(is.nan(Rating) == FALSE) %>% 
  group_by(Type) %>%
  summarise(
    mean = mean(Rating), 
    median = median(Rating),
    minimum = min(Rating),
    maximum = max(Rating),
    MAD = mad(Rating)
  )

  


