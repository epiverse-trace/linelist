#' Tag a variable using its name
#'
#' Internal. This function will tag a pre-defined type of variable in a
#' `data.frame` by adding a named attribute identifying the column name. This is
#' a singular version of the user-facing function `set_tags`.
#'
#' @param x a `data.frame` or a `tibble`, with at least one column
#'
#' @param var_type a `character` indicating the generic data to be tagged
#'
#' @param var_name a `character` or an `integer` indicating the columns of the
#'   dataset corresponding to this type of data
#'
#' @noRd
#'
#' @author Thibaut Jombart \email{thibaut@@data.org}
#'
#' @return The function returns the original object with an additional
#'   attribute.
#'
#' @details If used several times, the previous tag is removed silently.
#'

tag_variable <- function(x, var_type, var_name) {

  # Approach: 'tagging' a variable means that an item named after `var_type` is
  # added to the list `tags` stored as an attribute of the object. Its value,
  # `var_name`, either refers to a column of the data.frame, or is NULL.

  # assert inputs
  if (missing(var_name)) {
    var_name <- NULL
  }
  checkmate::assertDataFrame(x, min.cols = 1)
  checkmate::assertCharacter(var_type, len = 1L)
  if (is.numeric(var_name)) {
    checkmate::assertNumber(var_name, lower = 1L, upper = ncol(x))
    var_name <- names(x)[var_name]
  }
  checkmate::assertChoice(var_name, choices = names(x), null.ok = TRUE)

  # create tags attribute if needed; this is a named list used to store the
  # variable name corresponding to known variable types
  if (is.null(attr(x, "tags"))) {
    attr(x, "tags") <- list()
  }

  # extract the tags list, add new values, re-add to the object note that we
  # need to ensure that tags set to NULL are kept in the list, so we want to
  # avoid things like tags[[]] <- NULL which would remove the item altogether
  tags <- attr(x, "tags")
  tags[var_type] <- list(var_name)
  attr(x, "tags") <- tags

  x
}
