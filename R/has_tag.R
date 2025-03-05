#' A selector function to use in \pkg{tidyverse} functions
#'
#' @param tags A character vector of tags you want to operate on
#'
#' @returns A numeric vector containing the position of the columns with the
#'   requested tags
#'
#' @export
#'
#' @examples
#' ## create safeframe
#' x <- make_safeframe(cars,
#'   mph = "speed",
#'   distance = "dist"
#' )
#' head(x)
#'
#' if (require(dplyr) && require(magrittr)) {
#'   x %>%
#'     select(has_tag(c("mph", "distance"))) %>%
#'     head()
#' }
has_tag <- function(tags) {
  dat <- tidyselect::peek_data(fn = "has_tag")
  dat_tags <- tags(dat)

  cols_to_extract <- dat_tags[names(dat_tags) %in% tags]

  which(colnames(dat) %in% cols_to_extract)
}
