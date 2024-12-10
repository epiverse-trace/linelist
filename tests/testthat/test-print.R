test_that("tests for print.linelist", {
  x <- make_linelist(cars, dist = "date_onset", speed = "date_outcome")
  expect_snapshot_output(print(x))

  y <- make_linelist(cars)
  expect_snapshot_output(print(y))
})
