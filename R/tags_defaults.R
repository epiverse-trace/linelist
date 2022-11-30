#' Generate default tags for a linelist
#'
#' This function returns a named list providing the default tags for a
#' `linelist` object (all default to NULL).
#'
#' @export
#'
#' @author Thibaut Jombart \email{thibaut@@data.org}
#'
#' @return A named `list`.
#'
#' @examples
#' tags_defaults()
#'
tags_defaults <- function() {
  list(
    id = NULL,
    date_onset = NULL,
    date_reporting = NULL,
    date_admission = NULL,
    date_discharge = NULL,
    date_outcome = NULL,
    date_death = NULL,
    gender = NULL,
    age = NULL,
    location = NULL,
    occupation = NULL,
    hcw = NULL,
    outcome = NULL
  )
}
