#' Get the list of tag names used in linelist
#'
#' This function returns the a `character` of all tag names used to designate
#' specific variable types in a `linelist`.
#'
#' @export
#'
#' @author Thibaut Jombart \email{thibaut@@data.org}
#'
#' @return The function returns a `character` vector.
#'
#' @seealso [tags_defaults()] for a `list` of default values of the tags
#'
#' @examples
#' tags_names()
#'
tags_names <- function() {
  names(tags_defaults())
}
