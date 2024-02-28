## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----message=FALSE, warning=FALSE---------------------------------------------
library(dplyr)
library(explore)

data <- create_data_buy(obs = 1000)
glimpse(data)

## ----message=FALSE, warning=FALSE, fig.width=6, fig.height=4------------------
data %>% explain_tree(target = buy)

## ----message=FALSE, warning=FALSE, fig.width=6, fig.height=4------------------
data %>% explain_tree(target = mobiledata_prd)

## ----message=FALSE, warning=FALSE, fig.width=6, fig.height=4------------------
data %>% explain_tree(target = age)

## ----message=FALSE, warning=FALSE, fig.width=6, fig.height=4------------------
data %>% explain_forest(target = buy, ntree = 100)

## ----message=FALSE, warning=FALSE, fig.width=6, fig.height=4------------------
data %>%
  drop_var_not_numeric() |> 
  explain_xgboost(target = buy)

## ----message=FALSE, warning=FALSE---------------------------------------------
train <- data %>%
  drop_var_not_numeric() |> 
  explain_xgboost(target = buy, out = "all")

## ----message=FALSE, warning=FALSE---------------------------------------------
train$importance

## ----message=FALSE, warning=FALSE---------------------------------------------
train$tune_plot

## ----message=FALSE, warning=FALSE---------------------------------------------
train$tune_data

## ----message=FALSE, warning=FALSE---------------------------------------------
data %>% explain_logreg(target = buy)

## ----message=FALSE, warning=FALSE---------------------------------------------
data <- create_data_buy(obs = 2000, target1_prob = 0.05)
data %>% describe(buy)

## ----message=FALSE, warning=FALSE, fig.width=6, fig.height=4------------------
data %>%
  balance_target(target = buy, min_prop = 0.10) %>%
  explain_tree(target = buy)

