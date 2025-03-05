#' Internal. Remove "label" attribute from a specific variable in a data frame
#'
#' @noRd
#'
remove_tag <- function(x, var) {
  attr(x[[var]], "label") <- NULL
  x
}
