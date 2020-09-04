## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----message=FALSE, warning=FALSE---------------------------------------------
library(dplyr)
library(explore)
titanic <- as.data.frame(Titanic)

## -----------------------------------------------------------------------------
titanic %>% describe_tbl(n = Freq)

## ----message=FALSE, warning=FALSE---------------------------------------------
titanic %>% describe()

## ----message=FALSE, warning=FALSE---------------------------------------------
titanic %>% head(10)

## ----message=FALSE, warning=FALSE, fig.height= 2.5, fig.width=4---------------
titanic %>% explore(Class, n = Freq)

## ----message=FALSE, warning=FALSE---------------------------------------------
titanic %>% describe(Class, n = Freq)

## ----message=FALSE, warning=FALSE, fig.width=6, fig.height=total_fig_height(titanic, n = Freq)----
titanic %>% explore_all(n = Freq)

## ----message=FALSE, warning=FALSE, fig.height= 2.5, fig.width=4---------------
titanic %>% explore(Class, target = Survived, n = Freq, split = FALSE)

## ----message=FALSE, warning=FALSE, fig.height= 2.5, fig.width=4---------------
titanic %>% explore(Class, target = Survived, n = Freq, split = TRUE)

## ----message=FALSE, warning=FALSE, fig.height= 2.5, fig.width=4---------------
titanic %>% explore(Sex, target = Survived, n = Freq)

## ----message=FALSE, warning=FALSE, fig.height= 2.5, fig.width=4---------------
titanic %>% explore(Age, target = Survived, n = Freq)

## -----------------------------------------------------------------------------
titanic %>% explain_tree(target = Survived, n = Freq)

## ----message=FALSE, warning=FALSE, fig.height= 2.5, fig.width=4---------------
titanic %>% explore(Age, target = Class, n = Freq)

## ----message=FALSE, warning=FALSE, fig.height= 2.5, fig.width=4---------------
titanic %>% explore(Sex, target = Class, n = Freq)

