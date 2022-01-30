## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----message=FALSE, warning=FALSE---------------------------------------------
library(dplyr)
library(explore)

## ----eval=FALSE, echo=TRUE----------------------------------------------------
#  explore(iris)

## ----eval=FALSE, echo=TRUE----------------------------------------------------
#  # report of all variables
#  iris %>% report(output_file = "report.html", output_dir = tempdir())

## ----eval=FALSE, echo=TRUE----------------------------------------------------
#  # report of all variables and their relationship with a binary target
#  iris$is_versicolor <- ifelse(iris$Species == "versicolor", 1, 0)
#  iris %>%
#    report(output_file = "report.html",
#           output_dir = tempdir(),
#           target = is_versicolor)
#  

## ----message=FALSE, warning=FALSE, fig.width=6, fig.height=4------------------
iris %>% explain_tree(target = Species)

## ----message=FALSE, warning=FALSE, fig.width=6, fig.height=4------------------
iris$is_versicolor <- ifelse(iris$Species == "versicolor", 1, 0)
iris %>% select(-Species) %>% explain_tree(target = is_versicolor)

## ----message=FALSE, warning=FALSE, fig.width=6, fig.height=4------------------
iris %>% explain_tree(target = Sepal.Length)

## ----message=FALSE, warning=FALSE, fig.width=6, fig.height=3------------------
iris %>% explore_tbl()

## ----message=FALSE, warning=FALSE---------------------------------------------
iris %>% describe_tbl()

## ----message=FALSE, warning=FALSE, fig.width=6, fig.height=3------------------
iris %>% explore(Species)

## ----message=FALSE, warning=FALSE, fig.width=6, fig.height=3------------------
iris %>% explore(Sepal.Length)

## ----message=FALSE, warning=FALSE, fig.width=6, fig.height=3------------------
iris %>% explore(Sepal.Length, target = is_versicolor)

## ----message=FALSE, warning=FALSE, fig.width=6, fig.height=3------------------
iris %>% explore(Sepal.Length, target = is_versicolor, split = FALSE)

## ----message=FALSE, warning=FALSE, fig.width=6, fig.height=3------------------
iris %>% explore(Sepal.Length, target = Species)

## ----message=FALSE, warning=FALSE, fig.width=6, fig.height=3------------------
iris %>% explore(Sepal.Length, target = Petal.Length)

## ----message=FALSE, warning=FALSE, fig.width=6, fig.height=2.5----------------
iris %>% 
  select(Sepal.Length, Sepal.Width) %>% 
  explore_all()

## ----message=FALSE, warning=FALSE, fig.width=6, fig.height=2.5----------------
iris %>% 
  select(Sepal.Length, Sepal.Width, is_versicolor) %>% 
  explore_all(target = is_versicolor)

## ----message=FALSE, warning=FALSE, fig.width=6, fig.height=2.5----------------
iris %>% 
  select(Sepal.Length, Sepal.Width, is_versicolor) %>% 
  explore_all(target = is_versicolor, split = FALSE)

## ----message=FALSE, warning=FALSE, fig.width=6, fig.height=2.5----------------
iris %>% 
  select(Sepal.Length, Sepal.Width, Species) %>% 
  explore_all(target = Species)

## ----message=FALSE, warning=FALSE, fig.width=6, fig.height=2.5----------------
iris %>% 
  select(Sepal.Length, Sepal.Width, Petal.Length) %>% 
  explore_all(target = Petal.Length)

## ----message=FALSE, warning=FALSE---------------------------------------------
data(iris)

## ----message=FALSE, warning=FALSE, fig.width=7, fig.height=total_fig_height(iris, size=2.5)----
iris %>% 
  explore_all()

## ----message=FALSE, warning=FALSE, fig.width=7, fig.height=total_fig_height(iris, var_name_target = "Species", size=2.5)----
iris %>% explore_all(target = Species)

## ----message=FALSE, warning=FALSE, fig.width=6, fig.height=3------------------
iris %>% explore(Sepal.Length, Petal.Length)

## ----message=FALSE, warning=FALSE, fig.width=6, fig.height=3------------------
iris %>% explore(Sepal.Length, Petal.Length, target = Species)

## ----message=FALSE, warning=FALSE, fig.width=6, fig.height=3------------------
iris %>% explore(Sepal.Length, min_val = 4.5, max_val = 7)

## ----message=FALSE, warning=FALSE, fig.width=6, fig.height=3------------------
iris %>% explore(Sepal.Length, auto_scale = FALSE)

## ----message=FALSE, warning=FALSE, fig.width=6, fig.height=3------------------
iris %>% describe()

## ----message=FALSE, warning=FALSE, fig.width=6, fig.height=3------------------
# show all variables that contain less than 5 unique values
iris %>% describe() %>% filter(unique < 5)

## ----message=FALSE, warning=FALSE, fig.width=6, fig.height=3------------------
# show all variables contain NA values
iris %>% describe() %>% filter(na > 0)

## ----message=FALSE, warning=FALSE, fig.width=6, fig.height=3------------------
# describe a numerical variable
iris %>% describe(Species)

## ----message=FALSE, warning=FALSE, fig.width=6, fig.height=3------------------
# describe a categorical variable
iris %>% describe(Sepal.Length)

## ----eval=FALSE, echo=TRUE----------------------------------------------------
#  iris %>% data_dict_md(output_dir = tempdir())

## ----eval=FALSE, echo=TRUE----------------------------------------------------
#  description <- data.frame(
#                    variable = c("Species"),
#                    description = c("Species of Iris flower"))
#  data_dict_md(iris,
#               title = "iris flower data set",
#               description =  description,
#               output_file = "data_dict_iris.md",
#               output_dir = tempdir())

## ----message=FALSE, warning=FALSE, fig.width=6, fig.height=3------------------
iris %>% 
  clean_var(Sepal.Length, 
            min_val = 4.5, 
            max_val = 7.0, 
            na = 5.8, 
            name = "sepal_length") %>% 
  describe()

