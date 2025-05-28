# This helper ensures the package does not modify the session global state. As
# per CRAN policy, packages should not interfere with the user's session state.
# If global settings need to be modified, they should be restored to their
# original values on exit. This can be achieved with the `on.exit()` base
# function, or more conveniently with the `withr` package.
# We add a test on R >= 4.0.0 because some functions such as
# `globalCallingHandlers()` did not exist before.
get_pars_toreset <- function() {
  pars <- par(no.readonly = TRUE)
  # The following params are set and modified automatically by plot(), as
  # documented in ?plot.window() and we:
  # 1. have no control over them
  # 2. do not care about resetting them
  pars <- pars[!names(pars) %in% c("usr", "xaxp", "yaxp")]
}

if (getRversion() >= "4.0.0") {
  testthat::set_state_inspector(function() {
    list(
      attached    = search(),
      connections = getAllConnections(),
      cwd         = getwd(),
      envvars     = Sys.getenv(),
      handlers    = globalCallingHandlers(),
      libpaths    = .libPaths(),
      locale      = Sys.getlocale(),
      options     = options(),
      par         = get_pars_toreset(),
      packages    = .packages(all.available = TRUE),
      sink        = sink.number(),
      timezone    = Sys.timezone(),
      NULL
    )
  })
}
