#' Extract a data.frame of all tagged variables
#'
#' This function returns a `data.frame` of all the tagged variables stored in a
#' `linelist`. Note that the output is no longer a `linelist`, but a regular
#' `data.frame`.
#'
#' @param x a `linelist` object
#'
#' @export
#'
#' @author Thibaut Jombart \email{thibaut@@data.org}
#'
#' @return A `data.frame` of tagged variables.
#'
#' @examples
#'
#' if (require(outbreaks) && require(dplyr) && require(magrittr)) {
#'
#'   ## create a tibble linelist
#'   x <- measles_hagelloch_1861 %>%
#'     tibble() %>%
#'     make_linelist(
#'       id = "case_ID",
#'       date_onset = "date_of_prodrome",
#'       age = "age",
#'       gender = "gender"
#'     )
#'   x
#'
#'   ## get a data.frame of all tagged variables
#'   tags_df(x)
#' }
tags_df <- function(x) {
  checkmate::assertClass(x, "linelist")
  tags <- unlist(tags(x))
  out <- drop_linelist(x, remove_tags = TRUE)[tags]
  names(out) <- names(tags)
  out
}
