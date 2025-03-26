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
#' @return A named `list`.
#'
#' @seealso
#' * [tags_types()] to change allowed types
#' * [validate_tags()] to perform a series of checks on the tags
#' * [validate_linelist()] to combine `validate_tags` and `validate_types`
#'
#' @examples
#' if (require(outbreaks)) {
#'
#'   ## create an invalid linelist - gender is a numeric
#'   x <- measles_hagelloch_1861 |>
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

  if (!all(names(df_to_check) %in% names(ref_types))) {
    stop(
      "Allowed types for tag ",
      toString(paste0("`", setdiff(names(df_to_check), names(ref_types)), "`")),
      " are not documented in `ref_types`.",
      call. = FALSE
    )
  }

  type_checks <- lapply(
    names(df_to_check),
    function(tag) {
      allowed_types <- ref_types[[tag]]
      checkmate::check_multi_class(
        df_to_check[[tag]],
        allowed_types,
        null.ok = TRUE
      )
    }
  )
  has_correct_types <- vapply(type_checks, isTRUE, logical(1))

  if (!all(has_correct_types)) {
    stop(
      "Some tags have the wrong class:\n",
      sprintf(
        "  - %s: %s\n",
        names(df_to_check)[!has_correct_types],
        type_checks[!has_correct_types]
      ),
      call. = FALSE
    )
  }

  x
}
