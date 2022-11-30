#' List acceptable variable types for tags
#'
#' This function returns a named list providing the acceptable data types for
#' the default tags. If no argument is provided, it returns default
#' values. Otherwise, provided values will be used to define the defaults.
#'
#' @export
#'
#' @inheritParams make_linelist
#'
#' @author Thibaut Jombart \email{thibaut@@data.org}
#'
#' @return A named `list`.
#'
#' @seealso
#' * [tags_defaults()] for the default tags
#' * [validate_types()] uses [tags_types()] for validating tags
#' * [validate_linelist()] uses [tags_types()] for validating tags
#'
#' @examples
#' # list default values
#' tags_types()
#'
#' # change existing values
#' tags_types(date_onset = "Date") # impose a Date class
#'
#' # add new types e.g. to allow genetic sequences using ape's format
#' tags_types(sequence = "DNAbin", allow_extra = TRUE)
#'
tags_types <- function(..., allow_extra = FALSE) {
  defaults <- list(
    id = c("numeric", "integer", "character"),
    date_onset = date_types,
    date_reporting = date_types,
    date_admission = date_types,
    date_discharge = date_types,
    date_outcome = date_types,
    date_death = date_types,
    gender = category_types,
    age = numeric_types,
    location = category_types,
    occupation = category_types,
    hcw = binary_types,
    outcome = category_types
  )

  new_values <- list(...)
  if (length(new_values)) {
    lapply(new_values, checkmate::assertCharacter, min.len = 1)
  }

  modify_defaults(defaults = defaults, x = new_values, strict = !allow_extra)
}


#' @noRd
date_types <- c("integer", "numeric", "Date", "POSIXct", "POSIXlt")

#' @noRd
category_types <- c("character", "factor")

#' @noRd
numeric_types <- c("numeric", "integer")

#' @noRd
binary_types <- c("logical", "integer", "character", "factor")
