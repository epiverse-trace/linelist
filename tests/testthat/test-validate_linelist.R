test_that("validate_linelist() detects invalid objects", {
  msg <- "Must inherit from class 'linelist', but has class 'NULL'."
  expect_error(validate_linelist(NULL), msg)

  x <- make_linelist(cars, id = "speed", toto = "dist", allow_extra = TRUE)
  msg <- paste(
    "The following tags are not part of the defaults:\ntoto",
    "Consider using `allow_extra = TRUE` to allow additional tags.",
    sep = "\n"
  )
  expect_error(validate_linelist(x), msg)

  x <- make_linelist(cars, gender = "speed")
  expect_error(
    validate_linelist(x), 
    "- gender: Must inherit from class 'character'/'factor'"
  )
})

test_that("validate_linelist() allows valid objects", {

  x <- make_linelist(cars, id = "speed")

  # Print a message
  expect_message(
    validate_linelist(x),
    "valid"
  )

  # And returns invisibly...
  v <- suppressMessages(expect_invisible(validate_linelist(x)))

  # ...an identical object
  expect_identical(x, v)

})
