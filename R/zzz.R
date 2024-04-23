.onLoad <- function(libname, pkgname) {
  lost_tags_action(Sys.getenv("LINELIST_LOST_ACTION", "warning"), quiet = TRUE)
}
