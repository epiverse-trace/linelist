#' Default labels recognized by \pkg{linelist}
#'
#' @export
#'
#' @return A character vector with the default labels recognized by 
#' \pkg{linelist}
#'
#' @examples
#' label_defaults()
#'
label_defaults <- function() {
  names(vars_types())
}
