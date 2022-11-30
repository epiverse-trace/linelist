test_that("tests for drop_linelist", {
  x <- make_linelist(cars, age = "speed")
  expect_identical(cars, drop_linelist(x, TRUE))
  y <- drop_linelist(x, FALSE)
  expect_identical(tags(x, TRUE), attr(y, "tags"))
})
