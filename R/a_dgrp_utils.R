obj_is_na <- function(x) {
  return(is.atomic(x) && length(x) == 1 && is.na(x))
}

obj_is_na_or_NULL <- function(x) {
  return(obj_is_na(x) || is.null(x))
}

is.integer <- function(x) {
  return(is.numeric(x) && x %% 1 == 0)
}

is.boolean <- function(x) {
  return(is.atomic(x) &&
           !is.na(x) &&
           !is.null(x) &&
           (x == TRUE || x == FALSE))
}

absolute_package_filename <- function(filename) {
  return(system.file(filename, package = config$package_name))
}

develop_package_path <- function() {
  path <- getwd()
  if (grepl("/tests/testthat", path, fixed = TRUE)) {
    return(gsub("/tests/testthat", "", path, fixed = TRUE))
  }else {
    return(path)
  }
}

absolute_path_filename <- function(filename) {
  return(paste0(develop_package_path(), "/", filename))
}

absolute_package_directory <- function(directory) {
  return(paste0(system.file(directory, package = config$package_name), "/"))
}

absolute_path_directory <- function(directory) {
  return(paste0(develop_package_path(), "/", directory))
}

package_readRDS <- function(filename) {
  absolute_filename <- system.file(filename, package = config$package_name)
  return(readRDS(absolute_filename))
}

absolute_path_readRDS <- function(filename) {
  absolute_filename <- paste0(develop_package_path(), "/", filename)
  return(readRDS(absolute_filename))
}

set_dependent_variable <- function(formula, dependent_variable_name) {
  formula_blocks <- strsplit(format(formula), split = "~")
  str_formula_with_dependent_variable <- paste0(dependent_variable_name, " ~ ", formula_blocks[[1]][2])
  return(as.formula(str_formula_with_dependent_variable, env = parent.frame()))
}

add_slash_to_directory_path <- function(path) {
  if (substring(path, nchar(path)) != "/") {
    path <- paste0(path, "/")
  }
  return(path)
}
