#' Checks the content of a linelist object
#'
#' This function evaluates the validity of a `linelist` object by checking the
#' object class, its labels, and the types of the labelled variables. It
#' combines validations checks made by [validate_types()] and
#' [validate_labels()]. See 'Details' section for more information on the
#' checks performed.
#'
#' @details The following checks are performed:
#'
#' * `x` is a `linelist` object
#' * `x` has well-formed labels
#' * all default labels are present (even if `NULL`)
#' * all labelled variables correspond to existing columns
#' * all labelled variables have an acceptable class
#' * (optional) `x` has no extra label beyond the default labels
#'
#' Please note that if you deviate from default variable naming, you will also
#' need to update them while validating the linelist.
#'
#' @export
#'
#' @param x a `linelist` object
#' @param allow_extra a `logical` indicating whether non-default variables are
#' permitted
#'
#' @inheritParams validate_types
#'
#' @inheritParams safeframe::set_labels
#'
#' @return If checks pass, a `linelist` object (invisibly); otherwise issues an
#' error.
#'
#' @seealso
#' * [vars_types()] to change allowed types
#' * [validate_types()] to check if labelled variables have the right classes
#' * [validate_labels()] to perform a series of checks on the labels
#'
#' @examples
#'
#' if (require(outbreaks) && require(magrittr)) {
#'   ## create a valid linelist
#'   x <- measles_hagelloch_1861 %>%
#'     make_linelist()
#'   x
#'
#'   ## rename the id default
#'   x <- make_linelist(
#'     measles_hagelloch_1861,
#'     !!!update_defaults(id = "case_ID")
#'   )
#'
#'   ## validation
#'   validate_linelist(x)
#'
#'   ## create an invalid linelist - onset date is a factor
#'   x <- measles_hagelloch_1861 %>%
#'     make_linelist(!!!update_defaults(gender = "date_of_prodrome"))
#'   x
#'
#'   ## the below issues an error
#'   ## note: tryCatch is only used to avoid a genuine error in the example
#'   tryCatch(validate_linelist(x,
#'     ref_types = vars_types(gender = "date_of_prodrome")
#'   ), error = paste)
#' }
validate_linelist <- function(x,
                              strict = FALSE,
                              allow_extra = TRUE,
                              ref_types = vars_types()) {
  checkmate::assert_class(x, "linelist")
  validate_labels(x, strict, allow_extra)
  validate_types(x, ref_types, strict)

  message("'", checkmate::vname(x), "' is a valid linelist object")

  invisible(x)
}
