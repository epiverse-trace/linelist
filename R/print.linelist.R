#' Printing method for linelist objects
#'
#' This function prints linelist objects.
#'
#' @param x a `linelist` object
#'
#' @param ... further arguments to be passed to 'print'
#'
#' @return Invisibly returns the object.
#'
#' @export
#'
#' @author Thibaut Jombart \email{thibaut@@data.org}
#'
#' @examples
#' if (require(outbreaks)) {
#'
#'   ## dataset we'll create a linelist from
#'   measles_hagelloch_1861
#'
#'   ## create linelist
#'   x <- make_linelist(measles_hagelloch_1861,
#'     id = "case_ID",
#'     date_onset = "date_of_prodrome",
#'     age = "age",
#'     gender = "gender"
#'   )
#'
#'   ## print object - using only the first few entries
#'   head(x)
#'
#'   # version with a tibble
#'   if (require(tibble) && require(magrittr)) {
#'     measles_hagelloch_1861 %>%
#'       tibble() %>%
#'       make_linelist(
#'         id = "case_ID",
#'         date_onset = "date_of_prodrome",
#'         age = "age",
#'         gender = "gender"
#'       )
#'   }
#' }
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
