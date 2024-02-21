test_that("tests for prune_tags", {
  x <- make_linelist(cars, age = "speed", date_onset = "dist")

  # Check error messages
  msg <- "Must inherit from class 'linelist', but has class 'data.frame'."
  expect_error(prune_tags(cars), msg)

  attr(x, "names") <- c("new1", "new2") # hack needed as names<- is now safe
  msg <- paste(
    "The following tags have lost their variable:",
    " date_onset:dist, age:speed",
    sep = "\n"
  )
  expect_error(prune_tags(x), msg, class = "linelist_error")
  expect_warning(prune_tags(x, "warning"), msg, class = "linelist_warning")

  # Check functionality
  y <- prune_tags(x, "none")
  expect_identical(tags_defaults(), tags(y, TRUE))
  expect_s3_class(y, "linelist")
})

test_that("prune_tags() doesn't error on a linelist with extra tags", {
  # https://github.com/epiverse-trace/linelist/issues/63

  dat <- data.frame(a = 1)
  ll <- make_linelist(dat, a = "a", allow_extra = TRUE)

  expect_no_condition(ll["a"])
  expect_identical(ll, ll["a"])

})
