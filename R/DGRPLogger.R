dgrp_logger_modes <- list()
dgrp_logger_modes$CONSOLE <- "CONSOLE"
dgrp_logger_modes$FILE <- "FILE"

DGRPLogger <- R6Class(
  "DGRPLogger",
  public = list(
    initialize = function() {
      private$console_logger <- logger(threshold = "DEBUG")
    },
    log = function(message) {
      if (!obj_is_na(private$console_logger))
        info(private$console_logger, message)
      if (!obj_is_na(private$file_logger))
        info(private$file_logger, message)
    },
    config = function(mode, log_file_name = NA) {
      if (dgrp_logger_modes$FILE %in% mode & obj_is_na(log_file_name)) {
        stop("logger mode is \"FILE\" field \"log_file_name\" must be specified")
      }

      if (dgrp_logger_modes$CONSOLE %in% mode)
        private$console_logger <- logger(threshold = "DEBUG")
      else
        private$console_logger <- NA

      if (dgrp_logger_modes$FILE %in% mode)
        private$file_logger <- logger(threshold = "DEBUG", appenders = file_appender(log_file_name))
      else
        private$file_logger <- NA

      return(NA)
    }
  ),
  private = list(
    console_logger = NA,
    file_logger = NA
  )
)

dgrpLogger <- DGRPLogger$new();