test_that("tests for validate_types() basic input checking", {
  expect_error(
    validate_types(cars),
    "Must inherit from class 'safeframe', but has class 'data.frame'."
  )
})

test_that("validate_types() validates types", {
  # Successful validations
  x <- make_safeframe(cars, mph = "speed")
  expect_identical(
    x,
    validate_types(x, mph = "numeric")
  )

  # Failed validations
  x <- make_safeframe(cars, mph = "speed")
  expect_error(
    validate_types(x, mph = "factor"),
    "mph: Must inherit from class 'factor', but has class 'numeric'"
  )

  x <- make_safeframe(cars, mph = "speed", distance = "dist")
  expect_snapshot_error(
    validate_types(x, mph = "factor", distance = "character")
  )
})

test_that("ensure validate_types throws error if no types provided", {
  x <- make_safeframe(cars, mph = "speed", distance = "dist")
  expect_error(
    validate_types(x),
    "Assertion on 'types' failed: Must have length >= 1, but has length 0."
  )
})

test_that("validate_types fails if types are provided for non-existent tags", {
  x <- make_safeframe(cars, mph = "speed")
  expect_error(
    validate_types(x, distance = "numeric")
  )
})

test_that("Inherited classes are handled - #44", {
  y <- 1L
  x <- data.frame(y)
  x <- make_safeframe(x, bob = "y")
  expect_silent(validate_types(x, bob = "integer"))
  expect_silent(validate_types(x, bob = "numeric"))

  y <- 1
  x <- data.frame(y)
  x <- make_safeframe(x, bob = "y")
  expect_silent(validate_types(x, bob = "double"))
  expect_silent(validate_types(x, bob = "numeric"))
})
