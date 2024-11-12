test_that("tests for make_linelist", {
  # test errors
  msg <- "Must be of type 'data.frame', not 'NULL'."
  expect_error(make_linelist(NULL), msg)

  msg <- "Must have at least 1 cols, but has 0 cols."
  expect_error(make_linelist(data.frame()), msg)

  expect_error(
    make_linelist(cars, outcome = "bar", age = "bla", strict = TRUE),
    "15 assertions failed"
  )

  msg <- 
    "There are labels in x that are not in defaults and allow_extra is FALSE"
  expect_error(
    make_linelist(cars, foo = "speed", allow_extra = FALSE),
    msg,
    fixed = TRUE
  )

  x <- make_linelist(cars, !!!update_defaults(
    id = 'dist',
    date_onset = 'speed'))
  expect_identical(labels(x)$dist, "Subject ID")
  expect_identical(labels(x)$speed, "Date of symptom onset")
  expect_null(labels(x)$outcome)
  expect_null(labels(x)$date_reporting)

  x <- make_linelist(cars, speed = "Miles per hour",
                     dist = "Distance in miles", allow_extra = TRUE)
  expect_identical(
    labels(x, TRUE),
    list(speed = "Miles per hour",
      dist = "Distance in miles")
  )
})

test_that("make_linelist() works with dynamic dots", {
  expect_identical(
    make_linelist(cars, date_onset = "dist", date_outcome = "speed"),
    make_linelist(cars, !!!list(date_onset = "dist", date_outcome = "speed"))
  )
})

test_that("make_linelist() errors on data.table input", {
  dt_cars <- structure(
    cars,
    class = c("data.table", "data.frame")
  )

  expect_error(
    make_linelist(dt_cars),
    "NOT be a data.table"
  )
})
