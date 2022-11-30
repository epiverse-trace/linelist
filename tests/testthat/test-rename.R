test_that("tests for rename", {
  if (require("dplyr")) {
    x <- make_linelist(cars, date_onset = "dist", date_outcome = "speed")

    # test functionalities
    expect_identical(x, rename(x))
    expect_identical(
      tags(rename(x, toto = dist)),
      list(date_onset = "toto", date_outcome = "speed")
    )

    new_x <- rename(x, toto = dist, titi = speed)
    new_x <- rename(new_x, dist = toto, speed = titi)
    expect_identical(x, new_x)
  }
})
