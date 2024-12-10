test_that("tests for tags", {

  # Check error messages
  x <- make_linelist(cars, speed = "age")

  # Check functionality
  expect_identical(tags(x), list(speed = "age"))
  expect_identical(tags(x, TRUE), attr(x, "tags"))
  expect_identical(tags(make_linelist(cars), TRUE), tags_defaults())
})
