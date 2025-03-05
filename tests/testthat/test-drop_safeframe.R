test_that("tests for drop_safeframe", {
  x <- make_safeframe(cars, mph = "speed")
  expect_identical(cars, drop_safeframe(x, remove_tags = TRUE))

  y <- drop_safeframe(x, remove_tags = FALSE)
  expect_identical(tags(x), tags(y))

  y <- drop_safeframe(x, remove_tags = TRUE)
  expect_null(attr(y$speed, "label"))
  expect_null(attr(y$dist, "label"))
})
