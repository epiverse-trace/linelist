library(testthat)
library(linelist)

test_results <- test_check("linelist")

if (any(as.data.frame(test_results)$warning > 0)) {
  stop("tests failed with warnings")
}
