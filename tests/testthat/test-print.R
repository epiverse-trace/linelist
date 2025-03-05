test_that("tests for print.safeframe", {
  x <- make_safeframe(cars, distance = "dist", mph = "speed")
  expect_snapshot_output(print(x))

  y <- make_safeframe(cars)
  expect_snapshot_output(print(y))
})
