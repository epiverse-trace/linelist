#' Extract a data.frame of all tagged variables
#'
#' This function returns a `data.frame`, where tagged variables (as stored in
#' the `safeframe` object) are renamed. Note that the output is no longer a
#' `safeframe`, but a regular `data.frame`. untagged variables are unaffected.
#'
#' @param x a `safeframe` object
#'
#' @export
#'
#' @return A `data.frame` of with variables renamed according to their tags
#'
#' @examples
#'
#' x <- make_safeframe(cars,
#'   mph = "speed",
#'   distance = "dist"
#' )
#'
#' ## get a data.frame with variables renamed based on tags
#' tags_df(x)
tags_df <- function(x) {
  checkmate::assertClass(x, "safeframe")

  tags <- tags(x)
  out <- drop_safeframe(x)

  # Find which tagged variables exist in names(out)
  matching_vars <- intersect(unlist(tags), names(out))

  # Create name mapping (old name -> new name)
  name_mapping <- names(tags)[match(matching_vars, tags)]
  names(name_mapping) <- matching_vars

  # Replace matching names
  names(out)[names(out) %in% matching_vars] <- name_mapping[matching_vars]

  out
}
