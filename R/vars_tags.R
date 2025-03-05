#' Internal printing function for variables and tags
#'
#' @param vars a `character` vector of variable names
#' @param tags a `character` vector of tags
vars_tags <- function(vars, tags) {
  paste(vars,
    tags,
    sep = " - ",
    collapse = "\n "
  )
}
