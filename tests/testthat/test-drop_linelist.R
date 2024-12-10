test_that("tests for drop_linelist", {
  x <- make_linelist(cars, speed = "age")
  expect_identical(cars, drop_linelist(x, TRUE))
})
