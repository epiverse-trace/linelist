test_that("tests for validate_labels", {
  # test errors
  msg <- "Must inherit from class 'safeframe', but has class 'data.frame'."
  expect_error(validate_labels(cars), msg)

  x <- make_linelist(cars)
  msg <- "`x` has no labels"
  expect_error(validate_labels(x), msg)

  x <- make_linelist(cars, !!!update_defaults(id = "dist"))
  expect_snapshot_error(validate_labels(x, strict = TRUE))

  x <- set_labels(x, speed = "Miles per hour")
  expect_snapshot_error(validate_labels(x, allow_extra = FALSE))
  
  # functionalities
  x <- make_linelist(cars)
  expect_error(validate_labels(x))

  x <- set_labels(x, dist = "Distance in miles", speed = "Miles per hour")
  expect_identical(x, validate_labels(x, allow_extra = TRUE))
})
