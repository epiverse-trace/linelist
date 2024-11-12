test_that("tests for vars_types", {
  vars_types(test = "test", allow_extra = TRUE)
  # Check errors
  msg <- "Use only tags listed in `labels()`, or set `allow_extra = TRUE`"
  expect_error(vars_types(toto = "ilestbo"), msg, fixed = TRUE)

  # Check functionality
  x <- vars_types()
  expect_identical(labels(), names(x))
  expect_type(x, "list")
  expect_true(all(sapply(x, is.character)))

  x <- vars_types(date_outcome = "Date")
  expect_identical(x$date_outcome, "Date")
  x <- vars_types(date_outcome = "Date", seq = "DNAbin", allow_extra = TRUE)
  expect_identical(x$seq, "DNAbin")
})

test_that("type checking works as expected", {

})

test_that("vars_types fails as expected", {

})

test_that("vars_types succeeds as expected", {

})
