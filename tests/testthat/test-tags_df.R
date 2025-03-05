test_that("tests for tags_df without untagged variables", {
  # These are now order dependent for the tests
  x <- make_safeframe(cars,
    mph = "speed",
    distance = "dist"
  )
  y <- cars[c("speed", "dist")]
  names(y) <- c("mph", "distance")

  # errors
  msg <- "Must inherit from class 'safeframe', but has class 'data.frame'."
  expect_error(tags_df(cars), msg)

  # functionality
  expect_identical(tags_df(x), y)
})


test_that("tags_df with untagged variables works as expected", {
  x <- make_safeframe(cars,
    distance = "dist"
  )
  y <- cars[c("speed", "dist")]
  names(y) <- c("speed", "distance")

  expect_identical(tags_df(x), y)
})
