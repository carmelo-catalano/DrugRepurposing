obj_is_na <- function(x) {
  is.atomic(x) && length(x) == 1 && is.na(x)
}

absolute_package_filename <- function(filename) {
  return(system.file(filename, package = config$package_name))
}

package_readRDS <- function(filename) {
  absolute_filename <- system.file(filename, package = config$package_name)
  return(readRDS(absolute_filename))
}