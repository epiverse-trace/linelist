% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/tags_df.R
\name{tags_df}
\alias{tags_df}
\title{Extract a data.frame of all tagged variables}
\usage{
tags_df(x)
}
\arguments{
\item{x}{a \code{linelist} object}
}
\value{
A \code{data.frame} of tagged variables.
}
\description{
This function returns a \code{data.frame} of all the tagged variables stored in a
\code{linelist}. Note that the output is no longer a \code{linelist}, but a regular
\code{data.frame}.
}
\examples{

if (require(outbreaks)) {

  ## create a linelist
  x <- measles_hagelloch_1861 |>
    make_linelist(
      id = "case_ID",
      date_onset = "date_of_prodrome",
      age = "age",
      gender = "gender"
    )
  x

  ## get a data.frame of all tagged variables
  tags_df(x)
}
}
