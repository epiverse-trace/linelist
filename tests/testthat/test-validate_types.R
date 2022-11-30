test_that("tests for validate_types", {

  # test errors
  msg <- "Must inherit from class 'linelist', but has class 'data.frame'."
  expect_error(validate_types(cars), msg)

  x <- make_linelist(cars, age = "speed")
  msg <- paste(
    "Issue when checking class of tag `age`:",
    "Must inherit from class 'factor', but has class 'numeric'",
    sep = "\n"
  )
  expect_error(validate_types(x, ref_types = tags_types(age = "factor")), msg)

  x <- make_linelist(cars, age = "speed", gender = "dist")
  msg <- paste(
    "Issue when checking class of tag `gender`:",
    "Must inherit from class 'character'/'factor', but has class 'numeric'",
    sep = "\n"
  )
  expect_error(validate_types(x), msg)

  # test functionalities
  x <- make_linelist(cars, age = "speed")
  expect_identical(x, validate_types(x))

  x <- make_linelist(cars, age = "speed", outcome = "dist")
  expect_identical(
    x,
    validate_types(x, ref_types = tags_types(outcome = "numeric"))
  )
})
