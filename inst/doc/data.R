## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----message=FALSE, warning=FALSE---------------------------------------------
library(dplyr)
library(explore)

data <- use_data_penguins()
glimpse(data)

## ----message=FALSE, warning=FALSE---------------------------------------------
data <- use_data_penguins(short_names = TRUE)
glimpse(data)

## ----message=FALSE, warning=FALSE---------------------------------------------
data <- use_data_starwars()
glimpse(data)

## ----message=FALSE, warning=FALSE---------------------------------------------
data <- use_data_diamonds()
glimpse(data)

## ----message=FALSE, warning=FALSE---------------------------------------------
data <- use_data_iris()
glimpse(data)

## ----message=FALSE, warning=FALSE---------------------------------------------
data <- use_data_mpg()
glimpse(data)

## ----message=FALSE, warning=FALSE---------------------------------------------
data <- use_data_mtcars()
glimpse(data)

## ----message=FALSE, warning=FALSE---------------------------------------------
data <- use_data_titanic(count = FALSE)
glimpse(data)

## ----message=FALSE, warning=FALSE---------------------------------------------
data <- use_data_titanic(count = TRUE)
glimpse(data)

## ----message=FALSE, warning=FALSE---------------------------------------------
data <- use_data_beer()
glimpse(data)

## ----message=FALSE, warning=FALSE---------------------------------------------
data <- create_data_abtest()
glimpse(data)

## ----message=FALSE, warning=FALSE---------------------------------------------
data <- create_data_app(obs = 1000)
glimpse(data)

## ----message=FALSE, warning=FALSE---------------------------------------------
data <- create_data_buy(obs = 1000)
glimpse(data)

## ----message=FALSE, warning=FALSE---------------------------------------------
data <- create_data_churn(obs = 1000)
glimpse(data)

## ----message=FALSE, warning=FALSE---------------------------------------------
data <- create_data_esoteric(obs = 1000)
glimpse(data)

## ----message=FALSE, warning=FALSE---------------------------------------------
data <- create_data_newsletter(obs = 1000)
glimpse(data)

## ----message=FALSE, warning=FALSE---------------------------------------------
data <- create_data_person(obs = 1000)
glimpse(data)

## ----message=FALSE, warning=FALSE---------------------------------------------
data <- create_data_random(obs = 1000)
glimpse(data)

## ----message=FALSE, warning=FALSE---------------------------------------------
data <- create_data_unfair(obs = 1000)
glimpse(data)

## ----message=FALSE, warning=FALSE---------------------------------------------
data <- create_data_empty(obs = 1000) %>%
  add_var_random_01("smoking", prob = c(0.8, 0.2)) %>%
  add_var_random_cat("gender", 
                     cat = c("female", "male", "diverse"), 
                     prob = c(0.45, 0.45, 0.1)) %>%
  add_var_random_dbl("internet_usage", min_val = 0, max_val = 1000) %>%
  add_var_random_int("age", min_val = 18, max_val = 100) %>%
  add_var_random_moon() %>%
  add_var_random_starsign()
glimpse(data)

