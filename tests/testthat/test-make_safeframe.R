test_that("tests for make_safeframe", {
  # test errors
  msg <- "Must be of type 'data.frame', not 'NULL'."
  expect_error(make_safeframe(NULL), msg)

  msg <- "Must have at least 1 cols, but has 0 cols."
  expect_error(make_safeframe(data.frame()), msg)

  msg <- "* Variable 'tag': Must be element of set {'speed','dist'}, but"
  expect_error(make_safeframe(cars, outcome = "bar"), msg, fixed = TRUE)

  expect_error(
    make_safeframe(cars, outcome = "bar", age = "bla"),
    "2 assertions failed"
  )

  # test functionalities
  expect_identical(
    tags(make_safeframe(cars)), list()
  )

  x <- make_safeframe(cars, distance = "dist", mph = "speed")
  expect_identical(tags(x)$distance, "dist")
  expect_identical(tags(x)$mph, "speed")
  expect_null(tags(x)$test)

  x <- make_safeframe(cars, foo = "speed", bar = "dist")
  expect_identical(
    tags(x),
    c(list(), foo = "speed", bar = "dist")
  )
})

test_that("make_safeframe() works with dynamic dots", {
  expect_identical(
    make_safeframe(cars, date_onset = "dist", date_outcome = "speed"),
    make_safeframe(cars, !!!list(date_onset = "dist", date_outcome = "speed"))
  )
})

test_that("make_safeframe() errors on data.table input", {
  dt_cars <- structure(
    cars,
    class = c("data.table", "data.frame")
  )

  expect_error(
    make_safeframe(dt_cars),
    "NOT be a data.table"
  )
})

test_that("alternative tagging functionality - position", {
  expect_silent(make_safeframe(cars, outcome = 2))
  # Out of bounds position
  expect_error(make_safeframe(cars, outcome = 3))
})

test_that("can set x as label, #45", {
  x <- data.frame(x = 1)
  expect_no_error(make_safeframe(x,
    x = "x"
  ))
})
