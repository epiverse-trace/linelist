test_that("tests for se_tags", {
  x <- make_linelist(cars, date_onset = "dist")

  # Check error messages
  msg <- "Must inherit from class 'linelist', but has class 'data.frame'."
  expect_error(set_tags(cars), msg)

  msg <- "Use only tags listed in `tags_names()`, or set `allow_extra = TRUE`"
  expect_error(set_tags(x, toto = 1), msg, fixed = TRUE)

  msg <- "Must be element of set \\{'speed','dist'\\}, but is 'toto'." # nolint
  expect_error(set_tags(x, outcome = "toto"), msg)


  # Check functionality
  expect_identical(x, set_tags(x))
  x <- set_tags(x, date_reporting = "speed")
  expect_identical(tags(x)$date_reporting, "speed")
  expect_identical(tags(x)$date_onset, "dist")

  x <- set_tags(x, id = "speed", date_outcome = "dist")
  y <- set_tags(x, list(id = "speed", date_outcome = "dist"))
  expect_identical(x, y)
})
