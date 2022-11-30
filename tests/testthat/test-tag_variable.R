test_that("tests for tag_variable", {

  # Check error messages
  msg <- "Must be of type 'data.frame', not 'NULL'."
  expect_error(tag_variable(NULL), msg)

  msg <- "Must have at least 1 cols, but has 0 cols."
  expect_error(tag_variable(data.frame()), msg)

  msg <- "Element 1 is not <= 2."
  expect_error(tag_variable(cars, var_type = "distance", var_name = 3), msg)

  msg <- "Must be element of set \\{'speed','dist'\\}, but is 'toto'." # nolint
  expect_error(
    tag_variable(cars, var_type = "distance", var_name = "toto"),
    msg
  )

  msg <- "Must be element of set \\{'speed','dist'\\}, but is 'NA'." # nolint
  expect_error(tag_variable(cars, var_type = "distance", var_name = NA), msg)


  # Check functionality
  expect_identical(
    tag_variable(cars, var_type = "distance", var_name = 2),
    tag_variable(cars, var_type = "distance", var_name = "dist")
  )

  x <- tag_variable(cars, var_type = "distance", var_name = "dist")
  expect_identical(attr(x, "tags"), list(distance = "dist"))

  x <- tag_variable(x, var_type = "speed", var_name = 1)
  expect_identical(attr(x, "tags"), list(distance = "dist", speed = "speed"))

  x <- tag_variable(x, var_type = "speed") # reset to NULL
  expect_identical(attr(x, "tags"), list(distance = "dist", speed = NULL))
})
