test_that("tests for tags_df", {
  x <- make_linelist(cars, speed = "age", dist = "date_reporting")
  y <- cars[c("speed", "dist")]
  names(y) <- c("age", "date_reporting")

  # errors
  msg <- "Must inherit from class 'linelist', but has class 'data.frame'."
  expect_error(tags_df(cars), msg)

  # functionality
  expect_identical(tags_df(x), y)
})
