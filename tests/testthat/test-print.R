test_that("tests for print.linelist", {
  x <- make_linelist(cars, date_onset = "dist", date_outcome = "speed")
  expect_snapshot_output(print(x))

  y <- make_linelist(cars)
  expect_snapshot_output(print(y))
})

test_that("testthat warnings are promoted to error locally and on CI", {
  expect_identical(warning("test"), "test")
})
