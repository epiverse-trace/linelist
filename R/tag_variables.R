#' Tag a variable using its name
#'
#' Internal. This function will tag pre-defined variables in a
#' `data.frame` by adding a label attribute to the column. This can be used for
#' one or multiple variables at the same time.
#'
#' @param x a `data.frame` or a `tibble`, with at least one column
#'
#' @param tags A named list with tag names as list names and names or positions
#' of columns to tag as list values. Values can be `NULL` to remove a tag.
#'
#' @return The function returns the original object with an additional `"label"`
#'   attribute on each provided variable.
#'
#' @details If used several times, the previous tag is removed silently.
#'  Only accepts known variables from the provided `data.frame`.
#'
#' @noRd

tag_variables <- function(x, tags) {
  # Create an assertion collection to fill with assertions and potential errors
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

  # Split tags into NULL and non-NULL cases
  nullIndex <- vapply(tags, is.null, FUN.VALUE = logical(1))
  if (any(nullIndex)) {
    null_tags <- names(tags)[nullIndex]
  } else {
    null_tags <- NULL
  }
  non_null_tags <- names(tags)[!nullIndex]

  # Handle NULL cases (tag removals)
  if (length(null_tags) > 0) {
    remove_vars <- unlist(tags(x)[null_tags])
    x <- Reduce(remove_tag, remove_vars, init = x)
  }

  # Handle non-NULL cases (setting labels)
  if (length(non_null_tags) > 0) {
    for (tag in non_null_tags) {
      attr(x[[tags[[tag]]]], "label") <- tag
    }
  }
  x
}
