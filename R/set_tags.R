#' Change tags of a safeframe object
#'
#' This function changes the `tags` of a `safeframe` object, using the same
#' syntax as the constructor [make_safeframe()].
#'
#' @param x a `data.frame` or a `tibble`, equivalent to parameter `.data` in
#'   [make_safeframe()]
#' @inheritParams make_safeframe
#'
#' @seealso [make_safeframe()] to create a `safeframe` object
#'
#' @export
#'
#' @return The function returns a `safeframe` object.
#'
#' @examples
#'
#' ## create a safeframe
#' x <- make_safeframe(cars, mph = "speed")
#' tags(x)
#'
#' ## add new tags and fix an existing one
#' x <- set_tags(x, distance = "dist")
#' tags(x)
#'
#' ## remove tags by setting them to NULL
#' old_tags <- tags(x)
#' x <- set_tags(x, mph = NULL, distance = NULL)
#' tags(x)
#'
#' ## setting tags providing a list (used to restore old tags here)
#' x <- set_tags(x, !!!old_tags)
#' tags(x)
set_tags <- function(x, ...) {
  # assert inputs
  checkmate::assertClass(x, "safeframe")

  orig_class <- class(x)

  # For some reason, we cannot remove tags from safeframe objects by setting
  # the attr to NULL.
  # We circumvent the issue by:
  # 1. saving the existing tags
  # 2. dropping all tags & removing the safeframe class
  # 3. readding the tags and the safeframe class

  new_tags <- rlang::list2(...)
  old_tags <- tags(x)
  x <- drop_safeframe(x)

  x <- tag_variables(
    x,
    utils::modifyList(old_tags, new_tags, keep.null = TRUE)
  )

  class(x) <- orig_class

  x
}
