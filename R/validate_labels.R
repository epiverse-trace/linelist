#' Checks the labels of a linelist object
#'
#' This function evaluates the validity of the labels of a `linelist` object by
#' checking that: i) labels are present ii) labels are characters only iii)
#' that all default labels are present (if `strict = TRUE`) iv) that no extra
#' tag exists (if `allow_extra` is `FALSE`).
#'
#' @export
#'
#' @param x a `linelist` object
#'
#' @param strict a `logical` indicating whether checks should be strict
#' @param allow_extra a `logical` indicating whether non-default labels are
#' allowed
#'
#' @return If checks pass, a `linelist` object; otherwise issues an error.
#'
#' @seealso [validate_types()] to check if tagged variables have
#'   the right classes
#'
#' @examples
#' if (require(outbreaks) && require(magrittr)) {
#'   ## create a valid linelist using only defaults
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
#'   ## validation is as permissive as the defaults in `make_linelist`
#'   validate_labels(x)
#'   ## Making it more strict
#'   tryCatch(validate_labels(x, strict = TRUE, allow_extra = FALSE),
#'     error = paste
#'   )
#' }
validate_labels <- function(
    x,
    strict = FALSE,
    allow_extra = TRUE) {
  checkmate::assert_class(x, "safeframe")
  x_labels <- labels(x)

  stopifnot(
    "`x` has no labels" = !(is.list(x_labels) &&
      length(x_labels) == 0 && !is.null(names(x_labels)))
  )

  # check that x is a list, and each tag is a `character`
  checkmate::assert_list(x_labels, types = c("character", "null"))
  default_labels <- default_labels()

  # check that all defaults are present
  if (strict) {
    missing_labels <- default_labels[!default_labels %in% x_labels]
    if (length(missing_labels) > 0) {
      stop(
        "The following default labels are missing:\n",
        toString(missing_labels),
        call. = FALSE
      )
    }
  }

  # check there is no extra value
  if (!allow_extra) {
    is_extra <- !unlist(x_labels) %in% default_labels
    if (any(is_extra)) {
      extra_tags <- x_labels[is_extra]
      stop(
        "The following labels are not part of the defaults:\n",
        toString(extra_tags),
        "\nConsider using `allow_extra = TRUE` to allow additional labels.",
        call. = FALSE
      )
    }
  }

  x
}
