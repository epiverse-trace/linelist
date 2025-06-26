test_that("tests for validate_tags", {

  # test errors
  msg <- "Must inherit from class 'linelist', but has class 'data.frame'."
  expect_error(validate_tags(cars), msg)

  x <- make_linelist(cars)
  msg <- "`x` has no tags"
  expect_error(validate_tags(x), msg)

  x <- set_tags(x, toto = "speed", allow_extra = TRUE)
  msg <- paste(
    "The following tags are not part of the defaults:\ntoto",
    "Consider using `allow_extra = TRUE` to allow additional tags.",
    sep = "\n"
  )
  expect_error(validate_tags(x), msg)

  # functionalities
  x <- make_linelist(cars, date_onset = "dist")
  expect_identical(x, validate_tags(x))

  x <- set_tags(x, toto = "speed", allow_extra = TRUE)
  expect_identical(x, validate_tags(x, allow_extra = TRUE))
})
