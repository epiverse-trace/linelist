#' Rename columns of a linelist
#'
#' This function can be used to rename the columns a `linelist`, adjusting tags
#' as needed.
#'
#' @param x a `linelist` object
#'
#' @param value a `character` vector to set the new names of the columns of `x`
#'
#' @return a `linelist` with new column names
#'
#' @export
#'
#' @examples
#' if (require(outbreaks)) {
#'
#'   ## dataset to create a linelist from
#'   measles_hagelloch_1861
#'
#'   ## create linelist
#'   x <- make_linelist(measles_hagelloch_1861,
#'     id = "case_ID",
#'     date_onset = "date_of_prodrome",
#'     age = "age",
#'     gender = "gender"
#'   )
#'   head(x)
#'
#'   ## change names
#'   names(x)[1] <- "case_label"
#'
#'   ## see results: tags have been updated
#'   head(x)
#'   tags(x)
#'
#'  # This also works with using `dplyr::rename()` because it uses names<-()
#'  # under hood
#'  if (require(dplyr)) {
#'    x <- x |>
#'      rename(case_id= case_label)
#'    head(x)
#'    tags(x)
#'  }
#' }
`names<-.linelist` <- function(x, value) {
  # Strategy for renaming

  # Since renaming cannot drop columns, we can update tags to match new variable
  # names. We do this by:

  # 1. Storing old names and new names to have define replacement rules
  # 2. Replace all tagged variables using the replacement rules

  out <- drop_linelist(x, remove_tags = TRUE)
  names(out) <- value

  # Step 1
  old_names <- names(x)
  new_names <- names(out)
  if (anyNA(new_names)) {
    stop(
      "Suggested naming would result in `NA` for some column names.\n",
      "Did you provide less names than columns targetted for renaming?",
      call. = FALSE
    )
  }

  # Step 2
  out_tags <- tags(x, TRUE)
  for (i in seq_along(out_tags)) {
    if (!is.null(out_tags[[i]])) {
      idx <- match(out_tags[[i]], old_names)
      out_tags[[i]] <- new_names[idx]
    }
  }

  attr(out, "tags") <- out_tags
  class(out) <- class(x)
  out
}
