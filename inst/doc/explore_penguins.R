## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----message=FALSE, warning=FALSE---------------------------------------------
library(palmerpenguins)
library(dplyr)
library(explore)

## ----message=FALSE, warning=FALSE---------------------------------------------
penguins %>% describe()

## -----------------------------------------------------------------------------
data <- penguins %>% 
  filter(flipper_length_mm > 0)

## ----message=FALSE, warning=FALSE, fig.width=6, fig.height=total_fig_height(data, size = 2.5)----
data %>% 
  explore_all()

## ----message=FALSE, warning=FALSE, fig.width=6, fig.height=total_fig_height(data, target = species, size = 2.2)----
data %>% 
  explore_all(target = species)

## ----message=FALSE, warning=FALSE, fig.width=6, fig.height=4------------------
data %>% explain_tree(target = species)

## ----message=FALSE, warning=FALSE, fig.width=6, fig.height=3------------------
data %>% explore(flipper_length_mm, bill_length_mm, target = species)

