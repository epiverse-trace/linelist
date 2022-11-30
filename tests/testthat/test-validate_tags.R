test_that("tests for validate_tags", {

  # test errors
  msg <- "Must inherit from class 'linelist', but has class 'data.frame'."
  expect_error(validate_tags(cars), msg)

  x <- make_linelist(cars)
  attr(x, "tags") <- NULL
  msg <- "`x` has no tags attribute"
  expect_error(validate_tags(x), msg)

  attr(x, "tags") <- tags_defaults()[-(1:3)]
  msg <- paste(
    "The following default tags are missing:",
    "id, date_onset, date_reporting",
    sep = "\n"
  )
  expect_error(validate_tags(x), msg)

  attr(x, "tags") <- c(tags_defaults(), toto = "ilestbo")
  msg <- paste(
    "The following tags are not part of the defaults:\ntoto",
    "Consider using `allow_extra = TRUE` to allow additional tags.",
    sep = "\n"
  )
  expect_error(validate_tags(x), msg)

  attr(x, "tags") <- c(tags_defaults(), toto = "ilestbo")
  msg <- "The following tagged variables are missing:\ntoto:ilestbo"
  expect_error(validate_tags(x, TRUE), msg)

  tags <- tags_defaults()
  tags[[2]] <- 1L
  attr(x, "tags") <- tags
  msg <- paste0(
    "May only contain the following types: \\{character,null\\}, ",
    "but element 2 has type 'integer'."
  )
  expect_error(validate_tags(x), msg)

  msg <- ""
  expect_error(validate_tags(x), msg)

  # functionalities
  x <- make_linelist(cars)
  expect_identical(x, validate_tags(x))

  x <- set_tags(x, date_onset = "dist", toto = "speed", allow_extra = TRUE)
  expect_identical(x, validate_tags(x, allow_extra = TRUE))
})
