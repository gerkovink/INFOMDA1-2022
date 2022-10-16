# Answers
# Simona Cernat
# 15-09-2022

# Load packages ----
library(ISLR)
library(tidyverse)
library(haven)

# Run the following code in R and inspect their data types using the class() function

object_1 <- 1:5
object_2 <- 1L:5L
object_3 <- "-123.456"
object_4 <- as.numeric(object_2)
object_5 <- letters[object_1]
object_6 <- as.factor(rep(object_5, 2))
object_7 <- c(1, 2, 3, "4", "5", "6")

#object 1 and 2 - integers; object 3- string, 4- numeric, 5 - chraracter, 6 - factor, 7 - vector with many types of objects

#2. Convert object_7 back to a vector of numbers using the as.numeric() function

object_7 = as.numeric(object_7)

#3. Make a list called objects containing object 1 to 7 using the list() function.
 objects = list(object_1, object_2, object_3, object_4, object_5, object_6, object_7)
 
# 4. Make a data frame out of object_1, object_2, and object_5 using the data.frame() function

 df = data.frame(object_1, object_2, Var3 = object_5)
 df

 # 5. Useful functions for determining the size of a data frame are ncol() and nrow(). Try them out!
  
 ncol(df)
 nrow(df)

 # 6. Use the function read_csv() to import the file “data/googleplaystore.csv” and store it in a variable called apps.
 
 setwd("./SLV_practical1")
 getwd()
 
 apps <- read_csv("./data/googleplaystore.csv")
head(apps) 

#Some columns have the wrong data types such as Size, Price which should be integers and  Last update (should be date) 
 
students <- read_excel("./data/students.xlsx")
tail(students)
view(students)

#10. Create a summary of the three columns in the students dataset using the summary() function. What is the range of the grades achieved by the students?

summary(students)

#The range can be noticed by looking at the min which is 4.8 to max. grade which is 9.29.

# 11. Look at the help pages for filter() (especially the examples) and show the students with a grade lower than 5.5

filter(students, grade < 5.5)

# 12.Show only the students with a grade higher than 8 from programme A

students %>% filter(grade > 8, programme == "A") %>% select(student_number)

# 13. Sort the students dataset such that the students from programme A are on top of the data frame and within the programmes the highest grades come first.

arrange(students, programme, -grade)


# Show only the student_number and programme columns from the students dataset

select(students, student_number, programme)


#Use mutate() and recode() to change the codes in the programme column of the students dataset to their names. Store the result in a variable called students_recoded

students_recoded <- mutate(students, 
                           programme = recode(programme, 
                                              "A" = "Science", "B" = "Social Science")
)

students_recoded


#Create a data processing pipeline that (a) loads the apps dataset, 
#(b) parses the number of installs as ‘Downloads’ variable using mutate and parse_number(), 
#(c) shows only apps with more than 500 000 000 downloads, 
#(d) orders them by rating (best on top), and 
#(e) shows only the relevant columns (you can choose which are relevant, but select at least the Rating and Category variables). 
#Save the result under the name popular_apps.

popular_apps <- read_csv("./data/googleplaystore.csv") %>%
  mutate(Downloads = parse_number(Installs)) %>%
  filter(Downloads > 500000000) %>%
  arrange(-Rating ) %>%
  select(App, Rating, Category, Installs)

popular_apps
            
#17. Show the median, minimum, and maximum for the popular apps dataset you made in the previous assignment.

popular_apps %>% 
  summarise(
    med = median(Rating),
    min = min(Rating), 
    max = max(Rating)
  )

#18.Add the median absolute deviation to the summaries you made before


mad <- function(x) {
  median(abs(x - median(x)))
}

popular_apps %>% 
  summarise(
    med = median(Rating),
    min = min(Rating), 
    max = max(Rating),
    mad = mad(Rating)
  )

#19. Create a grouped summary of the ratings per category in the popular apps dataset.

popular_apps %>% 
  group_by(Category) %>%
  summarise(
    med = median(Rating),
    mad = mad(Rating),
    min= min(Rating),
    max = max(Rating)
  )

#20. Create an interesting summary based on the Google play store apps dataset. 
#An example could be “do games get higher ratings than communication apps?”
popular_apps %>% 
  filter(Category == "SOCIAL"| Category == "FAMILY" ) %>%
  group_by(Category) %>%
  summarise(
    average = mean(Rating),
   
  )

