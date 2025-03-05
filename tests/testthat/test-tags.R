test_that("tests tags", {
  # Check error messages
  x <- make_safeframe(cars, age = "speed")

  # Check functionality
  expect_identical(tags(x), list(age = "speed"))

  # tags() returns an empty named list, which we cannot compare to list()
  # directly.
  expect_identical(length(tags(make_safeframe(cars))), length(list()))
})

test_that("tags() deprecation warnings", {
  x <- make_safeframe(cars, age = "speed")

  msg <- "The 'show_null' argument is deprecated and is no longer functional."
  expect_warning(tags(x, show_null = TRUE), msg)
})

test_that("no tags returns empty list", {
  x <- make_safeframe(cars)
  expect_identical(tags(x), list())
})
