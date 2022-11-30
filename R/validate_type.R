#' Check a tagged variable has the right type
#'
#' Internal. This function checks that a specific tagged variable has the
#' expected type of data. Default expected types are defined by
#' [tags_types()]. Note that this is a low-level function. Consider using the
#' plural version `validate_types` which operates the validation on all tagged
#' variables of a `linelist` object.
#'
#' @noRd
#'
#' @param x a variable, typically a column of a `data.frame`
#'
#' @param tag the name of the tag the variable corresponds to, typically one of
#'   the values of `tags_names()`
#'
#' @param ref_types a `list` providing allowed types for all tags
#'
#' @author Thibaut Jombart \email{thibaut@@data.org}
#'
#' @return `TRUE` if the test is successful; otherwise, a `character` indicating
#'   the issue
#'
#' @seealso
#'
#' * [tags_types()] to check or change acceptable data
#'   classes for specific tags
#' * [validate_types()] to apply validation to a `linelist`
#'

validate_type <- function(x, tag, ref_types = tags_types()) {
  checkmate::assertAtomicVector(x)
  if (!tag %in% names(ref_types)) {
    msg <- sprintf(
      "Allowed types for tag `%s` are not documented in `ref_types`",
      tag
    )
    stop(msg)
  }

  allowed_types <- ref_types[[tag]]
  checkmate::check_multi_class(x, allowed_types, null.ok = TRUE)
}
