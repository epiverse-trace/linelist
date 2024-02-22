#' Changes tags of a linelist object
#'
#' This function changes the `tags` of a `linelist` object, using the same
#' syntax as the constructor [make_linelist()]. If some of the default tags are
#' missing, they will be added to the final object.
#'
#' @inheritParams make_linelist
#'
#' @seealso [make_linelist()] to create a `linelist` object
#'
#' @export
#'
#' @return The function returns a `linelist` object.
#'
#' @examples
#'
#' if (require(outbreaks)) {
#'   ## create a linelist
#'   x <- make_linelist(measles_hagelloch_1861, date_onset = "date_of_rash")
#'   tags(x)
#'
#'   ## add new tags and fix an existing one
#'   x <- set_tags(x,
#'     age = "age",
#'     gender = "gender",
#'     date_onset = "date_of_prodrome"
#'   )
#'   tags(x)
#'
#'   ## add non-default tags using allow_extra
#'   x <- set_tags(x, severe = "complications", allow_extra = TRUE)
#'   tags(x)
#'
#'   ## remove tags by setting them to NULL
#'   old_tags <- tags(x)
#'   x <- set_tags(x, age = NULL, gender = NULL)
#'   tags(x)
#'
#'   ## setting tags providing a list (used to restore old tags here)
#'   x <- set_tags(x, !!!old_tags)
#'   tags(x)
#' }
#'
set_tags <- function(x, ..., allow_extra = FALSE) {

  # assert inputs
  checkmate::assertClass(x, "linelist")
  checkmate::assertLogical(allow_extra)

  old_tags <- attr(x, "tags")
  defaults <- tags_defaults()
  new_tags <- rlang::list2(...)

  if (length(new_tags) && is.list(new_tags[[1]])) {
    warning(
      "The use of a list of tags is deprecated. ",
      "Please use the splice operator (!!!) instead. ",
      "More information is available in the examples and in the ",
      "?rlang::`dyn-dots` documentation."
    )
    new_tags <- new_tags[[1]]
  }

  final_tags <- modify_defaults(defaults, old_tags, strict = FALSE)
  final_tags <- modify_defaults(old_tags, new_tags, strict = !allow_extra)

  tag_variables(x, final_tags)

}
