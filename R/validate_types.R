#' Type check variables
#'
#' This function checks the class of variables in a `linelist` against
#' pre-defined accepted classes in [vars_types()] and further specifications.
#'
#' @export
#'
#' @param x a `linelist` object
#'
#' @param ref_types a named `list` providing variable names and their allowed
#' types. Defaults to output from by [vars_types()], which can be used to update
#' naming of default variables, for example `vars_types(id = "case_ID")`. Extra
#' variables can be concatenated, for example
#' `c(vars_types(), y_loc = type("numeric"))`.
#'
#' @return A named `list`.
#'
#' @seealso
#' * [type()] for classes of types
#' * [vars_types()] to change allowed types
#' * [validate_labels()] to perform a series of checks on the tags
#' * [validate_linelist()] to combine `validate_labels` and `validate_types`
#'
#' @examples
#' if (require(outbreaks) && require(magrittr)) {
#'   x <- make_linelist(
#'     measles_hagelloch_1861,
#'     !!!update_defaults(id = "case_ID")
#'   )
#'   validate_types(x, ref_types = c(vars_types(), y_loc = type("numeric")))
#'
#'   ## create an invalid linelist - onset date is a factor
#'   x <- measles_hagelloch_1861 %>%
#'     make_linelist(!!!update_defaults(gender = "date_of_prodrome"))
#'   x
#'
#'   ## the below issues an error
#'   ## note: tryCatch is only used to avoid a genuine error in the example
#'   tryCatch(validate_types(x,
#'     ref_types = vars_types(gender = "date_of_prodrome")
#'   ), error = paste)
#' }
validate_types <- function(x, ref_types = vars_types()) {
  checkmate::assert_class(x, "linelist")

  check_df <- suppressWarnings(x[, names(x) %in% names(ref_types)])
  type_checks <- lapply(
    names(check_df),
    function(type) {
      allowed_types <- ref_types[[type]]
      checkmate::check_multi_class(
        check_df[[type]],
        allowed_types,
        null.ok = TRUE
    )
    }
  )
  has_correct_types <- vapply(type_checks, isTRUE, logical(1))

  if (!all(has_correct_types)) {
    stop(
      "Some variables have the wrong class:\n",
      sprintf(
        "  - %s: %s\n",
        names(check_df)[!has_correct_types],
        type_checks[!has_correct_types]
      ),
      call. = FALSE
    )
  }

  x
}
