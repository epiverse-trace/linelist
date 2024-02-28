#' Tag a variable using its name
#'
#' Internal. This function will tag a pre-defined type of variable in a
#' `data.frame` by adding a named attribute identifying the column name. This is
#' a singular version of the user-facing function `set_tags`.
#'
#' @param x a `data.frame` or a `tibble`, with at least one column
#'
#' @param tag A named list with tag names as list names and names or positions
#' of columns to tag as list values. Values can be `NULL` to remove a tag.
#'
#' @noRd
#'
#' @return The function returns the original object with an additional
#'   attribute.
#'
#' @details If used several times, the previous tag is removed silently.
#'
#' @importFrom utils modifyList

tag_variables <- function(x, tags) {

  tag_errors <- checkmate::makeAssertCollection()

  by_position <- vapply(tags, is.numeric, logical(1))
  if (any(unlist(tags[by_position]) > ncol(x))) {
    stop(
      "Tags specified by position must be lower than the number of columns.",
      call. = FALSE
    )
  }
  tags[by_position] <- names(x)[unlist(tags[by_position])]

  # assert_choice() gives clearer error messages than assert_subset() so we
  # use it in a loop with a assertion collection to ensure all issues are
  # returned in the first run.
  lapply(tags, function(tag) {
    checkmate::assert_choice(tag, names(x), null.ok = TRUE, add = tag_errors)
  })
  checkmate::reportAssertions(tag_errors)

  # We cannot rely on the fact that non-existing attributes are NULL, because
  # modifyList() doesn't work on NULL
  if (is.null(attr(x, "tags"))) {
    attr(x, "tags") <- list()
  }

  attr(x, "tags") <- modifyList(attr(x, "tags"), tags, keep.null = TRUE)

  x
}
