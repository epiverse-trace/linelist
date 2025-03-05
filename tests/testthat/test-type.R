test_that("type() fails as expected", {
  # incorrect argument type
  expect_error(type(1))
  # incorrect type choice
  expect_error(type("123"))
})

test_that("type() returns all options as expected", {
  x <- c("integer", "numeric", "Date", "POSIXct", "POSIXlt")
  expect_equal(type("date"), x)

  x <- c("character", "factor")
  expect_equal(type("category"), x)

  x <- c("numeric", "integer")
  expect_equal(type("numeric"), x)

  x <- c("logical", "integer", "character", "factor")
  expect_equal(type("binary"), x)
})

test_that("type() works nicely when combined with validate_types()", {
  x <- make_safeframe(cars,
    mph = "speed",
    distance = "dist"
  )

  expect_no_condition(validate_types(
    x,
    mph = type("numeric"),
    distance = type("numeric")
  ))
})
