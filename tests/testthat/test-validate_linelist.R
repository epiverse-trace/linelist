test_that("validate_linelist() detects invalid objects", {
  msg <- "Must inherit from class 'linelist', but has class 'NULL'."
  expect_error(validate_linelist(NULL), msg)

  x <- make_linelist(cars, !!!update_defaults(id = "speed", gender = "dist"),
    allow_extra = TRUE
  )

  expect_snapshot_error(validate_linelist(x, strict = TRUE))

  x <- make_linelist(cars, !!!update_defaults(gender = "speed"))
  expect_snapshot_error(
    validate_linelist(x, ref_types = vars_types(gender = "speed"))
  )
})

test_that("validate_linelist() allows valid objects", {
  x <- make_linelist(cars, !!!update_defaults(id = "speed"))

  # Print a message
  expect_message(
    validate_linelist(x),
    "valid"
  )

  # And returns invisibly...
  v <- suppressMessages(expect_invisible(validate_linelist(x)))

  # ...an identical object
  expect_identical(x, v)

  # Functionalities
  x <- make_linelist(cars, !!!update_defaults(id = "speed"))
  expect_identical(x, validate_linelist(x,
    ref_types = vars_types(id = "speed")
  ))
})
