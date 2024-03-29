% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/select_tags.R
\name{select_tags}
\alias{select_tags}
\title{Extract tagged variables of a linelist object}
\usage{
select_tags(x, ...)
}
\arguments{
\item{x}{a \code{linelist} object}

\item{...}{the tagged variables to select, using \code{\link[dplyr:select]{dplyr::select()}} compatible
terminology; see \code{\link[=tags_names]{tags_names()}} for default values}
}
\value{
A \code{data.frame} of tagged variables.
}
\description{
\ifelse{html}{\href{https://lifecycle.r-lib.org/articles/stages.html#deprecated}{\figure{lifecycle-deprecated.svg}{options: alt='[Deprecated]'}}}{\strong{[Deprecated]}}
This function was  equivalent to running successively \code{\link[=tags_df]{tags_df()}} and
\code{\link[dplyr:select]{dplyr::select()}} on a \code{linelist} object.
To encourage users to understand what is going on and in order to follow the
software engineering good practice of providing just one way to do a given
task, this function is now deprecated.
}
\examples{
if (require(outbreaks)) {

  ## dataset we'll create a linelist from
  measles_hagelloch_1861

  ## create linelist
  x <- make_linelist(measles_hagelloch_1861,
    id = "case_ID",
    date_onset = "date_of_prodrome",
    age = "age",
    gender = "gender"
  )
  head(x)

  ## check tagged variables
  tags(x)

  # DEPRECATED!
  select_tags(x, "gender", "age")

  # Instead, use:
  library(dplyr)
  x \%>\%
    tags_df() \%>\%
    select(gender, age)
}

}
\seealso{
\itemize{
\item \code{\link[=tags]{tags()}} for existing tags in a \code{linelist}
\item \code{\link[=tags_df]{tags_df()}} to get a \code{data.frame} of all tags
}
}
\keyword{deprecated}
