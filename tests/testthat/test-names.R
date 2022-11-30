test_that("tests for the names<- operator", {
  x <- make_linelist(cars, id = "speed", age = "dist")
  old_x <- x
  old_class <- class(x)
  old_names <- names(x)

  # errors
  msg <- "Suggested naming would result in `NA` for some column names.\nDid you provide less names than columns targetted for renaming?"
  expect_error(names(x) <- "toto", msg)

  # functionalities
  names(x) <- c("titi", "toto")
  expect_identical(names(x), c("titi", "toto"))
  expect_identical(tags(x), list(id = "titi", age = "toto"))
  expect_identical(class(x), old_class)
  names(x) <- old_names
  expect_identical(x, old_x)
})
