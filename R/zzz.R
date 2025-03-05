.onLoad <- function(libname, pkgname) {
  lost_tags_action(Sys.getenv("SAFEFRAME_LOST_ACTION", "warning"),
    quiet = TRUE
  )
}
