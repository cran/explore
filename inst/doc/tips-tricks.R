## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----echo=TRUE, message=FALSE, warning=FALSE----------------------------------
library(dplyr)
library(explore)

## ----echo=TRUE, message=FALSE, warning=FALSE----------------------------------
data <- use_data_penguins()
data %>% count(island)

## ----echo=TRUE, message=FALSE, warning=FALSE----------------------------------
data %>% count_pct(island)

## ----echo=TRUE, message=FALSE, warning=FALSE----------------------------------
data %>% glimpse()

## ----echo=TRUE, message=FALSE, warning=FALSE----------------------------------
data %>% add_var_id() %>% glimpse()

## ----echo=TRUE, message=FALSE, warning=FALSE----------------------------------
create_notebook_explore(
  output_dir = tempdir(),
  output_file = "notebook-explore.Rmd")

## ----eval=FALSE, echo=TRUE----------------------------------------------------
#  iris  %>%  data_dict_md(output_dir = tempdir())

## ----eval=FALSE, echo=TRUE----------------------------------------------------
#  description <- data.frame(
#                    variable = c("Species"),
#                    description = c("Species of Iris flower"))
#  data_dict_md(iris,
#               title = "iris flower data set",
#               description =  description,
#               output_file = "data_dict_iris.md",
#               output_dir = tempdir())

## ----echo=TRUE, message=FALSE, warning=FALSE----------------------------------
colors <- mix_color("blue", n = 5)
colors

## ----echo=TRUE, message=FALSE, warning=FALSE----------------------------------
show_color(colors)

## ----echo=TRUE, message=FALSE, warning=FALSE----------------------------------
colors <- mix_color("gold", "red", n = 4)
colors

## ----echo=TRUE, message=FALSE, warning=FALSE----------------------------------
show_color(colors)

