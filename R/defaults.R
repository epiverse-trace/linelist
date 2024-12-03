#' Update or append to a vector
#'
#' Internal function. Helper to assist in updating the default vectors.
#'
#' @param x origin vector
#' @param ... (named) list of values to update or append. `hcw = "hacw"` will
#' update the origin vector if `hcw` exists, otherwise append it. If there is
#' no expected equivalent in the origin, write `"newVar1", "newVar2"`
#'
#' @return vector
#'
#' @keywords internal
#'
update_or_append <- function(x, ...) {
  lst <- rlang::dots_list(..., .named = TRUE)

  for (i in seq(lst)) {
    value <- lst[[names(lst)[i]]]
    if (names(lst)[i] %in% x) {
      # Update the value if the name is present in x
      x[names(lst)[i] == x] <- value
    } else {
      # Append the value if the name is not present in x
      x <- c(x, value)
    }
  }

  x
}

#' Default labels for a linelist
#'
#' @param ... A series of labels provided as `"label1", "label2"` to add
#' labels or optionally `"id" = "new_id"` to rename defaults
#'
#' @return vector of labels
#' @export
#'
default_labels <- function(...) {
  defaults <- c(
    "id",
    "date_onset",
    "date_reporting",
    "date_admission",
    "date_discharge",
    "date_outcome",
    "date_death",
    "gender",
    "age",
    "location",
    "occupation",
    "hcw",
    "outcome"
  )
  
  update_or_append(defaults, ...)
}
