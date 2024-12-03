test_that("validate_linelist() detects invalid objects", {
  msg <- "Must inherit from class 'linelist', but has class 'NULL'."
  expect_error(validate_linelist(NULL), msg)

  x <- make_linelist(cars, speed = "id", dist = "gender")

  expect_snapshot_error(validate_linelist(x))

  x <- make_linelist(cars, speed = "gender")
  expect_snapshot_error(
    validate_linelist(x, ref_types = labels_types(gender = "speed"))
  )
})

test_that("validate_linelist() allows valid objects", {
  x <- make_linelist(cars, speed = "id")

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
  x <- make_linelist(cars, speed = "id")
  expect_identical(x, validate_linelist(x,
    ref_types = vars_types(id = "speed")
  ))
})
