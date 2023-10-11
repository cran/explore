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
data <- use_data_titanic(count = FALSE)
glimpse(data)

## ----echo=TRUE, message=FALSE, warning=FALSE----------------------------------
data <- data %>% clean_var(Age, name = "age")
glimpse(data)

## ----echo=TRUE, message=FALSE, warning=FALSE----------------------------------
data <- use_data_beer()
data %>% describe(energy_kcal_100ml)

## ----echo=TRUE, message=FALSE, warning=FALSE----------------------------------
data <- data %>% clean_var(energy_kcal_100ml, na = 42)
data %>% describe(energy_kcal_100ml)

## ----echo=TRUE, message=FALSE, warning=FALSE----------------------------------
data <- create_data_person()
data %>% describe(age)

## ----echo=TRUE, message=FALSE, warning=FALSE----------------------------------
data <- data %>% clean_var(age, min_val = 20, max_val = 80)
data %>% describe(age)

## ----echo=TRUE, message=FALSE, warning=FALSE----------------------------------
data %>% describe(income)

## ----echo=TRUE, message=FALSE, warning=FALSE----------------------------------
data <- data %>% clean_var(income, rescale01 = TRUE)
data %>% describe(income)

## ----echo=TRUE, message=FALSE, warning=FALSE----------------------------------
data[1, "handset"] <- " android "
data[2, "handset"] <- "ANDROID"
data %>% describe(handset)

## ----echo=TRUE, message=FALSE, warning=FALSE----------------------------------
data <- data %>% clean_var(handset, simplify_text = TRUE)
data %>% describe(handset)

