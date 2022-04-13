#' Get the list of tags in a linelist
#'
#' This function returns the list of tags identifying specific variable types in
#' a `linelist`. 
#'
#' @param x a `linelist` object
#'
#' @export
#'
#' @author Thibaut Jombart [thibaut@data.org](thibaut@data.org)
#'
#' @return The function returns a named `list` where names indicate generic
#'   types of data, and values indicate which column they correspond to.
#'
#' @details Tags are stored as the `tags` attribute of the object.
#'
#' @examples
#' # basic use of the function
#' if (require(outbreaks)) {
#' measles_hagelloch_1861
#' x <- make_linelist(measles_hagelloch_1861, date_onset = "date_of_prodrome")
#' tags(x)
#' }
#' 

tags <- function(x) {
  checkmate::assertClass(x, "linelist")
  attr(x, "tags")
}