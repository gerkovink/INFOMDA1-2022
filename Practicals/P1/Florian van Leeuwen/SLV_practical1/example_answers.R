# Example answers
# Firstname Lastname
# 28-09-2018

# Load packages ----
library(ISLR)
library(tidyverse)
library(haven)

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
# Here is a comment about the class of object_1
# etcetera...