#' Modify defaults in a list
#'
#' Internal function. This is used to modify default values provided in a named
#' list.
#'
#' @param defaults a named list of default values
#'
#' @param x a named list of modified values, to replace the defaults
#'
#' @param allow_extra a `logical` indicating if allowed modification should be
#'   restricted to variables existing in the defaults; if `TRUE`, new
#'   variables will be allowed and added to the output
#'
#' @noRd
#'
#' @return A named `list`.

modify_defaults <- function(defaults, x, allow_extra = FALSE) {
  checkmate::assert_list(defaults)
  checkmate::assert_list(x, unique = TRUE)
  # Create a copy of defaults to modify
  result <- defaults

  # 1. Find the values in x that match the values in defaults
  # Currently case sensitive, can improve by making case insensitive
  matching_labels <- intersect(unlist(x), unlist(defaults))

  # 2. Replace the names in defaults, of those matching elements, with the names
  # of the matching elements in x
  for (label in matching_labels) {
    matchDefaults <- defaults == label
    matchX <- x == label
    if (sum(matchDefaults) > 1) stop("Duplicates present for default labels.
                              Please provide unique variables for labels and
                              remove any duplicates.", call. = FALSE)
    names(result)[matchDefaults] <- names(x)[matchX]
  }

  # 3. If allow_extra is FALSE and there are elements in x that are not in
  # defaults, throw an error
  if (!allow_extra) {
    extra_elements <- setdiff(unlist(x), unlist(defaults))
    if (length(extra_elements) > 0) {
      stop(
        "There are labels in x that are not defaults and allow_extra is FALSE",
        call. = FALSE
      )
    }
  }

  # 4. If allow_extra is TRUE and there are elements in x that are not in
  # defaults, add them to the result
  if (allow_extra) {
    extra_elements <- setdiff(x, defaults)
    result <- c(result, extra_elements)
  }
  return(result)
}
