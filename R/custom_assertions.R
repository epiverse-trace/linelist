# Built following instructions from
# https://mllg.github.io/checkmate/articles/checkmate.html#extending-checkmate
check_not_data_table <- function(x) {
  if (inherits(x, "data.table")) {
    return("must NOT be a data.table")
  }
  TRUE
}

assert_not_data_table <- function(
    x,
    .var.name = checkmate::vname(x),
    add = NULL
) {
  if (missing(x)) {
    stop(sprintf(
      "argument \"%s\" is missing, with no default",
      .var.name
    ), call. = FALSE)
  }
  res <- check_not_data_table(x)
  checkmate::makeAssertion(x, res, .var.name, add)
}
