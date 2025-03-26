test_that("tests for tags", {

  # Check error messages
  x <- make_linelist(cars, age = "speed")

  # Check functionality
  expect_identical(tags(x), list(age = "speed"))
  expect_identical(tags(make_linelist(cars), TRUE), tags_defaults())
})
