test_that("tests for set_tags()", {
  x <- make_linelist(cars, dist = "date_onset")

  # Check error messages
  msg <- "Must inherit from class 'linelist', but has class 'data.frame'."
  expect_error(set_tags(cars), msg)

  msg <- "Use only tags listed in `tags_names()`, or set `allow_extra = TRUE`"
  expect_error(set_tags(x, dist = "toto"), msg, fixed = TRUE)

  msg <- "Must be element of set {'speed','dist'}, but"
  expect_error(set_tags(x, toto = "outcome"), msg, fixed = TRUE)


  # Check functionality
  expect_identical(x, set_tags(x))
  x <- set_tags(x, speed = "date_reporting")
  expect_identical(tags(x)$speed, "date_reporting")
  expect_identical(tags(x)$dist, "date_onset")

  x <- set_tags(x, speed = "id", dist = "date_outcome")
  y <- set_tags(x, !!!list(speed = "id", dist = "date_outcome"))
  expect_identical(x, y)
})
