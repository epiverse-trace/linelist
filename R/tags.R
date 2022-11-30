#' Get the list of tags in a linelist
#'
#' This function returns the list of tags identifying specific variable types in
#' a `linelist`.
#'
#' @param x a `linelist` object
#'
#' @param show_null a `logical` indicating if the complete list of tags,
#'   including `NULL` ones, should be returned; if `FALSE`, only tags with a
#'   non-NULL value are returned; defaults to `FALSE`
#'
#' @export
#'
#' @author Thibaut Jombart \email{thibaut@@data.org}
#'
#' @return The function returns a named `list` where names indicate generic
#'   types of data, and values indicate which column they correspond to.
#'
#' @details Tags are stored as the `tags` attribute of the object.
#'
#' @examples
#'
#' if (require(outbreaks)) {
#'   ## make a linelist
#'   x <- make_linelist(measles_hagelloch_1861, date_onset = "date_of_prodrome")
#'
#'   ## check non-null tags
#'   tags(x)
#'
#'   ## get a list of all tags, including NULL ones
#'   tags(x, TRUE)
#' }
#'
tags <- function(x, show_null = FALSE) {
  checkmate::assertClass(x, "linelist")
  out <- attr(x, "tags")
  if (!show_null) {
    to_remove <- vapply(out, is.null, logical(1))
    out <- out[!to_remove]
  }
  out
}
