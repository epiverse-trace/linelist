test_that("tests for validate_type", {
  # Check functionality
  msg <- paste(
    "Must inherit from class 'numeric'/'integer'/'character',",
    "but has class 'factor'"
  )
  expect_identical(validate_type(factor(letters), "id"), msg)

  msg <- "Must inherit from class 'DNAbin', but has class 'character'"
  expect_identical(
    validate_type(
      c("a", "t"),
      "sequence",
      tags_types(
        sequence = "DNAbin",
        allow_extra = TRUE
      )
    ),
    msg
  )

  expect_true(validate_type(letters, "id"))

  x <- validate_type(
    factor(letters), "id",
    tags_types(id = c("character", "factor", "numeric"))
  )
  expect_true(x)
})
