#' Remove the linelist class from an object
#'
#' Internal function. Used for dispatching to other methods when `NextMethod` is
#' an issue (typically to pass additional arguments to the `linelist` method).
#'
#' @param x a `linelist` object
#'
#' @param remove_tags a `logical` indicating if tags should be removed from the
#'   attributes; defaults to `TRUE`
#'
#' @noRd
#'
#' @return The function returns the same object without the `linelist` class.
#'
#'

drop_linelist <- function(x, remove_tags = TRUE) {
  x <- safeframe::drop_safeframe(x, remove_tags = remove_tags)
  class(x) <- setdiff(class(x), "linelist")

  x
}
