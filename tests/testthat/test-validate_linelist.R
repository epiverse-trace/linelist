test_that("tests for validate_linelist", {

  # errors
  msg <- "Must inherit from class 'linelist', but has class 'NULL'."
  expect_error(validate_linelist(NULL), msg)

  x <- make_linelist(cars, id = "speed", toto = "dist", allow_extra = TRUE)
  msg <- "The following tags are not part of the defaults:\ntoto\nConsider using `allow_extra = TRUE` to allow additional tags."
  expect_error(validate_linelist(x), msg)

  x <- make_linelist(cars, gender = "speed")
  msg <- "Issue when checking class of tag `gender`:\nMust inherit from class 'character'/'factor', but has class 'numeric'"
  expect_error(validate_linelist(x), msg)

  # Functionalities
  x <- make_linelist(cars)
  expect_identical(x, validate_linelist(x))
})
