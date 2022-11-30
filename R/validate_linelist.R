#' Checks the content of a linelist object
#'
#' This function evaluates the validity of a `linelist` object by checking the
#' object class, its tags, and the types of the tagged variables. It combines
#' validations checks made by [validate_types()] and [validate_tags()]. See
#' 'Details' section for more information on the checks performed.
#'
#' @details The following checks are performed:
#'
#' * `x` is a `linelist` object
#' * `x` has a well-formed `tags` attribute
#' * all default tags are present (even if `NULL`)
#' * all tagged variables correspond to existing columns
#' * all tagged variables have an acceptable class
#' * (optional) `x` has no extra tag beyond the default tags
#'
#' @export
#'
#' @param x a `linelist` object
#'
#' @inheritParams validate_types
#'
#' @inheritParams set_tags
#'
#' @author Thibaut Jombart \email{thibaut@@data.org}
#'
#' @return If checks pass, a `linelist` object; otherwise issues an error.
#'
#' @seealso
#' * [tags_types()] to change allowed types
#' * [validate_types()] to check if tagged variables have the right classes
#' * [validate_tags()] to perform a series of checks on the tags
#'
#' @examples
#'
#' if (require(outbreaks) && require(dplyr) && require(magrittr)) {
#'
#'   ## create a valid linelist
#'   x <- measles_hagelloch_1861 %>%
#'     tibble() %>%
#'     make_linelist(
#'       id = "case_ID",
#'       date_onset = "date_of_prodrome",
#'       age = "age",
#'       gender = "gender"
#'     )
#'   x
#'
#'   ## validation
#'   validate_linelist(x)
#'
#'   ## create an invalid linelist - onset date is a factor
#'   x <- measles_hagelloch_1861 %>%
#'     tibble() %>%
#'     make_linelist(
#'       id = "case_ID",
#'       date_onset = "gender",
#'       age = "age"
#'     )
#'   x
#'
#'   ## the below issues an error
#'   ## note: tryCatch is only used to avoid a genuine error in the example
#'   tryCatch(validate_linelist(x), error = paste)
#' }
validate_linelist <- function(x,
                              allow_extra = FALSE,
                              ref_types = tags_types()) {
  checkmate::assert_class(x, "linelist")
  validate_tags(x, allow_extra)
  validate_types(x, ref_types)

  x
}
