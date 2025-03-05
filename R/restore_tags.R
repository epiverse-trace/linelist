#' Restore tags of a safeframe
#'
#' Internal. This function is used to restore tags of a `safeframe` object
#' which may have lost its tags after handling for example through `dplyr`
#' verbs. Specific actions can be triggered when some of the tagged variables
#' have disappeared from the object.
#'
#' @param x a `data.frame`
#'
#' @param tags a list of tags as returned by [tags()].
#'
#' @param lost_action a `character` indicating the behaviour to adopt when
#'   tagged variables have been lost: "error" (default) will issue an error;
#'   "warning" will issue a warning; "none" will do nothing
#'
#' @noRd
#'
#' @return The function returns a `safeframe` object with restored tags.
#'

restore_tags <- function(x, tags,
                         lost_action = c("error", "warning", "none")) {
  # assertions
  checkmate::assertClass(x, "data.frame")
  checkmate::assertClass(tags, "list")
  lost_action <- match.arg(lost_action)

  # Match the remaining variables to the provided tags
  common_vars <- intersect(names(x), tags)
  if (length(common_vars) == 0 && length(names(x)) > 0) {
    stop("No matching tags provided.")
  }

  # We do not use setdiff because R has become inconsistent for our purposes
  # Since https://github.com/wch/r-source/commit/6dedb304cfd66f0e5775cdd5c0bae6340ac48e84 # nolint: line_length_linter.
  lost_vars <- tags[!unlist(tags) %in% names(x)]
  if (lost_action != "none" && length(lost_vars) > 0) {
    lost_tags <- names(lost_vars)

    lost_msg <- vars_tags(lost_vars, lost_tags)
    msg <- paste(
      "The following tagged variables are lost:\n",
      lost_msg
    )
    if (lost_action == "warning") {
      # nolint next: condition_call_linter.
      warning(warningCondition(msg, class = "safeframe_warning"))
    }
    if (lost_action == "error") {
      # nolint next: condition_call_linter.
      stop(errorCondition(msg, class = "safeframe_error"))
    }
  }
  # Get names that are in tags but not in lost_vars
  remaining_names <- setdiff(names(tags), names(lost_vars))
  # Subset tags with remaining names
  tags <- tags[remaining_names]

  x <- tag_variables(x, tags)

  # Ensure class consistency
  if (!inherits(x, "safeframe")) {
    class(x) <- c("safeframe", class(x))
  }

  x
}
