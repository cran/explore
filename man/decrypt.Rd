% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/tools.R
\name{decrypt}
\alias{decrypt}
\title{decrypt text}
\usage{
decrypt(text, codeletters = c(toupper(letters), letters, 0:9), shift = 18)
}
\arguments{
\item{text}{A text (character)}

\item{codeletters}{A string of letters that are used for decryption}

\item{shift}{Number of elements shifted}
}
\value{
Decrypted text
}
\description{
decrypt text
}
\examples{
decrypt("zw336 E693v")
}
