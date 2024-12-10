test_that("tests for make_linelist", {

  # test errors
  msg <- "Must be of type 'data.frame', not 'NULL'."
  expect_error(make_linelist(NULL), msg)

  msg <- "Must have at least 1 cols, but has 0 cols."
  expect_error(make_linelist(data.frame()), msg)

  msg <- "Must be element of set {'speed','dist'}"
  expect_error(make_linelist(cars, bar = "outcome"), msg, fixed = TRUE)

  expect_error(
    make_linelist(cars, bar = "outcome", bla = "age"), 
    "2 assertions failed"
  )

  msg <- "Use only tags listed in `tags_names()`, or set `allow_extra = TRUE`"
  expect_error(
    make_linelist(cars, speed = "foo", allow_extra = FALSE),
    msg,
    fixed = TRUE
  )

  # test functionalities
  expect_identical(tags_defaults(), tags(make_linelist(cars), TRUE))

  x <- make_linelist(cars, dist = "date_onset", speed = "date_outcome")
  expect_identical(tags(x)$dist, "date_onset")
  expect_identical(tags(x)$speed, "date_outcome")
  expect_null(tags(x)$outcome)
  expect_null(tags(x)$date_reporting)

  x <- make_linelist(cars, speed = "foo", dist = "bar", allow_extra = TRUE)
  expect_identical(
    tags(x, TRUE),
    c(tags_defaults(), speed = "foo", dist = "bar")
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
