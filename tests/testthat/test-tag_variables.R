test_that("tests for tag_variables", {

  expect_error(
    tag_variables(cars, list(distance = 3)),
    "lower than the number of columns"
  )

  expect_error(
    tag_variables(cars, list(distance = "toto")),
    "Must be element of set \\{'speed','dist'\\}, but is"
  )

  expect_error(
    tag_variables(cars, list(distance = NA)), 
    "Must be element of set \\{'speed','dist'\\}, but is."
  )

  # Check functionality
  expect_identical(
    tag_variables(cars, list(distance = 2)),
    tag_variables(cars, list(distance = "dist"))
  )

  x <- tag_variables(cars, list(distance = "dist"))
  expect_identical(attr(x, "tags"), list(distance = "dist"))

  x <- tag_variables(x, list(speed = 1))
  expect_identical(attr(x, "tags"), list(distance = "dist", speed = "speed"))

  x <- tag_variables(x, list(speed = NULL)) # reset to NULL
  expect_identical(attr(x, "tags"), list(distance = "dist", speed = NULL))
})
