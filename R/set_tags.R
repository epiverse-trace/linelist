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
#'     date_of_prodrome = "date_onset"
#'   )
#'   tags(x)
#'
#'   ## add non-default tags using allow_extra
#'   x <- set_tags(x, complications = "severe", allow_extra = TRUE)
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

  args <- rlang::list2(...)
  
  extra <- setdiff(args, tags_names())
  if (!allow_extra && (length(extra) > 0L)) {
    stop(
      "Unknown variable types: ",
      toString(extra),
      "\n  ",
      "Use only tags listed in `tags_names()`, or set `allow_extra = TRUE`",
      call. = FALSE
    )
  }
  
  safeframe::set_labels(x, ...)

}
