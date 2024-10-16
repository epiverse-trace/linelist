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
#' @return A named `list`.
#'
#' @seealso
#' * [tags_defaults()] for the default tags
#' * [validate_tags()] uses [tags_types()] for validating tags
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
    date_onset = datatagr::type('date'),
    date_reporting = datatagr::type('date'),
    date_admission = datatagr::type('date'),
    date_discharge = datatagr::type('date'),
    date_outcome = datatagr::type('date'),
    date_death = datatagr::type('date'),
    gender = datatagr::type('category'),
    age = datatagr::type('numeric'),
    location = datatagr::type('category'),
    occupation = datatagr::type('category'),
    hcw = datatagr::type('binary'),
    outcome = datatagr::type('category')
  )

  new_values <- rlang::list2(...)
  checkmate::assert_list(new_values, types = "character")

  modify_defaults(defaults = defaults, x = new_values, strict = !allow_extra)
}
