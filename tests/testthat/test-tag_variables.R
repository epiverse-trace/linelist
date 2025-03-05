test_that("tag_variables() fails for non-existing variables", {
  msg <- "* Variable 'tag': Must be element of set {'speed','dist'}, but"
  expect_error(
    tag_variables(cars, list(distance = "toto")),
    msg,
    fixed = TRUE
  )

  expect_error(
    tag_variables(cars, list(distance = NA)),
    msg,
    fixed = TRUE
  )
})

test_that("tag_variables() works with specification by variable name", {
  # Check functionality
  x <- tag_variables(cars, list(distance = "dist"))
  expect_identical(attr(x$dist, "label"), "distance")
  expect_identical(attr(x$speed, "label"), NULL)

  x <- tag_variables(x, list(vitesse = "speed"))
  expect_identical(attr(x$dist, "label"), "distance")
  expect_identical(attr(x$speed, "label"), "vitesse")
  # TODO: Improve by checking the entirety at once
  # expect_identical(tags(x), list(distance = "dist", vitesse = "speed"))

  x <- tag_variables(x, list(vitesse = NULL)) # reset to NULL
  expect_identical(attr(x$dist, "label"), "distance")
  expect_identical(attr(x$speed, "label"), NULL)

  # second time should not error
  x <- tag_variables(x, list(vitesse = NULL))
  x <- tag_variables(x, list(distance = NULL))
  expect_identical(attr(x$dist, "label"), NULL)
  expect_identical(attr(x$speed, "label"), NULL)

  # Tag multiple variables at once
  x <- tag_variables(cars, list(distance = "dist", mph = "speed"))
  expect_identical(tags(x), list(mph = "speed", distance = "dist"))
  x <- tag_variables(cars, list(distance = NULL, mph = "speed"))
  expect_identical(tags(x), list(mph = "speed"))
})

test_that("tag_variables() works with specification by position", {
  # Check functionality
  x <- tag_variables(cars, list(distance = 2))
  expect_identical(attr(x$dist, "label"), "distance")
  expect_identical(attr(x$speed, "label"), NULL)

  x <- tag_variables(x, list(vitesse = 1))
  expect_identical(attr(x$dist, "label"), "distance")
  expect_identical(attr(x$speed, "label"), "vitesse")
  # TODO: Improve by checking the entirety at once
  # expect_identical(tags(x), list(distance = "dist", vitesse = "speed"))

  # Test that the column count error functions as expected
  expect_error(
    tag_variables(cars, list(distance = 3)),
    "lower than the number of columns"
  )
})

test_that("resetting tags to NULL", {
  x <- tag_variables(cars, list(vitesse = 1, distance = 2))
  expect_identical(tags(x), list(vitesse = "speed", distance = "dist"))

  x <- tag_variables(x, list(vitesse = NULL))
  expect_null(attr(x$speed, "label"))
})
