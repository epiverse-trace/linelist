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
#' @return The function returns a named `list` where names indicate column 
#'   names, and values indicate the corresponding tag.
#'
#' @examples
#'
#' if (require(outbreaks)) {
#'   ## make a linelist
#'   x <- make_linelist(measles_hagelloch_1861, date_of_prodrome = "date_onset")
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
  safeframe::labels(x, show_null)
}
