test_that("tests for validate_types() basic input checking", {
  expect_error(
    validate_types(cars), 
    "Must inherit from class 'linelist', but has class 'data.frame'."
  )
})

test_that("validate_types() validates types", {
  # Successful validations
  x <- make_linelist(cars, age = "speed")
  expect_silent(
    expect_identical(
      x,
      validate_types(x)
    )
  )

  # Failed validations
  x <- make_linelist(cars, age = "speed")
  expect_error(
    validate_types(x, ref_types = tags_types(age = "factor")), 
    "age: Must inherit from class 'factor', but has class 'numeric'"
  )

  x <- make_linelist(cars, age = "speed", gender = "dist")
  expect_snapshot_error(
    validate_types(x, ref_types = tags_types(age = "factor"))
  )
})

test_that("missing ref_type in validate_types()", {
  # Single missing
  x <- make_linelist(cars, age = "speed", d = "dist", allow_extra = TRUE)
  expect_error(
    validate_types(x),
    "Allowed types for tag `d` are not documented in `ref_types`."
  )

  # Two missing
  x <- make_linelist(cars, a = "speed", d = "dist", allow_extra = TRUE)
  expect_error(
    validate_types(x),
    "Allowed types for tag `a`, `d` are not documented in `ref_types`."
  )
})
