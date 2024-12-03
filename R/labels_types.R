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
labels_types <- function(..., allow_extra = FALSE) {
  defaults <- list(
    id = c("numeric", "integer", "character"),
    date_onset = safeframe::type("date"),
    date_reporting = safeframe::type("date"),
    date_admission = safeframe::type("date"),
    date_discharge = safeframe::type("date"),
    date_outcome = safeframe::type("date"),
    date_death = safeframe::type("date"),
    gender = safeframe::type("category"),
    age = safeframe::type("numeric"),
    location = safeframe::type("category"),
    occupation = safeframe::type("category"),
    hcw = safeframe::type("binary"),
    outcome = safeframe::type("category")
  )
  
  new_values <- rlang::list2(...)
  checkmate::assert_list(new_values, types = "character")

  update_or_append(defaults, new_values)
}
