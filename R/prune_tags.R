#' Prune tags after changing columns of a linelist
#'
#' Internal. This function is used to remove tags whose variable has been
#' removed after subsetting the columns of a `linelist` object. By default, a
#' warning will be issued if some tagged variables have been removed.
#'
#' @param x `linelist` object
#'
#' @param lost_action a `character` indicating the behaviour to adopt when tagged
#'   variables have been lost: "error" (default) will issue an error; "warning"
#'   will issue a warning; "none" will do nothing
#'
#' @noRd
#'
#' @author Thibaut Jombart \email{thibaut@@data.org}
#'
#' @return The function returns a `linelist` object.
#'

prune_tags <- function(x, lost_action = c("error", "warning", "none")) {
  # assertions
  checkmate::assertClass(x, "linelist")
  lost_action <- match.arg(lost_action)

  # do stuff
  old_tags <- tags(x, show_null = TRUE)

  has_lost_column <- vapply(
    old_tags,
    function(e) !is.null(e) && !e %in% names(x),
    logical(1)
  )
  new_tags <- old_tags[!has_lost_column]
  new_tags <- modify_defaults(tags_defaults(), new_tags)
  out <- x
  attr(out, "tags") <- new_tags

  if (lost_action != "none" && any(has_lost_column)) {
    lost_tags <- unlist(old_tags[has_lost_column])
    lost_tags_txt <- paste(names(lost_tags),
      lost_tags,
      sep = ":",
      collapse = ", "
    )
    msg <- paste(
      "The following tags have lost their variable:\n",
      lost_tags_txt
    )
    if (lost_action == "warning") warning(msg)
    if (lost_action == "error") stop(msg)
  }

  out
}
