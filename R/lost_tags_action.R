#' Check and set behaviour for lost tags
#'
#' This function determines the behaviour to adopt when tagged variables of a
#' `linelist` are lost e.g. through subsetting. This is achieved using `options`
#' defined for the `linelist` package. The function can be used in isolation,
#' but it can also accept a dataset as first argument, so that it can be used in
#' pipelines as well.
#'
#' @param x either a `character`, or an optional `linelist` object; if a
#'   `character`, it needs matching `warning` (default), `error` or `none` (see
#'   below)
#'
#' @param action a `character` indicating the behaviour to adopt when tagged
#'   variables have been lost: "error" (default) will issue an error; "warning"
#'   will issue a warning; "none" will do nothing
#'
#' @param quiet a `logical` indicating if a message should be displayed; only
#'   used outside pipelines
#'
#' @return if a a `linelist` is provided, it returns the object unchanged;
#'   otherwise, returns `NULL`; the option itself is set in
#'   `options("linelist")`
#'
#' @export
#'
#' @rdname lost_tags_action
#'
#' @aliases lost_tags_action get_lost_tags_action
#'
#' @author Thibaut Jombart \email{thibaut@@data.org}
#'
#' @examples
#' # reset default - done automatically at package loading
#' lost_tags_action()
#'
#' # check current value
#' get_lost_tags_action()
#'
#' # change to issue errors when tags are lost
#' lost_tags_action("error")
#' get_lost_tags_action()
#'
#' # change to ignore when tags are lost
#' lost_tags_action("none")
#' get_lost_tags_action()
#'
#' # reset to default: warning
#' lost_tags_action()
#'
lost_tags_action <- function(x = NULL,
                             action = c("warning", "error", "none"),
                             quiet = FALSE) {
  linelist_options <- options("linelist")$linelist

  if (is.null(x)) {
    x <- "warning"
  }

  # behaviour 1: action is passed through `x`
  if (!is.null(x) && is.character(x) && length(x) == 1L) {
    action <- match.arg(x, c("warning", "error", "none"))
    linelist_options$lost_tags_action <- action
    options("linelist" = linelist_options)
    if (!quiet) {
      if (action == "warning") msg <- "Lost tags will now issue a warning."
      if (action == "error") msg <- "Lost tags will now issue an error."
      if (action == "none") msg <- "Lost tags will now be ignored."
      message(msg)
    }
    return(invisible(NULL))

    # behaviour 2 (in pipeline): first argument is a dataset
  } else {
    action <- match.arg(action)
    linelist_options$lost_tags_action <- action
    options("linelist" = linelist_options)
    return(x)
  }
}



#' @export
#'
#' @rdname lost_tags_action

get_lost_tags_action <- function() {
  options("linelist")$linelist$lost_tags_action
}
