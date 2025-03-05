#' Get the list of tags in a safeframe
#'
#' This function returns the list of tags identifying specific variable types
#' in a `safeframe` object.
#'
#' @param x a `safeframe` object
#'
#' @param show_null DEPRECATED
#'
#' @export
#'
#' @return The function returns a named `list` where names indicate generic
#'   types of data, and values indicate which column they correspond to.
#'
#' @details tags are stored as the `label` attribute of the column variable.
#'
#' @examples
#'
#' ## make a safeframe
#' x <- make_safeframe(cars, mph = "speed")
#'
#' ## check non-null tags
#' tags(x)
#'
#' ## get a list of all tags, including NULL ones
#' tags(x, TRUE)
tags <- function(x, show_null = FALSE) {
  if (show_null) {
    msg <-
      "The 'show_null' argument is deprecated and is no longer functional."
    warning(msg, call. = FALSE)
    show_null <- FALSE
  }

  out <- lapply(names(x), FUN = function(var) {
    tmpLabel <- attr(x[[var]], "label")
    if (!is.null(tmpLabel)) {
      tmpVar <- list(var)
      names(tmpVar) <- tmpLabel
      return(tmpVar)
    } else {
      return(NULL)
    }
  })

  # Flatten the list
  out <- do.call(c, out)
  if (is.null(out)) out <- list()

  out
}
