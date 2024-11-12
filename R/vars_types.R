#' Generate acceptable variable types for labels
#'
#' This function returns a named list providing the acceptable data types for
#' the default labels. If no argument is provided, it returns default
#' values. Otherwise, provided values will be used to define the defaults.
#'
#' @export
#'
#' @inheritParams default_vars
#'
#' @return A named `list` of variable names and type values.
#'
#' @seealso
#' * [label_defaults()] for the default tags
#' * [validate_labels()] uses [vars_types()] for validating tags
#' * [validate_linelist()] uses [vars_types()] for validating tags
#'
#' @examples
#' # list default values
#' vars_types()
#'
#' # rename default variable
#' vars_types(id = "case_ID")
#'
vars_types <- function(...) {
  res <- setNames(default_types(), default_vars(...))

  res
}
