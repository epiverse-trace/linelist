test_that("tests for select", {
  if (require("dplyr")) {
    x <- make_linelist(cars, date_onset = "dist", date_outcome = "speed")

    # test errors
    msg <- "The following tags have lost their variable:\n date_outcome:speed"
    lost_tags_action("warning", quiet = TRUE)
    expect_warning(select(x, toto = dist, tags = "date_onset"), msg)

    lost_tags_action("error", quiet = TRUE)
    expect_error(select(x, toto = dist, tags = "date_onset"), msg)

    msg <- "The following tags have lost their variable:\n date_onset:dist, date_outcome:speed"
    lost_tags_action("warning", quiet = TRUE)
    expect_warning(select(x, toto = dist), msg)

    lost_tags_action("error", quiet = TRUE)
    expect_error(select(x, toto = dist), msg)


    # test functionalities
    ## basic case
    expect_identical(x, select(x, everything()))
    y <- select(x, everything(), tags = "date_onset")
    expect_identical(names(y), c("speed", "dist", "date_onset"))
    expect_identical(y$dist, y$date_onset)
    expect_identical(
      list(date_onset = "date_onset", date_outcome = "speed"),
      tags(y)
    )

    ## case where some tags are dropped
    lost_tags_action("none", quiet = TRUE)
    y <- select(x, dist, tags = "date_onset")
    expect_identical(names(y), c("dist", "date_onset"))
    expect_identical(tags(y), list(date_onset = "date_onset"))

    ## same, with renaming of tags
    y <- select(x, dist, tags = c(onset = "date_onset"))
    expect_identical(names(y), c("dist", "onset"))
    expect_identical(tags(y), list(date_onset = "onset"))

    ## selecting tags only
    expect_identical(
      drop_linelist(select(x, tags = names(tags(x))), TRUE),
      tags_df(x)
    )

    ## check that tibble class is preserved
    x <- make_linelist(tibble(cars), date_onset = "dist", date_outcome = "speed")
    expect_true(inherits(select(x, 1, tags = "date_onset"), "tbl_df"))
  }
})
