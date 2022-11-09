# Practical 1
# Martin Okanik, SLV 09/2022

library(tidyverse)
library(readxl)

# 1.)
object_1 <- 1:5
class(object_1) # integer

object_2 <- 1L:5L
class(object_2) # integer

object_3 <- "-123.456"
class(object_3) # character

object_4 <- as.numeric(object_2)
class(object_4) # numeric

object_5 <- letters[object_1]
class(object_5) # character

object_6 <- as.factor(rep(object_5, 2))
class(object_6) # factor 

object_7 <- c(1, 2, 3, "4", "5", "6")
class(object_7) # character



# 2.)
object_7 <- as.numeric(object_7)

# 3.)
objects <- list(object_1, object_2, object_3, object_4, object_5, object_6, 
                object_7)

# 4.)
dat <- data.frame(Var1 = object_1, Var2 = object_2, Var3 = object_5)
dat

# 5.)
ncol(dat)
nrow(dat)

# 6.)
apps <- read_csv("data/googleplaystore.csv")
apps

# 7.)
# (i) Size is <chr> because it is expressed in "M"
# its dimensions would ideally be included in the name, e.g. "Size [M]"
# (ii) Type should perhaps be a factor
# (iii) Price should definitely be numeric
# (iv) Content too
# (v) Generes should be a factor, just like (ii)
# (vi) Last Updated should use some suitable date-time format

# 8.)
head(apps)

# 9.)
students <- read_xlsx("data/students.xlsx")
head(students)
tail(students)
# student_number should be integer
# programme could be a factor


# 10.)
summary(students)

# 11.)
filter(students, grade < 5.5)

# 12.)
filter(students, grade > 8, programme == "A")

# 13.)
arrange(students, programme, -grade)

# 14.)
select(students, student_number, programme)
students <- mutate(students, pass = grade > 5.5)
students

# 15.)
students_recoded <- students %>%
  mutate(programme = programme %>% recode("A" = "Science", "B" = "Social Science"))

# 16.)
popular_apps <-
  read_csv("data/googleplaystore.csv") %>% 
  mutate(Downloads = parse_number(Installs)) %>% 
  filter(Downloads > 5e8) %>%
  arrange(-Rating) %>% 
  select(App, Rating, Downloads, Category) %>% 
  distinct(App, .keep_all = TRUE)

popular_apps

# 17.)
popular_apps %>% 
  summarise(
    med = median(Rating),
    min = min(Rating), 
    max = max(Rating)
  )

# 18.)
popular_apps %>% 
  summarise(
    med = median(Rating),
    min = min(Rating), 
    max = max(Rating),
    mad = mad(Rating)
  )

# 19.) 
popular_apps %>%
  group_by(Category) %>% 
  summarise(
    med = median(Rating),
    min = min(Rating), 
    max = max(Rating),
    mad = mad(Rating)
  )

# 20.)
# which category has the highest and lowest spread (sd) of rankings?
# what is the entire ranking?

# loading, selecting relevant data, and some preliminary exploration
app_data <- read_csv("data/googleplaystore.csv") %>%
  select(App, Rating, Category) %>%
  na.omit()
str(app_data)
summary(app_data)


# calculating sd of Rating per Category
sd_by_cat <- app_data %>% 
  group_by(Category) %>% 
  summarise(mean = mean(Rating), sd = sd(Rating), n = n()) %>%
  arrange(sd)
sd_by_cat

# CONCLUSION:

# according to this dataset, people tend to have:
#   
#   (i) the most differing opinions about health, bussiness and dating apps
# 
#  (ii) the least differing opinions about education, weather and entertainment apps
# 
# This is in line with the expectation that more important life decisions, 
# which also trigger increased emotions (dating, health etc.) provoke a wider range of reactions, 
# which might also carry over to the relevant apps. Remarkably, weather apps were also spared 
# from people's bad mood, the dataset was probably not collected in Netherlands or the UK...
# 
# The mean scores of various categories are different, but the spread of standard deviations
# is significantly larger than the spread in mean scores. The mean scores for categories with 
# lower deviation seem to be on average very slightly larger compared to those with higher deviation.
# I cut my analysis before going to any significance tests...

