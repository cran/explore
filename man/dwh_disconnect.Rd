% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/dwh.R
\name{dwh_disconnect}
\alias{dwh_disconnect}
\title{disconnect from DWH}
\usage{
dwh_disconnect(connection, ...)
}
\arguments{
\item{connection}{channel (ODBC connection)}

\item{...}{Further arguments to be passed to DBI::dbDisconnect()}
}
\description{
disconnect from datawarehouse (DWH) using a ODBC connection
}
\examples{
\dontrun{
dwh_disconnect(con)
}
}
