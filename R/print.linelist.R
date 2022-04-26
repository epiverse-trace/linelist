#' Printing method for linelist objects
#'
#' This function prints linelist objects
#'
#' @param x a `linelist` object
#'
#' @param ... further arguments to be passed to 'print'
#'
#' @return Invisibly returns the object.
#' 
#' @export
#'
#' @author Thibaut Jombart [thibaut@data.org](thibaut@data.org)

print.linelist <- function(x, ...) {
  cat("\n// linelist object\n")
  print(drop_linelist(x, remove_tags = TRUE))
  tags_txt <- paste(names(tags(x)), unlist(tags(x)), sep = ":", collapse = ", ")
  if (tags_txt == "") {
    tags_txt <- "[no tagged variable]"
  }
  cat("\n// tags:", tags_txt, "\n")
  invisible(x)
}