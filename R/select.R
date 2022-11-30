#' Subset columns of a linelist object
#'
#' This function works similarly to [dplyr::select()] but can in addition refer
#' to tagged variables through the `tags` argument. When variables are selected
#' using both procedures, tagged variables are output as the last columns.
#'
#' @rdname select.linelist
#'
#' @param .data a `linelist` object
#'
#' @param ... the variables to select, using `dplyr` compatible syntax
#'
#' @param tags a `character` indicating tagged variables to select using tag
#'   names (see [tags_names()]) for default values; values can be named, in
#'   which case the output columns will be renamed accordingly (e.g. `onset =
#'   "date_onset"` will output a column named 'onset').
#'
#' @importFrom dplyr select
#'
#' @export
#'
#' @author Thibaut Jombart \email{thibaut@@data.org}
#'
#' @return The function returns a `linelist` with selected columns.
#'
#' @seealso
#' * [select_tags()] to select tags only
#' * [tags_df()] to return a `data.frame` of all tagged variables
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
#'   ## change select all dates and some tags
#'   x %>%
#'     select(contains("date"), tags = c("id", "age", "gender"))
#'
#'   ## showing warnings when tags are lost
#'   x %>%
#'     select(1:3)
#'
#'   ## getting rid of warnings on the fly
#'   x %>%
#'     lost_tags_action("none") %>%
#'     select(1:3)
#'
#'   ## reset default behaviour
#'   lost_tags_action()
#' }
select.linelist <- function(.data, ..., tags = NULL) {
  lost_action <- get_lost_tags_action()

  checkmate::assertCharacter(tags, null.ok = TRUE)
  x <- .data

  # Strategy
  # --------
  #
  # Variable selection is done in two steps:
  #
  # 1. normal use of `dplyr::select` on the data.frame using `...` arguments
  # 2. selection of tagged variables via the `tags` argument
  #
  # Both outputs are cbinded in the returned object. The following additional
  # checks are done:
  #
  # if tagged variables are added to the output, they need renaming to their
  # canonical tag name
  #
  # we need to check that tagged variables have not been lost, through
  # subsetting or renaming; for this we use `restore_tags()`
  #

  # step 1
  df_base <- dplyr::select(drop_linelist(x), ...)

  # step 2
  # Note that tags could be renamed e.g. tags = c(onset = "date_onset"); we need
  # to ensure that the tags of the output will be renamed accordingly. It is not
  # entirely trivial as some of the tags may be named / renamed, some not,
  # e.g. tags = c(age, onset = "date_onset")); as a workaround we impose names
  # on all tags, then we rename tags as needed.
  df_tags <- select_tags(x, tags)

  ## keep old tags
  old_tags <- tags(x, TRUE)

  ## force naming of all new tags
  tag_names <- names(tags)
  ###  special case of a single unnamed tag
  if (is.null(tag_names)) {
    tag_names <- tags
  } else {
    missing_names <- tag_names == ""
    tag_names[missing_names] <- tags[missing_names]
  }

  ## create new_tags where tags are renamed as needed
  new_tags <- as.list(tag_names)
  names(new_tags) <- tags
  out_tags <- modify_defaults(old_tags, new_tags)


  # finalize output
  # Note: cbind() loses the `tibble` class, which we want to avoid.
  if (inherits(x, "tbl_df")) {
    out <- dplyr::bind_cols(df_base, df_tags)
  } else {
    out <- cbind(df_base, df_tags)
  }
  out <- restore_tags(out, out_tags, lost_action)
  out
}
