#' Subsetting of linelist objects
#'
#' The `[]` and `[[]]` operators for `linelist` objects behaves like for regular
#' `data.frame` or `tibble`, but check that tagged variables are not lost, and
#' takes the appropriate action if this is the case (warning, error, or ignore,
#' depending on the general option set via [lost_tags_action()]) .
#'
#' @param x a `linelist` object
#'
#' @param i a vector of `integer` or `logical` to subset the rows of the
#'   `linelist`
#'
#' @param j a vector of `character`, `integer`, or `logical` to subset the
#'   columns of the `linelist`
#'
#' @param drop a `logical` indicating if, when a single column is selected, the
#'   `data.frame` class should be dropped to return a simple vector, in which
#'   case the `linelist` class is lost as well; defaults to `FALSE`
#'
#' @param value the replacement to be used for the entries identified in `x`
#'
#' @return If no drop is happening, a `linelist`. Otherwise an atomic vector.
#'
#' @seealso
#' * [lost_tags_action()] to set the behaviour to adopt when tags are
#'   lost through subsetting; default is to issue a warning
#' * [get_lost_tags_action()] to check the current the behaviour
#'
#' @export
#'
#' @rdname sub_linelist
#'
#' @aliases sub_linelist
#'
#' @author Thibaut Jombart \email{thibaut@@data.org}
#'
#' @examples
#' if (require(outbreaks) && require(dplyr) && require(magrittr)) {
#'   ## create a linelist
#'   x <- measles_hagelloch_1861 %>%
#'     tibble() %>%
#'     make_linelist(
#'       id = "case_ID",
#'       date_onset = "date_of_prodrome",
#'       age = "age",
#'       gender = "gender"
#'     ) %>%
#'     mutate(result = if_else(is.na(date_of_death), "survived", "died")) %>%
#'     set_tags(outcome = "result") %>%
#'     rename(identifier = case_ID)
#'   x
#'
#'   ## dangerous removal of a tagged column setting it to NULL issues a warning
#'   x[, 1] <- NULL
#'   x
#'
#'   x[[2]] <- NULL
#'   x
#' }
`[.linelist` <- function(x, i, j, drop = FALSE) {
  # Strategy for subsetting
  #
  # Subsetting is done using the next method in line, and making post-hoc checks
  # on two things:
  #
  # 1. that the subsetted object is still a `data.frame` or a `tibble`; if not,
  # we automatically drop the `linelist` class and tags
  # 2. if the output is going to be a `linelist` we need to restore previous
  # tags with the appropriate behaviour in case of missing tagged variables
  #
  # Note that the [ operator's implementation is messy and does not seem to pass
  # the drop argument well when using NextMethod(); also it does not allow extra
  # args, in case we wanted to use them; so declassing the object instead using
  # the drop_linelist() function

  lost_action <- get_lost_tags_action()

  # Case 1
  out <- drop_linelist(x)[i, j, drop = drop]
  if (is.null(ncol(out))) {
    return(out)
  }

  # Case 2
  old_tags <- tags(x, TRUE)
  out <- restore_tags(out, old_tags, lost_action)

  out
}



#' @export
#'
#' @rdname sub_linelist

`[<-.linelist` <- function(x, i, j, value) {
  lost_action <- get_lost_tags_action()
  out <- NextMethod()
  old_tags <- tags(x, TRUE)
  out <- restore_tags(out, old_tags, lost_action)
  out
}



#' @export
#'
#' @rdname sub_linelist

`[[<-.linelist` <- function(x, i, j, value) {
  lost_action <- get_lost_tags_action()
  out <- NextMethod()
  old_tags <- tags(x, TRUE)
  out <- restore_tags(out, old_tags, lost_action)
  out
}
