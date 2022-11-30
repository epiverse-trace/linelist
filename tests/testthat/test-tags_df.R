test_that("tests for tags_df", {
  x <- make_linelist(cars, age = "speed", date_reporting = "dist")
  y <- cars[c("dist", "speed")]
  names(y) <- c("date_reporting", "age")

  # errors
  msg <- "Assertion on 'x' failed: Must inherit from class 'linelist', but has class 'data.frame'."
  expect_error(tags_df(cars), msg)

  # functionality
  expect_identical(tags_df(x), y)
})
