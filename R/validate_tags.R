#' Checks the tags of a linelist object
#'
#' This function evaluates the validity of the tags of a `linelist` object by
#' checking that: i) tags are present ii) tags is a `list` of `character` iii)
#' that all default tags are present iv) tagged variables exist v) that no extra
#' tag exists (if `allow_extra` is `FALSE`).
#'
#' @export
#'
#' @param x a `linelist` object
#'
#' @inheritParams set_tags
#'
#' @return If checks pass, a `linelist` object; otherwise issues an error.
#'
#' @seealso [validate_types()] to check if tagged variables have
#'   the right classes
#'
#' @examples
#' if (require(outbreaks)) {
#'
#'   ## create a valid linelist
#'   x <- measles_hagelloch_1861 |>
#'     make_linelist(
#'       id = "case_ID",
#'       date_onset = "date_of_prodrome",
#'       age = "age",
#'       gender = "gender"
#'     )
#'   x
#'
#'   ## validation
#'   validate_tags(x)
#'
#'   ## hack to create an invalid tags (missing defaults)
#'   attr(x, "tags") <- list(id = "case_ID")
#'
#'   ## the below issues an error
#'   ## note: tryCatch is only used to avoid a genuine error in the example
#'   tryCatch(validate_tags(x), error = paste)
#' }
validate_tags <- function(x, allow_extra = FALSE) {
  checkmate::assert_class(x, "linelist")
  x_tags <- tags(x, show_null = TRUE)

  stopifnot(
    "`x` has no tags attribute" = !is.null(x_tags)
  )

  # check that x is a list, and each tag is a `character`
  checkmate::assert_list(x_tags, types = c("character", "null"))

  # check that defaults are present
  default_present <- tags_names() %in% names(x_tags)
  if (!all(default_present)) {
    missing_tags <- tags_names()[!default_present]
    stop(
      "The following default tags are missing:\n",
      toString(missing_tags),
      call. = FALSE
    )
  }

  # check there is no extra value
  if (!allow_extra) {
    is_extra <- !names(x_tags) %in% tags_names()
    if (any(is_extra)) {
      extra_tags <- names(x_tags)[is_extra]
      stop(
        "The following tags are not part of the defaults:\n",
        toString(extra_tags),
        "\nConsider using `allow_extra = TRUE` to allow additional tags.",
        call. = FALSE
      )
    }
  }

  # check that tagged variables exist
  x_tags_vec <- unlist(tags(x))
  var_exists <- x_tags_vec %in% names(x)
  if (!all(var_exists)) {
    missing_var <- x_tags_vec[!var_exists]
    stop(
      "The following tagged variables are missing:\n",
      paste0(names(missing_var), ":", missing_var, collapse = ", "),
      call. = FALSE
    )
  }

  x
}
