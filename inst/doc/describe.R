## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----message=FALSE, warning=FALSE---------------------------------------------
library(dplyr)
library(explore)

data <- create_data_buy(obs = 100)
glimpse(data)

## ----message=FALSE, warning=FALSE, fig.width=6, fig.height=4------------------
data %>% describe_tbl()

## ----message=FALSE, warning=FALSE, fig.width=6, fig.height=4------------------
data %>% describe_all()

## ----message=FALSE, warning=FALSE, fig.width=6, fig.height=4------------------
data %>% 
  describe_all() %>%
  filter(unique == 1)

## ----message=FALSE, warning=FALSE, fig.width=6, fig.height=4------------------
data %>% describe(age)

## ----message=FALSE, warning=FALSE, fig.width=6, fig.height=4------------------
data %>% describe(buy)

