test_that("tag action is initialized correctly", {

  res <- withr::with_package(
    "linelist",
    get_lost_tags_action()
  )

  expect_identical(res, "warning")

})
