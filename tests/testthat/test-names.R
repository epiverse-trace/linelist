test_that("tests for the names<- operator", {
  x <- make_linelist(cars, id = "speed", age = "dist")
  old_x <- x
  old_class <- class(x)
  old_names <- names(x)

  # errors
  msg <- paste(
    "Suggested naming would result in `NA` for some column names.",
    "Did you provide less names than columns targetted for renaming?",
    sep = "\n"
  )
  expect_error(names(x) <- "toto", msg)

  # functionalities
  names(x) <- c("titi", "toto")
  expect_named(x, c("titi", "toto"))
  expect_identical(tags(x), list(id = "titi", age = "toto"))
  expect_s3_class(x, old_class)
  names(x) <- old_names
  expect_identical(x, old_x)
})
