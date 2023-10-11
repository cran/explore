## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----message=FALSE, warning=FALSE---------------------------------------------
library(dplyr)
library(explore)

train <- create_data_buy(obs = 1000, seed = 1)
glimpse(train)

## ----message=FALSE, warning=FALSE, fig.width=6, fig.height=4------------------
train %>% explain_tree(target = buy)

## ----fig.height=4, fig.width=6, message=FALSE, warning=FALSE------------------
model <- train %>% explain_forest(target = buy, out = "model")

## ----message=FALSE, warning=FALSE, fig.width=6, fig.height=4------------------
test <- create_data_buy(obs = 1000, seed = 2)
glimpse(test)

## ----message=FALSE, warning=FALSE, fig.width=6, fig.height=4------------------
test <- test %>% predict_target(model = model)
glimpse(test)

## ----message=FALSE, warning=FALSE, fig.width=6, fig.height=4------------------
test %>% explore(prediction_1, target = buy)

