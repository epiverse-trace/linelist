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
#' `c(vars_types, y_loc = type("numeric"))`.
#'
#' @param strict a `logical` indicating whether all defaults must be present
#'   (`TRUE`) or not (`FALSE`)
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
#'   ## create an invalid linelist - gender is a numeric
#'   x <- measles_hagelloch_1861 %>%
#'     make_linelist(
#'       !!!update_defaults(id = "case_ID", date_onset = "date_of_prodrome")
#'     )
#'   x
#'
#'   ## the below would issue an error, because not all defaults are present
#'   ## note: tryCatch is only used to avoid a genuine error in the example
#'   tryCatch(validate_types(x, strict = TRUE), error = paste)
#'
#'   ## to validate other variables types
#'   validate_types(x, c(vars_types(), y_loc = type("numeric")))
#' }
validate_types <- function(x, ref_types = vars_types(), strict = FALSE) {
  checkmate::assert_class(x, "linelist")

  if (strict && !all(names(x) %in% names(ref_types))) {
    stop(
      "Variable ",
      toString(paste0("`", setdiff(names(x), names(ref_types)), "`")),
      " are not available in `x`.",
      call. = FALSE
    )
  }

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
