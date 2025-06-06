% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/validate_linelist.R
\name{validate_linelist}
\alias{validate_linelist}
\title{Checks the content of a linelist object}
\usage{
validate_linelist(x, allow_extra = FALSE, ref_types = tags_types())
}
\arguments{
\item{x}{a \code{linelist} object}

\item{allow_extra}{a \code{logical} indicating if additional data tags not
currently recognized by \code{linelist} should be allowed; if \code{FALSE}, unknown
tags will trigger an error}

\item{ref_types}{a \code{list} providing allowed types for all tags, as returned
by \code{\link[=tags_types]{tags_types()}}}
}
\value{
If checks pass, a \code{linelist} object (invisibly); otherwise issues an
error.
}
\description{
This function evaluates the validity of a \code{linelist} object by checking the
object class, its tags, and the types of the tagged variables. It combines
validations checks made by \code{\link[=validate_types]{validate_types()}} and \code{\link[=validate_tags]{validate_tags()}}. See
'Details' section for more information on the checks performed.
}
\details{
The following checks are performed:
\itemize{
\item \code{x} is a \code{linelist} object
\item \code{x} has a well-formed \code{tags} attribute
\item all default tags are present (even if \code{NULL})
\item all tagged variables correspond to existing columns
\item all tagged variables have an acceptable class
\item (optional) \code{x} has no extra tag beyond the default tags
}
}
\examples{

if (require(outbreaks)) {

  ## create a valid linelist
  x <- measles_hagelloch_1861 |>
    make_linelist(
      id = "case_ID",
      date_onset = "date_of_prodrome",
      age = "age",
      gender = "gender"
    )
  x

  ## validation
  validate_linelist(x)

  ## create an invalid linelist - onset date is a factor
  x <- measles_hagelloch_1861 |>
    make_linelist(
      id = "case_ID",
      date_onset = "gender",
      age = "age"
    )
  x

  ## the below issues an error
  ## note: tryCatch is only used to avoid a genuine error in the example
  tryCatch(validate_linelist(x), error = paste)
}
}
\seealso{
\itemize{
\item \code{\link[=tags_types]{tags_types()}} to change allowed types
\item \code{\link[=validate_types]{validate_types()}} to check if tagged variables have the right classes
\item \code{\link[=validate_tags]{validate_tags()}} to perform a series of checks on the tags
}
}
