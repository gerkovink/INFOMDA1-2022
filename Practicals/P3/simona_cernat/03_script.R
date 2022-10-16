#Practical 3 
#Simona Cernat

library(tidyverse)
library(magrittr)
library(mice)
library(DAAG)


?mice::boys

#Loading the dataset into a variable
boys <- mice::boys


#1. 1. Create a histogram of the variable age using the function geom_histogram().

boys %>% 
  ggplot(aes(x = age)) +
  geom_histogram()

  
# 2. Create a bar chart of the variable gen using the function geom_bar().
boys %>% 
  ggplot(aes(x = gen)) +
  geom_bar()
  
  
md.pattern(boys)
  
  
#3. Create a missingness indicator for the variables gen, phb and tv.

boys_mis <- boys %>%
  mutate(gen_mis = is.na(gen),
         phb_mis = is.na(phb),
         tv_mis  = is.na(tv))

#4. Assess whether missingness in the variables gen, phb and tv is related to someones age.

boys %>% 
  group_by(age) %>% 
  summarise(missing = sum(is.na(gen))) %>% 
  ggplot(aes(x = age, y = missing)) +
  geom_point()
  

boys_mis %>% 
  mutate(age_interval = floor(age)) %>% 
  group_by(age_interval) %>% 
  summarise(missing = sum(gen_mis)) %>% 
  arrange(desc(missing))

boys_mis %>% 
  mutate(age_interval = floor(age)) %>% 
  group_by(age_interval) %>% 
  summarise(missing = sum(phb_mis)) %>% 
  arrange(desc(missing))


boys_mis %>% 
  mutate(age_interval = floor(age)) %>% 
  group_by(age_interval) %>% 
  summarise(missing = sum(tv_mis)) %>% 
  arrange(desc(missing))




#More data is missing when the boys are below 1 year old.  


#5. Create a histogram for the variable age, faceted by whether or not someone has a missing value on gen.
  
boys_mis %>% 
  ggplot(aes(x = age)) +
  geom_histogram() +
  facet_wrap(~gen_mis)


#6. Create a scatterplot with age on the x-axis and bmi on the y-axis, using the function geom_point().


boys %>% 
  ggplot(mapping = aes(x = age, y = bmi)) +
  geom_point(aes(color = gen))

# 8.  Visualize the relationship between reg (region) and age using a boxplot.

boys %>% 
  ggplot(mapping = aes(x = reg, y = age)) +
  geom_boxplot(aes(color = reg)) +
  theme_minimal()


#9. Create a density plot of age, splitting the densities by gen using the fill aesthetic.
 
boys %>% 
  ggplot(mapping = aes(x = age)) +
  geom_density(aes(fill = gen), alpha = 0.5) +
  labs(title = "Density of age by gen")


#10.  Create a diverging bar chart for hgt in the boys data set, that displays 
#for every age year that year’s meaFn height in deviations from the overall average hgt.


(overall_mean_hgt = mean(boys$hgt, na.rm = TRUE))
boys %>% 
  mutate(age_year = floor(age)) %>% 
  group_by(age_year) %>% 
  summarise(mean_height_zscore = abs((overall_mean_hgt - mean(hgt, na.rm = TRUE))/overall_mean_hgt)) %>% 
  ggplot(aes(x = age_year, y = mean_height_zscore)) +
  geom_col(fill = "mediumturquoise") +
  labs(title = "Deviations from the average height in relation with age") 



  
#11. Load the data elastic1 and elastic2 and bind the data frames together using the function bind_rows() 
#and add a grouping variable indicating whether an observation comes from elastic1 or from elastic2.

library("DAAG")
?bind_rows
  
elastic <- bind_rows("Elastic1" = elastic1,
                     "Elastic2" = elastic2,
                     .id = "Set")


#12.Create a scatterplot mapping stretch on the x-axis and distance on the y-axis, 
#and map the just created group indicator as the color aesthetic.



ggplot(elastic, aes(x = stretch , y = distance)) +
geom_point(aes(color = Set))




#13. Recreate the previous plot, but now assess whether the results of the two data sets 
#appear consistent by adding a linear regression line.


ggplot(elastic, aes(x = stretch , y = distance)) +
  geom_point(aes(color = Set)) +
  geom_smooth(method = "lm", aes(color = Set)) +
  theme_minimal()

#It indeed seems consistent



#14. For each of the data sets elastic1 and elastic2, fit a regression model 
#with y = distance on x = stretch using lm(y ~ x, data).


lm_elastic1 <- lm(distance ~ stretch, elastic1)
lm_elastic2 <- lm(distance ~ stretch, elastic2)

# 15. For both of the previously created fitted models, determine the fitted values and the standard errors of the fitted values, 
#and the proportion explained variance R2.

?predict

predict(lm_elastic1, se.fit = TRUE)
predict(lm_elastic2, se.fit = TRUE)

summary(lm_elastic1)
summary(lm_elastic2)

#16. Study the residual versus leverage plots for both models.
lm_elastic1 %>% plot(which = 5)
lm_elastic2 %>% plot(which = 5)

#17.  Use the elastic2 variable stretch to obtain predictions on the model fitted on elastic1.
pred <- predict(lm_elastic1, newdata = elastic2)
pred


#18. ow make a scatterplot to investigate similarity between the predicted values and the observed values for elastic2.



table <-bind_cols(Predicted = pred, Observed = elastic2$distance)

table %>% 
  ggplot(mapping = aes(x = Predicted, y = Observed)) +
  geom_point() +
  geom_abline()

cor(elastic2$distance, pred)

#Residuals can be seen from this plot because of the predicted and observed were equal they would all fall on the line.

