test_that("tests for prune_tags", {
  x <- make_linelist(cars, age = "speed", date_onset = "dist")

  # Check error messages
  msg <- "Assertion on 'x' failed: Must inherit from class 'linelist', but has class 'data.frame'."
  expect_error(prune_tags(cars), msg)

  x$speed <- NULL
  attr(x, "names") <- "belette" # hack needed as names<- is now safe
  msg <- "The following tags have lost their variable:\n date_onset:dist, age:speed"
  expect_error(prune_tags(x), msg)
  expect_warning(prune_tags(x, "warning"), msg)

  # Check functionality
  y <- prune_tags(x, "none")
  expect_identical(tags_defaults(), tags(y, TRUE))
  expect_true(inherits(y, "linelist"))
})
