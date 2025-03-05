test_that("tests for restore_tags", {
  # These are now order dependent for the tests
  x <- make_safeframe(cars, mph = "speed", distance = "dist")
  y <- drop_safeframe(x)
  z <- y
  names(z) <- c("titi", "toto")

  # # Check error messages
  expect_error(
    restore_tags(z, tags(x)),
    "No matching tags provided."
  )

  # Check functionality
  expect_identical(x, restore_tags(x, tags(x)))
  expect_identical(x, restore_tags(y, tags(x)))

  # Classes are correct for different operator use
  expect_equal(class(x), c("safeframe", "data.frame"))
  y <- restore_tags(y, tags(x))
  expect_equal(class(y), c("safeframe", "data.frame"))
  x[[1]] <- "test"
  expect_equal(class(x), c("safeframe", "data.frame"))
  x[1] <- "test2"
  expect_equal(class(x), c("safeframe", "data.frame"))
  x$speed <- "test3"
  expect_equal(class(x), c("safeframe", "data.frame"))
})
