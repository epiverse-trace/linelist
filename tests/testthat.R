library(testthat)
library(linelist)

test_results <- as.data.frame(test_check("linelist"))

if (any(test_results$warning > 0) && Sys.getenv("NOT_CRAN", FALSE)) {
  stop("tests failed with warnings")
}
