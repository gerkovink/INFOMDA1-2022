library(ISLR)
library(MASS)
library(tidyverse)


#1. Create a linear model object called lm_ses using the formula medv ~ lstat and the Boston dataset.

lm_ses <- lm(medv ~ lstat, data = Boston)

#2. Use the function coef() to extract intercept and slope from the lm_ses object.

coef(lm_ses)

#The two coefficients are 34.5 for the intercept and -.95 for the lstat.
#The interpretation is that for an one unit increase in lstat there is a -.095 reduction in medv.


# 3. Use summary() to get a summary of the lm_les object. What do you see? 
summary(lm_ses)


#4. Save the predicted y values to a variable called y_pred

y_pred <- predict(lm_ses)
y_pred

#5. create a scatter plot with y_pred mapped to the x position and the true y value (Boston$medv) 
#mapped to the y value. What do you see? What would this plot look like if the fit 
#were perfect?


Boston %>% 
  ggplot( mapping = aes(x = y_pred, y = medv)) +
  geom_point() +
  geom_abline()

#If the fit were perfect all the dots would have aligned on the line (abline)


# 6. Use the seq() function to generate a sequence of 1000 equally spaced values 
#from 0 to 40. Store this vector in a data frame with (data.frame() or tibble()) as 
#its column name lstat. Name the data frame pred_dat.

pred_dat <- tibble(lstat = seq(0, 40, length.out = 1000))

#7. Use the newly created data frame as the newdata argument to a predict() call 
#for lm_ses. Store it in a variable named y_pred_new.



y_pred_new <- predict(lm_ses, newdata = pred_dat)

# 8. Create a scatter plot from the Boston dataset with lstat mapped to the x position and medv mapped to the y position. 
#Store the plot in an object called p_scatter.


p_scatter = Boston %>% 
  ggplot(aes(x = lstat, y = medv)) +
  geom_point()

p_scatter  




#9. Add the vector y_pred_new to the pred_dat data frame with the name medv

pred_dat <- pred_dat %>% mutate(medv = y_pred_new)


#10. Add a geom_line() to p_scatter, with pred_dat as the data argument. What does this line represent?

p_scatter +
  geom_line(data = pred_dat)


#11. The interval argument can be used to generate confidence or prediction intervals. 
#Create a new object called y_pred_95 using predict() (again with the pred_dat data) with the interval argument set to “confidence”. What is in this object?

y_pred_95 <- predict(lm_ses, newdata = pred_dat, interval = "confidence")


head(y_pred_95)


# 12.reate a data frame with 4 columns: medv, lstat, lower, and upper


df2 <- tibble(
  lstat = pred_dat$lstat,
  medv  = y_pred_95[, 1],
  lower = y_pred_95[, 2],
  upper = y_pred_95[, 3]
)

df2

# 13. Add a geom_ribbon() to the plot with the data frame you just made. The ribbon geom requires three aesthetics: x (lstat, already mapped), ymin (lower), and ymax (upper). Add the ribbon below the geom_line() and the geom_points() of before to make sure those remain visible. Give it a nice colour and clean up the plot, too!

Boston %>% 
  ggplot(aes(x = lstat, y = medv)) + 
  geom_ribbon(aes(ymin = lower, ymax = upper), data = df2, fill = "burlywood1", alpha = 0.5) +
  geom_point(colour = "darkolivegreen") +
  geom_line(data = pred_dat) 
  

# 14. Explain in your own words what the ribbon represents.

#The ribbon represents the 95% confidence interval of the predicted values of medv. It takes into the account the variablity of the estimates.


# 15. Do the same thing, but now with the prediction interval instead of the confidence interval.

y_pred_95 <- predict(lm_ses, newdata = pred_dat, interval = "prediction")

df2 <- tibble(
  lstat = pred_dat$lstat,
  medv  = y_pred_95[, 1],
  lower = y_pred_95[, 2],
  upper = y_pred_95[, 3]
)

df2


Boston %>% 
  ggplot(aes(x = lstat, y = medv)) + 
  geom_ribbon(aes(ymin = lower, ymax = upper), data = df2, fill = "burlywood1", alpha = 0.5) +
  geom_point(colour = "darkolivegreen") +
  geom_line(data = pred_dat) 

#16. Write a function called mse() that takes in two vectors: true y values and predicted y values, and which outputs the mean square error.


mse <- function(y_true, y_pred) {
  mean((y_true - y_pred)^2)
}
 


#17. 

mse(1:10, 10:1)



#19. Calculate the mean square error of the lm_ses model. 
#Use the medv column as y_true and use the predict() method to generate y_pred


y_pred <- predict(lm_ses)
mse(Boston$medv, y_pred )


#19. The Boston dataset has 506 observations. Use c() and rep() to create a 
#vector with 253 times the word “train”, 152 times the word “validation”, 
#and 101 times the word “test”. Call this vector splits.


?rep

splits <- rep(c("train", "validation", "test"), times = c(253, 152, 101))
head(splits)

#Use the function sample() to randomly order this vector and add it to the 
#Boston dataset using mutate(). Assign the newly created dataset to a variable called boston_master.


splits <- sample(splits, size = 506)

boston_master <- Boston %>% mutate( splits = splits)

#21. Now use filter() to create a training, validation, and test set from the boston_master data. 
#Call these datasets boston_train, boston_valid, and boston_test.

boston_train <- boston_master %>% filter(splits == "train")
boston_valid <- boston_master %>% filter(splits == "validation")
boston_test  <- boston_master %>% filter(splits == "test")

# 22. Train a linear regression model called model_1 using the training dataset. 
#Use the formula medv ~ lstat like in the first lm() exercise. 
#Use summary() to check that this object is as you expect.

model_1 <- lm(medv ~ lstat   , data = boston_train)
summary(model_1)


#23. calculate the MSE with this object. Save this value as model_1_mse_train

model_1_mse <- mse(boston_train$medv, predict(model_1))

#24. Now calculate the MSE on the validation set and assign it 
#to variable model_1_mse_valid. Hint: use the newdata argument in predict().

model_1_mse_valid <- mse(boston_valid$medv, predict(model_1, newdata = boston_valid))

# 25. Create a second model model_2 for the train data which includes age and tax as predictors. 
#Calculate the train and validation MSE.

model2 <- lm(medv ~ age + tax, data = boston_train)

model2_train_mse <- mse(boston_train$medv, predict(model2))

model2_validation <- mse(boston_valid$medv, predict(model2, newdata = boston_valid))

#26. Compare model 1 and model 2 in terms of their training and validation MSE. 
#Which would you choose and why?

summary(model2)
summary(model_1)

model_1_mse
model_1_mse_valid
model2_train_mse
model2_validation

#For the first model the mse is a bit larger for the validation data meaning that it probably overfitten the training.
#For the second model the validation and the training are very close therefore the model was less biased. 
#Overall I would chose a model that has minimal mse but here model 2 seems more reliable.

#27. Calculate the test MSE for the model of your choice in the previous question. What does this number tell you?

model2_test_mse <- mse(boston_test$medv, predict(model2, newdata = boston_test))
model2_test_mse

#The mse went down. While this is good it varies a lot from the previous mses.

sqrt(model2_test_mse)





#28. create a function that performs k-fold cross-validation for linear models.

toy = tibble(x = 1:8)
floor(nrow(toy)/3)
rep(c("A", "B", "c", "D"), times = floor(nrow(toy)/4))



k_valid <- function(formula, dataset, k){
#Shuffle the data
  dataset= dataset[sample(1:nrow(dataset)), ]
  #First I will construct a vector for partition of the data and append it to the dataframe
  number_in_slice <- floor(nrow(dataset)/k)
  splits_vector <- rep(c(1:k), times = number_in_slice)
  difference <- nrow(dataset) - length(splits_vector)
  print(difference)
  splits_vector = append(splits_vector, rep(1, difference ))
  
  dataset["partition"]  = splits_vector
  

#I will select the groups to be the test dataset
  vector_mse = c()
  for (i in 1:k)
  {
    test_data <- dataset %>% filter(partition != i)
    
    valid_data <- dataset %>%  filter(partition == i)
    
    #fitting a model on the training set
    model_train <- lm(formula, data = test_data)
    
    #get the mse
    y_column_name <- as.character(formula)[2]
    vector_mse[i] <- mse(valid_data[, y_column_name], predict(model_train, newdata = valid_data ))
  }
  
  mean(vector_mse)

# The End...
}

#29. Use your function to perform 9-fold cross validation with a linear model with as its formula medv ~ lstat + age + tax. 
#Compare it to a model with as formulat medv ~ lstat + I(lstat^2) + age + tax.

k_valid(formula = medv ~ lstat + age + tax, dataset = Boston, k = 9)
