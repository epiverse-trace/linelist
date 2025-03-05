test_that("tests for validate_safeframe", {
  # errors
  msg <- "Must inherit from class 'safeframe', but has class 'NULL'."
  expect_error(validate_safeframe(NULL), msg)

  x <- make_safeframe(cars, mph = "speed", distance = "dist")
  msg <- "Assertion on 'types' failed: Must have length >= 1, but has length 0."
  expect_error(validate_safeframe(x), msg)
  expect_identical(x, validate_safeframe(x,
    mph = "numeric",
    distance = "numeric"
  ))

  x <- make_safeframe(cars, mph = "speed")
  expect_error(
    validate_safeframe(x, mph = c(
      "character",
      "factor"
    )),
    "- mph: Must inherit from class 'character'/'factor', but has class 'numeric'"
  )

  # Functionalities
  x <- make_safeframe(cars)
  msg <- "`x` has no tags"
  expect_error(validate_safeframe(x), msg)
})

test_that("validate_safeframe() allows valid objects", {
  x <- make_safeframe(cars, id = "speed")

  # Print a message
  expect_message(
    validate_safeframe(x, id = "numeric"),
    "valid"
  )

  # And returns invisibly...
  v <- suppressMessages(expect_invisible(
    validate_safeframe(x, id = "numeric")
  ))

  # ...an identical object
  expect_identical(x, v)
})
