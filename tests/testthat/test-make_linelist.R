test_that("tests for make_linelist", {

  # test errors
  msg <- "Assertion on 'x' failed: Must be of type 'data.frame', not 'NULL'."
  expect_error(make_linelist(NULL), msg)

  msg <- "Assertion on 'x' failed: Must have at least 1 cols, but has 0 cols."
  expect_error(make_linelist(data.frame()), msg)

  msg <- "Assertion on 'var_name' failed: Must be element of set \\{'speed','dist'\\}, but is 'bar'."
  expect_error(make_linelist(cars, outcome = "bar"), msg)

  msg <- "Unknown variable types: foo\n  Use only tags listed in `tags_names()`, or set `allow_extra = TRUE`"
  expect_error(make_linelist(cars, foo = "speed", allow_extra = FALSE), msg, fixed = TRUE)

  # test functionalities
  expect_identical(tags_defaults(), tags(make_linelist(cars), TRUE))

  x <- make_linelist(cars, date_onset = "dist", date_outcome = "speed")
  expect_identical(tags(x)$date_onset, "dist")
  expect_identical(tags(x)$date_outcome, "speed")
  expect_null(tags(x)$outcome)
  expect_null(tags(x)$date_reporting)

  x <- make_linelist(cars, foo = "speed", bar = "dist", allow_extra = TRUE)
  expect_identical(tags(x, TRUE), c(tags_defaults(), foo = "speed", bar = "dist"))

  x <- make_linelist(cars, date_onset = "dist", date_outcome = "speed")
  y <- make_linelist(cars, list(date_onset = "dist", date_outcome = "speed"))
  expect_identical(x, y)
})
