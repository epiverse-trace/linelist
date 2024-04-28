library(testthat)
library(linelist)

test_df <- as.data.frame(test_check("linelist"))

if (any(test_df$warning > 0) && !identical(Sys.getenv("NOT_CRAN"), "TRUE")) {
  stop("tests failed with warnings")
}
