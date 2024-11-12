test_that("tests for validate_types() basic input checking", {
  expect_error(
    validate_types(cars),
    "Must inherit from class 'linelist', but has class 'data.frame'."
  )
})

test_that("validate_types() validates types", {
  # Successful validations
  x <- make_linelist(cars, !!!update_defaults(id = "speed"))
  expect_silent(
    expect_identical(
      x,
      validate_types(x, vars_types(id = "speed"))
    )
  )

  # Failed validations
  expect_snapshot_error(
    validate_types(x, vars_types(gender = "dist"))
  )
})

test_that("missing ref_type in validate_types()", {
  # Single missing
  x <- make_linelist(cars, !!!update_defaults(
    id = "speed",
    age = "dist"
  ))

  expect_error(
    validate_types(x, ref_types = list(speed = type("numeric")), strict = TRUE),
    "Variable `dist` are not available in `x`."
  )

  # Two missing
  x <- make_linelist(cars, a = "speed", d = "dist", allow_extra = TRUE)
  expect_error(
    validate_types(x, ref_types = list(a = "numeric", d = "boolean"), strict = TRUE),
    "Variable `speed`, `dist` are not available in `x`."
  )
})
