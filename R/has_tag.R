#' A selector function to use in \pkg{tidyverse} functions
#'
#' @param tags A character vector of tags listing the variables you want to
#'   operate on
#'
#' @returns A numeric vector containing the position of the columns with the
#'   requested tags
#'
#' @export
#'
#' @examples
#' if (require(outbreaks) && require(dplyr)) {
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
#'   head(x)
#'
#'   x |>
#'     select(has_tag(c("id", "age"))) |>
#'     head()
#' }

has_tag <- function(
    tags
) {

  dat <- tidyselect::peek_data(fn = "has_tag")
  dat_tags <- tags(dat)

  cols_to_extract <- dat_tags[names(dat_tags) %in% tags]

  which(colnames(dat) %in% cols_to_extract)

}
