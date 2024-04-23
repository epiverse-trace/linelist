.onLoad <- function(libname, pkgname) {
  lost_tags_action(Sys.setenv("LINELIST_LOST_ACTION", "warning"), quiet = TRUE)
}
