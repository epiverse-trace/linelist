skip_if_not_installed("dplyr")

x <- make_safeframe(cars, mph = "speed", distance = "dist")

# Rows ----

test_that("Compatibility with dplyr::arrange()", {
  ordered_x <- expect_no_warning(dplyr::arrange(x, dist))

  expect_s3_class(ordered_x, "safeframe")
  expect_identical(
    drop_safeframe(ordered_x),
    dplyr::arrange(cars, dist)
  )
})

test_that("Compatibility with dplyr::distinct()", {
  expect_identical(
    x[1:10, ],
    dplyr::distinct(x[1:10, ])
  )
})

test_that("Compatibility with dplyr::filter()", {
  # nolint start: expect_named_linter
  expect_identical(
    names(dplyr::filter(x, dist > mean(dist))),
    names(x)
  )
  # nolint end: expect_named_linter

  expect_identical(
    tags(dplyr::filter(x, dist > mean(dist))),
    tags(x)
  )
})

test_that("Compatibility with dplyr::slice()", {
  x %>%
    dplyr::slice(5:10) %>%
    expect_s3_class("safeframe") %>%
    dim() %>%
    expect_identical(c(6L, ncol(x)))
})

# Columns ----

test_that("Compatibility with dplyr::transmute()", {
  x %>%
    dplyr::transmute(vitesse = speed) %>%
    expect_s3_class("safeframe") %>%
    expect_snapshot_warning()
})

test_that("Compatibility with dplyr::mutate(.keep)", {
  # This is not ideal because this simple mutate() is actually equivalent to a
  # rename() and it would be great if dplyr could pick this up and modify the
  # tags as it does in the rename() case.
  x %>%
    dplyr::mutate(vitesse = speed, .keep = "unused") %>%
    expect_s3_class("safeframe") %>%
    expect_snapshot_warning()
})

# mutate across
test_that("compatibility with dplyr::mutate across", {
  x |>
    dplyr::mutate(dplyr::across(dist, ~ . * 10)) |>
    tags() |>
    expect_identical(tags(x))
})


test_that("Compatibility with dplyr::relocate()", {
  expect_mapequal(
    x,
    dplyr::relocate(x, 2)
  )

  # Identity
  expect_identical(x, dplyr::relocate(x))

  # Round-trip
  new_x <- x %>%
    dplyr::relocate(2) %>%
    dplyr::relocate(2)

  expect_identical(
    x,
    new_x
  )
})

test_that("Compatibility with dplyr::rename()", {
  expect_identical(
    tags(dplyr::rename(x, toto = dist)),
    list(mph = "speed", distance = "toto")
  )

  # Identity
  expect_identical(x, dplyr::rename(x))

  # Round-trip
  new_x <- x %>%
    dplyr::rename(toto = dist, titi = speed) %>%
    dplyr::rename(dist = toto, speed = titi)

  expect_identical(x, new_x)
})

test_that("Compatibility with dplyr::rename_with()", {
  y <- x
  names(y) <- toupper(names(y))
  expect_identical(
    tags(dplyr::rename_with(x, toupper)),
    tags(y)
  )

  # Identity
  expect_identical(x, dplyr::rename_with(x, identity))

  # Round-trip
  new_x <- x %>%
    dplyr::rename_with(toupper) %>%
    dplyr::rename_with(tolower)

  expect_identical(x, new_x)
})

test_that("Compatibility with dplyr::select()", {
  x %>%
    dplyr::select("dist") %>%
    expect_s3_class("safeframe") %>%
    tags() %>%
    expect_identical(list(distance = "dist")) %>%
    expect_snapshot_warning()

  # Even when renames happen
  x %>%
    dplyr::select(dist, vitesse = speed) %>%
    expect_s3_class("safeframe") %>%
    tags() %>%
    expect_identical(list(
      distance = "dist",
      mph = "vitesse"
    ))
})

# Data.frames ----

test_that("Compatibility with dplyr::bind_rows()", {
  rbound_x <- dplyr::bind_rows(x, x)

  expect_s3_class(
    x,
    "safeframe"
  )
})
