## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----message=FALSE, warning=FALSE---------------------------------------------
library(dplyr)
library(explore)
data <- create_data_buy(obs = 1000)

## ----message=FALSE, warning=FALSE---------------------------------------------
data %>% describe()

## ----message=FALSE, warning=FALSE, fig.width=5--------------------------------
data %>% explore(age, target = buy)

## ----message=FALSE, warning=FALSE, fig.width=5--------------------------------
data %>% abtest(age > 50, target = buy, sign_level = 0.05)

## ----message=FALSE, warning=FALSE, fig.width=5--------------------------------
data %>% explore(mobilevoice_ind, target = bbi_usg_gb)

## ----message=FALSE, warning=FALSE, fig.width=5--------------------------------
data %>% abtest(mobilevoice_ind == 1, target = bbi_usg_gb, sign_level = 0.05)

## ----message=FALSE, warning=FALSE---------------------------------------------
library(dplyr)
library(explore)
data <- use_data_titanic(count = TRUE)

## ----message=FALSE, warning=FALSE---------------------------------------------
data %>% describe()

## ----message=FALSE, warning=FALSE, fig.width=5--------------------------------
data %>% explore(Sex, target = Survived, n = n)

## ----message=FALSE, warning=FALSE, fig.width=5--------------------------------
data %>% abtest(Sex == "Female", target = Survived, n = n, sign_level = 0.05)

## ----message=FALSE, warning=FALSE, fig.width=5--------------------------------
create_data_abtest(
  n_a = 1000, n_b = 1000,
  success_a = 120, success_b = 210,
  success_unit = "count") %>% 
abtest(sign_level = 0.05)

## ----message=FALSE, warning=FALSE, fig.width=5--------------------------------
create_data_abtest(
  n_a = 1000, n_b = 1000,
  success_a = 12, success_b = 21,
  success_unit = "percent") %>% 
abtest(sign_level = 0.05)

