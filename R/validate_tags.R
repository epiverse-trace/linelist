#' Checks the tags of a safeframe object
#'
#' This function evaluates the validity of the tags of a `safeframe` object by
#' checking that: i) tags are present ii) tags is a `list` of `character` or
#' `NULL` values.
#'
#' @export
#'
#' @param x a `safeframe` object
#'
#' @return If checks pass, a `safeframe` object; otherwise issues an error.
#'
#' @seealso [validate_types()] to check if tagged variables have
#'   the right classes
#'
#' @examples
#' ## create a valid safeframe
#' x <- cars |>
#'   make_safeframe(
#'     mph = "speed",
#'     distance = "dist"
#'   )
#' x
#'
#' ## the below issues an error as safeframe doesn't know any defaults
#' ## note: tryCatch is only used to avoid a genuine error in the example
#' tryCatch(validate_safeframe(x), error = paste)
#'
#' ## validation requires you to specify the types directly
#' validate_safeframe(x,
#'   mph = c("integer", "numeric"),
#'   distance = "numeric"
#' )
validate_tags <- function(x) {
  checkmate::assert_class(x, "safeframe")
  x_tags <- tags(x)

  if (is.null(unlist(x_tags))) stop("`x` has no tags")

  # check that x_tags is a list, and each tag is a `character`
  checkmate::assert_list(x_tags, types = c("character", "null"))

  x
}
