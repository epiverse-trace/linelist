#' Checks the content of a safeframe object
#'
#' This function evaluates the validity of a `safeframe` object by checking the
#' object class, its tags, and the types of variables. It combines
#' validation checks made by [validate_types()] and [validate_tags()]. See
#' 'Details' section for more information on the checks performed.
#'
#' @details The following checks are performed:
#'
#' * `x` is a `safeframe` object
#' * variables in `x` have a well-formed `label` attribute
#' * variables correspond to the specified types
#'
#' @export
#'
#' @inheritParams validate_types
#'
#' @inheritParams set_tags
#'
#' @return If checks pass, a `safeframe` object; otherwise issues an error.
#'
#' @seealso
#' * [validate_types()] to check if variables have the right types
#' * [validate_tags()] to perform a series of checks on the tags
#'
#' @examples
#'
#' ## create a valid safeframe
#' x <- cars |>
#'   make_safeframe(
#'     mph = "speed",
#'     distance = "dist"
#'   )
#' x
#'
#' ## validation
#' validate_safeframe(x,
#'   mph = c("numeric", "factor"),
#'   distance = "numeric"
#' )
#'
#' ## the below issues an error
#' ## note: tryCatch is only used to avoid a genuine error in the example
#' tryCatch(validate_safeframe(x,
#'   mph = c("numeric", "factor"),
#'   distance = "factor"
#' ), error = paste)
validate_safeframe <- function(x,
                               ...) {
  checkmate::assert_class(x, "safeframe")
  validate_tags(x)
  validate_types(x, ...)

  message("'", checkmate::vname(x), "' is a valid safeframe object")

  invisible(x)
}
