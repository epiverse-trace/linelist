#' Generate default tags for a linelist
#'
#' This function returns a named list providing the default tags for a
#' `linelist` object (all default to NULL).
#'
#' @export
#'
#' @importFrom stats setNames
#'
#' @return A named `list`.
#'
#' @examples
#' label_defaults()
#'
label_defaults <- function() {
  as.list(setNames(
    default_labels(),
    default_vars()
  ))
}
