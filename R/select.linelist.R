#' Subset columns of a linelist object
#'
#' @keywords deprecated
#' @description
#' `r lifecycle::badge("superseded")`
#'
#' This function was deprecated to ensure full compatibility with the default
#' [dplyr::select()] methods. The tag selection feature is now possible via the
#' [has_tag()] selection helper.
#'
#' @param .data a `linelist` object
#'
#' @param ... the variables to select, using `dplyr` compatible syntax
#'
#' @param tags `r lifecycle::badge("deprecated")` It is now recommended to
#'   leverage the [has_tag()] selection helper rather than this argument.
#'
#'
#' @importFrom dplyr select
#'
#' @export
#'
#' @return The function returns a `linelist` with selected columns.
#'
#' @seealso
#' * [tags_df()] to return a `data.frame` of all tagged variables
#'
select.linelist <- function(.data, ..., tags) {

  if (lifecycle::is_present(tags)) {
    lifecycle::deprecate_warn(
      "1.0.0",
      "select(tags)",
      details = paste(
        "It is now recommended to leverage the `has_tag()` selection helper",
        "rather than this argument."
      )
    )
    return(select(.data, ..., has_tag(tags)))
  }

  NextMethod()
}
