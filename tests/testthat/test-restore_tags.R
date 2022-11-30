test_that("tests for restore_tags", {
  x <- make_linelist(cars, age = "speed", date_onset = "dist")
  y <- drop_linelist(x)
  z <- y
  names(z) <- c("titi", "toto")

  # Check error messages
  msg <- "The following tags have lost their variable:\n date_onset:dist, age:speed"
  expect_error(restore_tags(z, tags(x), "error"), msg)
  expect_warning(restore_tags(z, tags(x), "warning"), msg)

  # Check functionality
  expect_identical(x, restore_tags(x, tags(x)))
  expect_identical(x, restore_tags(y, tags(x)))
})
