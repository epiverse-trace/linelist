test_that("tests for print.linelist", {
  x <- make_linelist(cars, date_onset = "dist", date_outcome = "speed")
  expect_snapshot_output(print(x))

  y <- make_linelist(cars)
  expect_snapshot_output(print(y))
})
