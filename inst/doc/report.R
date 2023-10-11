## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----echo=TRUE, message=FALSE, warning=FALSE----------------------------------
library(dplyr)
library(explore)
data <- create_data_churn()

## ----eval=FALSE---------------------------------------------------------------
#  data %>% report(output_dir = tempdir())

## ----fig.height=3, fig.width=6, echo=FALSE, message=FALSE, warning=FALSE------
data %>% explore_tbl()

## ----echo=FALSE, message=FALSE, warning=FALSE---------------------------------
data  %>%  describe_tbl()

## ----echo=FALSE, message=FALSE, warning=FALSE---------------------------------
describe(data)

## ----include=FALSE------------------------------------------------------------
# create buckets of variables
buckets <- data  %>%  
  explore::get_var_buckets(
    bucket_size = 100
  )

# height of each plot
fig_height <- data[buckets[[1]]]  %>%  
  explore::total_fig_height(size = 2)


## ----echo=FALSE, fig.height=fig_height, fig.width=7, message=FALSE, warning=FALSE----
for (i in seq_along(buckets)) {
  data[buckets[[i]]]  %>%  
    explore_all(ncol = 2)
} 

