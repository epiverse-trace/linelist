test_that("tests for [ operator", {
  x <- make_linelist(cars, id = "speed", age = "dist")

  # errors
  lost_tags_action("warning", quiet = TRUE)
  msg <- "The following tags have lost their variable:\n age:dist"
  expect_warning(x[, 1], msg)

  lost_tags_action("error", quiet = TRUE)
  msg <- "The following tags have lost their variable:\n age:dist"
  expect_error(x[, 1], msg)

  lost_tags_action("warning", quiet = TRUE)
  msg <- "The following tags have lost their variable:\n id:speed, age:dist"
  expect_warning(x[, NULL], msg)

  # functionalities
  expect_identical(x, x[])
  expect_identical(x, x[, ])
  expect_null(ncol(x[, 1, drop = TRUE]))
  expect_identical(x[, 1, drop = TRUE], cars[, 1])

  lost_tags_action("none", quiet = TRUE)
  expect_identical(x[, 1], make_linelist(cars[, 1, drop = FALSE], id = "speed"))
})



test_that("tests for [<- operator", {

  # errors
  lost_tags_action("warning", quiet = TRUE)
  x <- make_linelist(cars, id = "speed", age = "dist")
  msg <- "The following tags have lost their variable:\n id:speed"
  expect_warning(x[, 1] <- NULL, msg)

  lost_tags_action("error", quiet = TRUE)
  x <- make_linelist(cars, id = "speed", age = "dist")
  msg <- "The following tags have lost their variable:\n id:speed"
  expect_error(x[, 1] <- NULL, msg)

  # functionalities
  x[1:3, 1] <- 1L
  expect_identical(x$speed[1:3], rep(1, 3))

  lost_tags_action("none", quiet = TRUE)
  x <- make_linelist(cars, id = "speed", age = "dist")
  x[, 1:2] <- NULL
  expect_identical(ncol(x), 0L)
})






test_that("tests for [[<- operator", {

  # errors
  lost_tags_action("warning", quiet = TRUE)
  x <- make_linelist(cars, id = "speed", age = "dist")
  msg <- "The following tags have lost their variable:\n id:speed"
  expect_warning(x[[1]] <- NULL, msg)

  lost_tags_action("error", quiet = TRUE)
  x <- make_linelist(cars, id = "speed", age = "dist")
  msg <- "The following tags have lost their variable:\n id:speed"
  expect_error(x[[1]] <- NULL, msg)

  # functionalities
  x[[1]] <- 1L
  expect_identical(x$speed, rep(1L, nrow(x)))

  lost_tags_action("none", quiet = TRUE)
  x <- make_linelist(cars, id = "speed", age = "dist")
  x[[2]] <- NULL
  x[[1]] <- NULL
  expect_identical(ncol(x), 0L)
})
