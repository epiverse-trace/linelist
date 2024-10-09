.onLoad <- function(libname, pkgname) {
  lost_labels_action(Sys.getenv("LINELIST_LOST_ACTION", "warning"), quiet = TRUE)
}
