library(testthat)
library(linelist)

test_results <- as.data.frame(test_check("linelist"))

if (any(test_results$warning > 0) && !identical(Sys.getenv("NOT_CRAN"), "TRUE")) {
  stop("tests failed with warnings")
}
