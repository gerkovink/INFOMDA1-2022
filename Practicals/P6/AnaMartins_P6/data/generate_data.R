# Data generation for the response to treatment dataset
set.seed(45)
n <- 303

cvd_treatment <-
  tibble(
    severity  = as_factor(sample(c("low", "high"), n, replace = TRUE)),
    age       = rnorm(n, 54.2, 10),
    gender    = as_factor(sample(c("m", "f"), n, replace = TRUE)),
    bb_score  = rnbinom(n, 20, 0.8) * rnorm(n, 50)
  ) %>%
  mutate(
    prior_cvd = rpois(n, (severity == "high")*0.2 + .0001 * age^2 + 0.1),
    dose      = factor((severity == "high") - rbinom(n, 1, .2) + 2)
  ) %>% 
  mutate(
    response_linear = 
       -.5 * (severity == "high") +
      -.05 * (age - 55) + 
        .4 * (gender == "f") +
     -.001 * bb_score + 
       -.8 * prior_cvd +
        .6 * (dose == 2) +
        .8 * (dose == 3)
  ) %>% 
  mutate(
    response_prob = 1 / (1 + exp(-response_linear))
  ) %>% 
  mutate(
    response = rbinom(n, 1, response_prob)
  ) %>% 
  select(-response_linear, -response_prob)


write_csv(cvd_treatment[1:253, ], "data/cardiovascular_treatment.csv")
write_csv(cvd_treatment[254:303, ], "data/new_patients.csv")


