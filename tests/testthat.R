if (require(testthat)) {
  library(linelist)
  test_check("linelist")
} else {
  warning("'linelist' requires 'testthat' for tests")
}
