skip_if_not_installed("callr")

test_that("tests for zzz", {
  # We need to use callr to avoid conflicts with other tests
  res <- callr::r(
    function() {
      library(safeframe)
      get_lost_tags_action()
    }
  )
  expect_identical(res, "warning")
})

test_that("Environment variable is used for initial `lost_tags_action`", {
  # We need to use callr to avoid conflicts with other tests
  res <- callr::r(
    function() {
      library(safeframe)
      get_lost_tags_action()
    },
    env = c(SAFEFRAME_LOST_ACTION = "error")
  )
  expect_identical(res, "error")
})
