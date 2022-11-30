#' Rename columns of a linelist object
#'
#' This function works similarly to `dplyr::rename` and can be used to rename
#' the columns of a `linelist`. Tagged variables are updated as needed to match
#' new column names.
#'
#' @rdname rename.linelist
#'
#' @param .data a `linelist` object
#'
#' @param ... the variables to rename, using `dplyr` compatible syntax
#'
#' @importFrom dplyr rename
#'
#' @export
#'
#' @author Thibaut Jombart \email{thibaut@@data.org}
#'
#' @return The function returns a `linelist` with renameed columns.
#'
#' @seealso
#' * [select.linelist()] for selecting variables and tags
#' * [select_tags()] for selecting tags
#' * [tags_df()] to return a `data.frame` or a `tibble` of all agged variables
#'
#' @examples
#' if (require(outbreaks) && require(dplyr) && require(magrittr)) {
#'
#'   ## dataset to create a linelist from
#'   head(measles_hagelloch_1861)
#'
#'   ## create linelist
#'   x <- measles_hagelloch_1861 %>%
#'     tibble() %>%
#'     make_linelist(
#'       id = "case_ID",
#'       date_onset = "date_of_prodrome",
#'       age = "age",
#'       gender = "gender"
#'     )
#'   x
#'
#'   ## change names
#'   x <- x %>%
#'     rename(sex = gender, case = case_ID)
#'
#'   ## see results: tags have been updated
#'   x
#'   tags(x)
#' }
rename.linelist <- function(.data, ...) {
  # Strategy: we use `dplyr::rename` to handle the renaming of columns, then
  # extract these names and use them to rename the linelist using
  # `names<-.linelist`
  out <- .data
  new_names <- names(dplyr::rename(drop_linelist(out), ...))
  names(out) <- new_names
  out
}
