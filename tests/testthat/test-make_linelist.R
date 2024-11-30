test_that("tests for make_linelist", {
  # test errors
  msg <- "Must be of type 'data.frame', not 'NULL'."
  expect_error(make_linelist(NULL), msg)

  msg <- "Must have at least 1 cols, but has 0 cols."
  expect_error(make_linelist(data.frame()), msg)

  expect_error(
    make_linelist(cars, outcome = "bar", age = "bla", allow_extra = TRUE),
    "2 assertions failed"
  )

  msg <- "set `allow_extra = TRUE`"
  expect_error(
    make_linelist(cars, speed = "foo", allow_extra = FALSE),
    msg,
    fixed = TRUE
  )

  x <- make_linelist(
    cars,
    dist = "id",
    speed = "date_onset"
  )
  expect_identical(labels(x)$dist, "id")
  expect_identical(labels(x)$speed, "date_onset")
  expect_null(labels(x)$outcome)
  expect_null(labels(x)$date_reporting)

  x <- make_linelist(
    cars,
    speed = "Miles per hour",
    dist = "Distance in miles", 
    allow_extra = TRUE
  )
  expect_identical(
    labels(x, TRUE),
    list(
      speed = "Miles per hour",
      dist = "Distance in miles"
    )
  )
})

test_that("make_linelist() works with dynamic dots", {
  expect_identical(
    make_linelist(cars, dist = "date_onset", speed = "date_outcome"),
    make_linelist(cars, !!!list(dist = "date_onset", speed = "date_outcome"))
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
