#' Printing method for safeframe objects
#'
#' This function prints safeframe objects.
#'
#' @param x a `safeframe` object
#'
#' @param ... further arguments to be passed to 'print'
#'
#' @return Invisibly returns the object.
#'
#' @export
#'
#' @examples
#' ## create safeframe
#' x <- make_safeframe(cars,
#'   mph = "speed",
#'   distance = "dist"
#' )
#'
#' ## print object - using only the first few entries
#' head(x)
#'
#' # version with a tibble
#' if (require(tibble) && require(magrittr)) {
#'   cars %>%
#'     tibble() %>%
#'     make_safeframe(
#'       mph = "speed",
#'       distance = "dist"
#'     )
#' }
print.safeframe <- function(x, ...) {
  cat("\n// safeframe object\n")
  print(drop_safeframe(x))

  # Extract names and values from tags(x)
  tag_values <- unlist(tags(x))
  tag_names <- names(tag_values)

  # Construct the tags_txt string from the filtered pairs
  tags_txt <- vars_tags(tag_names, tag_values)

  if (tags_txt == "") {
    cat("\n[no tagged variables]\n")
  } else {
    cat("\ntagged variables:\n", tags_txt, "\n")
  }

  invisible(x)
}
