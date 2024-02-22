test_that("tag_variables() works with specification by position", {
  expect_error(
    tag_variables(cars, list(distance = "toto")),
    "Must be element of set \\{'speed','dist'\\}, but is"
  )

  expect_error(
    tag_variables(cars, list(distance = NA)), 
    "Must be element of set \\{'speed','dist'\\}, but is."
  )

  # Check functionality
  x <- tag_variables(cars, list(distance = "dist"))
  expect_identical(attr(x, "tags"), list(distance = "dist"))

  x <- tag_variables(x, list(vitesse = "speed"))
  expect_identical(attr(x, "tags"), list(distance = "dist", vitesse = "speed"))

  x <- tag_variables(x, list(vitesse = NULL)) # reset to NULL
  expect_identical(attr(x, "tags"), list(distance = "dist", vitesse = NULL))
})

test_that("tag_variables() works with specification by position", {
  expect_error(
    tag_variables(cars, list(distance = 3)),
    "lower than the number of columns"
  )

  expect_identical(
    tag_variables(cars, list(distance = 2)),
    tag_variables(cars, list(distance = "dist"))
  )
})
