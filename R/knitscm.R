#' Create a new Scheme subprocess
#'
#' @param ... params
#' @export
run_scheme <- function(...) {
  start_repl(...)
}

#' Create a new Gauche subprocess
#'
#' @param command path to gosh command
#' @param arguments optional arguments
#' @export
run_gauche <- function(command = Sys.which("gosh"), arguments = "-i") {
  start_repl(command, arguments)
}

#' Kill a Scheme subprocess
#'
#' @param handle handle
#' @export
kill_scheme <- function(handle) {
  subprocess::process_kill(handle)
}

start_repl <- function(...) {
  handle <- subprocess::spawn_process(...)
  Sys.sleep(1)
  # discard a prompt
  subprocess::process_read(handle, subprocess::PIPE_STDOUT)
  handle
}

scheme_engine <- function(options) {
  if (!options$eval) return(knitr::engine_output(options, options$code, ""))

  subprocess::process_write(options$handle, paste(options$code, collapse = "\n"))
  # FIXME
  if (length(options$code) > 1) Sys.sleep(0.1)
  res <- subprocess::process_read(options$handle, subprocess::PIPE_STDOUT, timeout = subprocess::TIMEOUT_INFINITE)
  options$comment <- ";;"
  knitr::engine_output(options, options$code, head(res, -1))
}

.onLoad <- function(lib, pkg) {
  knitr::knit_engines$set(scm = scheme_engine)
}
