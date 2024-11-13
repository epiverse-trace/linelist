test_that("tests for vars_types", {
  # Check functionality
  x <- vars_types()
  expect_snapshot(x)
  expect_type(x, "list")
  expect_true(all(sapply(x, is.character)))

  vars_types(id = "case_ID")
  # Check errors
  msg <- "'names' attribute [14] must be the same length as the vector [13]"
  expect_error(vars_types(fail = "case_ID"), msg, fixed = TRUE)

  x <- vars_types(date_outcome = "Date")
  expect_identical(x$Date, type("Date"))
})
