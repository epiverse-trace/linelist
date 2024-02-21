test_that("deprecating warning for select_tags()", {

  x <- make_linelist(cars, date_onset = "dist", age = "speed")

  expect_snapshot(select_tags(x, "date_onset", "age"))

})

test_that("deprecating warning for select.linelist()", {

  x <- make_linelist(cars, date_onset = "dist", age = "speed")

  expect_snapshot(select(x, tags = c("date_onset", "age")))

})

test_that("deprecating warning for make_linelist(x, list())", {

  expect_snapshot(make_linelist(cars, list(date_onset = "dist", age = "speed")))

})

test_that("deprecating warning for list in set_tags()", {

  x <- make_linelist(cars, date_onset = "dist", age = "speed")

  expect_snapshot(set_tags(x, list(date_onset = "dist", age = "speed")))

})
