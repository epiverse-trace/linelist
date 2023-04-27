test_that("deprecating warning for select_tags()", {

  x <- make_linelist(cars, date_onset = "dist", age = "speed")

  expect_snapshot(select_tags(x, "date_onset", "age"))

})

test_that("deprecating warning for select.linelist()", {

  x <- make_linelist(cars, date_onset = "dist", age = "speed")

  expect_snapshot(select(x, tags = c("date_onset", "age")))

})
