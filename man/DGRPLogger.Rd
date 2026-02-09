\name{DGRPLogger}
\alias{DGRPLogger}
\title{Logger}
\description{
DGRPLogger provides a logging system based on log4r.\cr
The class cannot be instantiated; you must use the already instantiated object \code{dgrpLogger}.\cr
\code{dgrpLogger} has two methods: \code{config} and \code{log}.\cr
\cr
\bold{\code{dgrpLogger$config}}\cr
The \code{config} method allows you to change the logging behavior, there are three modes:\cr
\bold{CONSOLE}: prints logs to the screen (default).\cr
\bold{FILE}: writes logs to a file. \cr
\bold{CONSOLE and FILE}: both prints to the screen and writes to a file.\cr
Many functions in DrugRepurposing log information through \code{dgrpLogger} instance and follow the behavior configured via \code{dgrpLogger$config}\cr
\cr
\bold{\code{dgrpLogger$log}}\cr
\code{dgrpLogger$log} prints log messages.
}
\usage{
dgrpLogger$log("Hello world")
# output: INFO  [2026-01-29 13:31:15] Hello world
}
\arguments{
  \item{mode (config method)}{
    Logger mode, allowed values are: dgrp_logger_modes$CONSOLE, dgrp_logger_modes$FILE, c(dgrp_logger_modes$CONSOLE,dgrp_logger_modes$FILE)
    \itemize{
      \item Type: \code{vector}.
    }
  }
  \item{log_file_name (config method)}{
    Name of the file used to store the logs; ignored in CONSOLE mode.
    \itemize{
      \item Type: \code{string}.
      \item Default value: \code{NA}.
    }
  }
  \item{message (log method)}{
    Message to log..
    \itemize{
      \item Type: \code{boolean}.
    }
  }
}
\value{
The methods of this class do not return any value.
}
\examples{
 # using default configuration
 dgrpLogger$log("Hello world")

 # print logs to the screen and write them to the file "log.txt"
 dgrpLogger$config(c(dgrp_logger_modes$CONSOLE, dgrp_logger_modes$FILE),"log.txt")
}
