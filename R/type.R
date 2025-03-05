#' Type Selection Helper
#'
#' Function to swiftly provide access to generic categories of types within R.
#' These can be used to provide comprehensive typesetting when creating a
#' `safeframe` object.
#'
#' @param x Character indicating the desired type. Options include `date`,
#' `category`, `numeric`, `binary` at this time.
#'
#' @return A vector of classes
#' @export
#'
#' @examples
#' x <- make_safeframe(cars,
#'   mph = "speed",
#'   distance = "dist"
#' )
#'
#' validate_types(
#'   x,
#'   mph = type("numeric"),
#'   distance = "numeric"
#' )
#'
type <- function(x) {
  # ensure case insensitivity
  x <- tolower(x)

  checkmate::assert_string(x)
  checkmate::assert_choice(x,
    choices = c("date", "category", "numeric", "binary")
  )

  switch(x,
    date = c("integer", "numeric", "Date", "POSIXct", "POSIXlt"),
    category = c("character", "factor"),
    numeric = c("numeric", "integer"),
    binary = c("logical", "integer", "character", "factor")
  )
}
