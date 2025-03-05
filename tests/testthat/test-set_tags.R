test_that("tests for set_tags()", {
  x <- make_safeframe(cars, distance = "dist")

  # Check error messages
  msg <- "Must inherit from class 'safeframe', but has class 'data.frame'."
  expect_error(set_tags(cars), msg)

  msg <- "Must be element of set {'speed','dist'}, but is"
  expect_error(set_tags(x, outcome = "toto"), msg, fixed = TRUE)

  # Uses snapshot to prevent formatting issues in validating the error message
  expect_snapshot(set_tags(cars), error = TRUE)

  # Check functionality
  expect_identical(x, set_tags(x))
  x <- set_tags(x, mph = "speed")
  expect_identical(tags(x)$mph, "speed")
  expect_identical(tags(x)$distance, "dist")

  x <- set_tags(x, kmh = "speed", kmdist = "dist")
  y <- set_tags(x, !!!list(kmh = "speed", kmdist = "dist"))
  expect_identical(x, y)
})
