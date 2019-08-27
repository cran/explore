## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----message=FALSE, warning=FALSE----------------------------------------
library(dplyr)
library(explore)

## ----message=FALSE, warning=FALSE, fig.width=6, fig.height=3-------------
mtcars %>% explore_tbl()

## ----message=FALSE, warning=FALSE----------------------------------------
mtcars %>% describe()

## ----message=FALSE, warning=FALSE, fig.width=6, fig.height=4-------------
mtcars %>% 
  select(mpg, cyl, disp, hp) %>% 
  explore_all()

## ----message=FALSE, warning=FALSE, fig.width=6, fig.height=4-------------
mtcars %>% 
  select(drat, wt, qsec, vs) %>% 
  explore_all()

## ----message=FALSE, warning=FALSE, fig.width=6, fig.height=4-------------
mtcars %>% 
  select(am, gear, carb) %>% 
  explore_all()

## ----message=FALSE, warning=FALSE, fig.width=6, fig.height=4-------------
mtcars %>% 
  explore(gear)

## ----message=FALSE, warning=FALSE, fig.width=6, fig.height=4-------------
mtcars %>% 
  select(gear, mpg, hp, cyl, am) %>% 
  explore_all(target = gear)

## ----message=FALSE, warning=FALSE, fig.width=6, fig.height=3-------------
data <- mtcars %>% 
  mutate(highmpg = if_else(mpg > 25, 1, 0, 0)) %>% 
  select(-mpg)

data %>% explore(highmpg)

## ----message=FALSE, warning=FALSE, fig.width=6, fig.height=4-------------
data %>% 
  select(highmpg, cyl, disp, hp) %>% 
  explore_all(target = highmpg)

## ----message=FALSE, warning=FALSE, fig.width=6, fig.height=4-------------
data %>% 
  select(highmpg, drat, wt, qsec, vs) %>% 
  explore_all(target = highmpg)

## ----message=FALSE, warning=FALSE, fig.width=6, fig.height=4-------------
data %>% 
  select(highmpg, am, gear, carb) %>% 
  explore_all(target = highmpg)

## ----message=FALSE, warning=FALSE, fig.width=6, fig.height=4-------------
data %>% 
  explain_tree(target = highmpg)

## ----message=FALSE, warning=FALSE, fig.width=6, fig.height=4-------------
data %>% explore(wt, target = highmpg)

## ----message=FALSE, warning=FALSE, fig.width=6, fig.height=4-------------
data %>% explore(wt, target = highmpg, split = FALSE)

## ----message=FALSE, warning=FALSE, fig.width=6, fig.height=4-------------
mtcars %>% explore(wt, mpg)

## ----message=FALSE, warning=FALSE, fig.width=6, fig.height=4-------------
mtcars %>% 
  explain_tree(target = hp, minsplit=15)

## ----message=FALSE, warning=FALSE, fig.width=6, fig.height=4-------------
mtcars %>% 
  select(hp, cyl, mpg) %>% 
  explore_all(target = hp)

