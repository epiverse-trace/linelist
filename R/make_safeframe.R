#' Create a safeframe from a data.frame
#'
#' This function converts a `data.frame` or a `tibble` into a `safeframe`
#' object, where data are tagged and validated. The output will seem to be the
#' same `data.frame`, but `safeframe`-aware packages will then be able to
#' automatically use tagged fields for further data cleaning and analysis.
#'
#' @param .data a `data.frame` or a `tibble`
#'
#' @param ... <[`dynamic-dots`][rlang::dyn-dots]> A series of tags provided as
#'   `tag_name = "column_name"`
#'
#' @seealso
#'
#' * An overview of the [safeframe] package
#' * [tags()]: for a list of tagged variables in a `safeframe`
#' * [set_tags()]: for modifying tags
#' * [tags_df()]: for selecting variables by tags
#'
#' @export
#'
#' @return The function returns a `safeframe` object.
#'
#' @examples
#'
#' x <- make_safeframe(cars,
#'   mph = "speed",
#'   distance = "dist"
#' )
#'
#' ## print result - just first few entries
#' head(x)
#'
#' ## check tags
#' tags(x)
#'
#' ## tags can also be passed as a list with the splice operator (!!!)
#' my_tags <- list(
#'   mph = "speed",
#'   distance = "dist"
#' )
#' new_x <- make_safeframe(cars, !!!my_tags)
#'
#' ## The output is strictly equivalent to the previous one
#' identical(x, new_x)
#'
make_safeframe <- function(.data,
                           ...) {
  # assert inputs
  checkmate::assert_data_frame(.data, min.cols = 1)
  assert_not_data_table(.data)

  tags <- rlang::list2(...)
  .data <- tag_variables(.data, tags)

  # shape output and return object
  class(.data) <- c("safeframe", class(.data))
  .data
}
