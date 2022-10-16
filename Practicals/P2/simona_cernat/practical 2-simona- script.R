# Practical 2
# Simona Cernat

# Load packages ----
library(ISLR)
library(tidyverse)

# Inspect data ----
head(Hitters)
# 1. Name the aesthetics, geoms, scales, and facets of the above visualisation. 
#Also name any statistical transformations or special coordinate systems.

#aes takes the following information : the Hits and Home Run variables from the Hitters dataset
#as geoms: a scater plot for the two variales against each other and contour lines 
#scales: 2 continuous axes
#no facets or stats
#cartesian coordinate system


#Run the code below to generate data. There will be three vectors in your enironment. 
#Put them in a data frame for entering it in a ggplot() call using either the data.frame() 
#or the tibble() function. Give informative names and make sure the types are correct 
#(use the as.<type>() functions). Name the result gg_students

set.seed(1234)
student_grade  <- rnorm(32, 7)
student_number <- round(runif(32) * 2e6 + 5e6)
programme      <- sample(c("Science", "Social Science"), 32, replace = TRUE)

gg_students <- tibble(grades = student_grade, number = student_number, 
                      programme = parse_factor(programme))

head(gg_students)

# 3. Plot the first homeruns_plot again, but map the Hits to the y-axis and the 
#HmRun to the x-axis instead.

ggplot(Hitters, aes(x = HmRun, y = Hits))+
  geom_point() +
  labs(x = "Hits", y = "Home Runs")

# 4. Recreate the same plot once more, but now also map the variable 
#League to the colour aesthetic and the variable Salary to the size aesthetic.

ggplot(Hitters, aes(x = HmRun, y = Hits))+
  geom_point(mapping = aes( color = League, size = Salary)) +
  labs(x = "Hits", y = "Home Runs")


#6. Use geom_histogram() to create a histogram of the grades of the students in the 
#gg_students dataset. Play around with the binwidth argument of the geom_histogram() function.


ggplot(gg_students, mapping = aes(x = grades)) +
  geom_histogram(binwidth =  1)


# 7. Use geom_density() to create a density plot of the grades of the students in the gg_students dataset. 
#Add the argument fill = "light seagreen" to geom_density().


ggplot(gg_students, mapping = aes(x = grades)) +
  geom_density(fill = "light seagreen")

# 8. Add rug marks to the density plot through geom_rug(). You can edit the colour and size of the rug 
#marks using those arguments within the geom_rug() function.

ggplot(gg_students, mapping = aes(x = grades)) +
  geom_density(fill = "light seagreen")+
  geom_rug(size = 2, color = "orange")


#9. Increase the data to ink ratio by removing the y axis label, setting the theme to theme_minimal(), 
#and removing the border of the density polygon. Also set the limits of the x-axis to go from 0 to 10 using 
#the xlim() function, because those are the plausible values for a student grade.


ggplot(gg_students, mapping = aes(x = grades)) +
  geom_density(fill = "light seagreen", color = NA)+
  geom_rug(size = 2, color = "orange") +
  labs(y = " ") +
  xlim(0, 10) +
  theme_minimal()

# 10. Create a boxplot of student grades per programme in the gg_students dataset you made earlier: 
#map the programme variable to the x position and the grade to the y position. 
#For extra visual aid, you can additionally map the programme variable to the fill aesthetic.


ggplot(gg_students, mapping = aes(x = programme, y = grades)) +
  geom_boxplot(mapping = aes(fill = programme))


# 11. What do each of the horizontal lines in the boxplot mean? What do the vertical lines (whiskers) mean?

#The horizontal line marks the median and the whiskers map the first and third quartile.


# 12. Comparison of distributions across categories can also be done by adding a fill aesthetic to the density 
#plot you made earlier. Try this out. To take care of the overlap, you might want to add some transparency in 
#the geom_density() function using the alpha argument.


ggplot(gg_students, mapping = aes(x = grades, fill = programme)) +
  geom_density(color = NA, alpha= 0.5)+
  geom_rug( size = 2, color = "orange") +
  labs(y = " ") +
  xlim(0, 10) +
  theme_minimal()

# 13. Create a bar plot of the variable Years from the Hitters dataset. 

ggplot(Hitters, mapping = aes(x = Years)) +
  geom_bar()

# 14. Use geom_line() to make a line plot out of the first 200 observations of 
#the variable Volume (the number of trades made on each day) of the Smarket dataset. 
#You will need to create a Day variable using mutate() to map to the x-position. 
#This variable can simply be the integers from 1 to 200. Remember, you can select 
#the first 200 rows using Smarket[1:200, ].

head(Smarket)

market_day <- Smarket[1:200, ] %>% mutate(Day = sample(1:200, 200, replace=FALSE))
head(market_day)


market_day %>% 
  ggplot(mapping = aes(x = Day, y = Volume)) +
  geom_line()

# 15. Give the line a nice colour and increase its size. Also add points of the same colour on top.

market_day %>% 
  ggplot(mapping = aes(x = Day, y = Volume)) +
  geom_line(color = "olivedrab", size = 2)


# 16. Use the function which.max() to find out which of the first 200 days has the 
#highest trade volume and use the function max() to find out how large this volume was.


which.max(market_day$Volume)

max(market_day$Volume)

# 17. Use geom_label(aes(x = your_x, y = your_y, label = "Peak volume")) to add a 
#label to this day. You can use either the values or call the functions. Place the label near the peak!


market_day %>% 
  ggplot(mapping = aes(x = Day, y = Volume)) +
  geom_line(color = "olivedrab", size = 2) +
  geom_label(x = 170, y = 2.3, label = "Peak Volume")

#18.Create a data frame called baseball based on the Hitters dataset.
#In this data frame, create a factor variable which splits players’ salary range 
#into 3 categories. Tip: use the filter() function to remove the missing values, 
#and then use the cut() function and assign nice labels to the categories. In addition, 
#create a variable which indicates the proportion of career hits that was a home run.

hitter_salary  <-Hitters %>% 
  filter(!is.na(Salary)) %>% 
  mutate(Type_salary = cut(Salary, 3, labels= c("Low", "Medium", "High")),
         Career_hrun = CHmRun/CHits)

head(hitter_salary)


#19. Create a scatter plot where you map CWalks to the x position and the proportion 
#you calculated in the previous exercise to the y position. 
#Fix the y axis limits to (0, 0.4) and the x axis to (0, 1600) using ylim() and xlim(). 
#Add nice x and y axis titles using the labs() function. Save the plot as the variable baseball_plot.


baseball_plot  <-hitter_salary %>% 
  ggplot(mapping = aes(x = CWalks, y = Career_hrun)) +
  geom_point() +
  ylim(c(0, 0.4)) +
  xlim(c(0, 1600)) +
  xlab("Number of walks in the career") +
  ylab("Proportion of homeruns")
baseball_plot  


#20.Split up this plot into three parts based on the salary range variable you calculated. 
#Use the facet_wrap() function for this; look at the examples in the help file for tips.

baseball_plot +
  facet_wrap(~Type_salary)


#21. Create an interesting data visualisation based on the Carseats data from the ISLR package.


Carseats %>% 
  mutate(age_group = cut(Age, 2, labels = c("young", "old"))) %>% 
  ggplot(mapping = aes(x = Income , y = Sales)) +
  geom_point(aes(color = age_group)) +
  geom_smooth() +
  labs(subtitle = "There seems to be no correlation between the deogrphics and seat car sales")




