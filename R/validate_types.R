#' Check tagged variables are the right class
#'
#' This function checks the class of each tagged variable in a `linelist`
#' against pre-defined accepted classes in [tags_types()].
#'
#' @export
#'
#' @param x a `linelist` object
#'
#' @param ref_types a `list` providing allowed types for all tags, as returned
#'   by [tags_types()]
#'
#' @author Thibaut Jombart \email{thibaut@@data.org}
#'
#' @return A named `list`.
#'
#' @seealso
#' * [tags_types()] to change allowed types
#' * [validate_tags()] to perform a series of checks on the tags
#' * [validate_linelist()] to combine `validate_tags` and `validate_types`
#'
#' @examples
#' if (require(outbreaks) && require(dplyr) && require(magrittr)) {
#'
#'   ## create an invalid linelist - gender is a numeric
#'   x <- measles_hagelloch_1861 %>%
#'     tibble() %>%
#'     make_linelist(
#'       id = "case_ID",
#'       gender = "infector"
#'     )
#'   x
#'
#'   ## the below would issue an error
#'   ## note: tryCatch is only used to avoid a genuine error in the example
#'   tryCatch(validate_types(x), error = paste)
#'
#'   ## to allow other types, e.g. gender to be integer, character or factor
#'   validate_types(x, tags_types(gender = c("integer", "character", "factor")))
#' }
validate_types <- function(x, ref_types = tags_types()) {
  checkmate::assert_class(x, "linelist")

  df_to_check <- tags_df(x)

  for (i in seq_len(ncol(df_to_check))) {
    res <- validate_type(
      df_to_check[[i]],
      names(df_to_check)[i],
      ref_types
    )
    if (is.character(res)) {
      msg <- sprintf(
        "Issue when checking class of tag `%s`:\n%s",
        names(df_to_check)[i],
        res
      )
      stop(msg)
    }
  }

  x
}
