## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----message=FALSE, warning=FALSE---------------------------------------------
library(dplyr)
library(tibble)
library(explore)
titanic <- as_tibble(Titanic)

## -----------------------------------------------------------------------------
titanic %>% describe_tbl(n = n)

## ----message=FALSE, warning=FALSE---------------------------------------------
titanic %>% describe()

## ----message=FALSE, warning=FALSE---------------------------------------------
titanic %>% head(10)

## ----message=FALSE, warning=FALSE, fig.height= 2.5, fig.width=4---------------
titanic %>% explore(Class, n = n)

## ----message=FALSE, warning=FALSE---------------------------------------------
titanic %>% describe(Class, n = n)

## ----message=FALSE, warning=FALSE, fig.width=6, fig.height=total_fig_height(titanic, n = Freq)----
titanic %>% explore_all(n = n)

## ----message=FALSE, warning=FALSE, fig.height= 2.5, fig.width=4---------------
titanic %>% explore(Class, target = Survived, n = n, split = FALSE)

## ----message=FALSE, warning=FALSE, fig.height= 2.5, fig.width=4---------------
titanic %>% explore(Class, target = Survived, n = n, split = TRUE)

## ----message=FALSE, warning=FALSE, fig.height= 2.5, fig.width=4---------------
titanic %>% explore(Sex, target = Survived, n = n)

## ----message=FALSE, warning=FALSE, fig.height= 2.5, fig.width=4---------------
titanic %>% explore(Age, target = Survived, n = n)

## -----------------------------------------------------------------------------
titanic %>% explain_tree(target = Survived, n = n)

## ----message=FALSE, warning=FALSE, fig.height= 2.5, fig.width=4---------------
titanic %>% explore(Age, target = Class, n = n)

## ----message=FALSE, warning=FALSE, fig.height= 2.5, fig.width=4---------------
titanic %>% explore(Sex, target = Class, n = n)

