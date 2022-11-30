test_that("tests for tag_variable", {

  # Check error messages
  msg <- "Assertion on 'x' failed: Must be of type 'data.frame', not 'NULL'."
  expect_error(tag_variable(NULL), msg)

  msg <- "Assertion on 'x' failed: Must have at least 1 cols, but has 0 cols."
  expect_error(tag_variable(data.frame()), msg)

  msg <- "Assertion on 'var_name' failed: Element 1 is not <= 2."
  expect_error(tag_variable(cars, var_type = "distance", var_name = 3), msg)

  msg <- "Assertion on 'var_name' failed: Must be element of set \\{'speed','dist'\\}, but is 'toto'."
  expect_error(tag_variable(cars, var_type = "distance", var_name = "toto"), msg)

  msg <- "Assertion on 'var_name' failed: Must be element of set \\{'speed','dist'\\}, but is 'NA'."
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
