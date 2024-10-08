% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/explore.R
\name{explore_all}
\alias{explore_all}
\title{Explore all variables}
\usage{
explore_all(
  data,
  n,
  target,
  ncol = 2,
  targetpct,
  color = c("#ADD8E6", "#7BB8DA"),
  split = TRUE
)
}
\arguments{
\item{data}{A dataset}

\item{n}{Weights variable (only for count data)}

\item{target}{Target variable (0/1 or FALSE/TRUE)}

\item{ncol}{Layout of plots (number of columns)}

\item{targetpct}{Plot variable as target\% (FALSE/TRUE)}

\item{color}{Forece a default color (if possible)}

\item{split}{Split by target (TRUE|FALSE)}
}
\value{
Plot
}
\description{
Explore all variables of a dataset (create plots)
}
\examples{
explore_all(iris)

iris$is_virginica <- ifelse(iris$Species == "virginica", 1, 0)
explore_all(iris, target = is_virginica)
}
