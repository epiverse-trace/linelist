#' Remove the safeframe class from an object
#'
#' Internal function. Used for dispatching to other methods when `NextMethod` is
#' an issue (typically to pass additional arguments to the `safeframe` method).
#'
#' @param x a `safeframe` object
#'
#' @param remove_tags a `logical` indicating if tags should be removed from
#' the attributes; defaults to `TRUE`
#'
#' @noRd
#'
#' @return The function returns the object without the `safeframe` class.
#'
drop_safeframe <- function(x, remove_tags = TRUE) {
  classes <- class(x)
  class(x) <- setdiff(classes, "safeframe")
  if (remove_tags) {
    # Set the label attribute to NULL for all variables in x
    for (var in names(x)) {
      x <- remove_tag(x, var)
    }
  }
  x
}
