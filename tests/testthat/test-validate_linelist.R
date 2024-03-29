test_that("tests for validate_linelist", {

  # errors
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

  # Functionalities
  x <- make_linelist(cars)
  expect_identical(x, validate_linelist(x))
})
