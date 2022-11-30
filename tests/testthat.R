if (require(testthat)) {
  library(linelist)  # nolint
  test_check("linelist")
} else {
  warning("'linelist' requires 'testthat' for tests")
}
