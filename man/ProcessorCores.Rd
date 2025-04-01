\name{ProcessorCores}
\alias{ProcessorCores}
\title{Manage parallel computation with CPU cores}
\description{
This class provides methods for managing parallel computation. Upon initialization, the constructor detects the number of CPU cores and sets the private class variable cores accordingly.
\cr
When the \code{ProcessorCores} package is loaded, an instance of the \code{processorCores} class, named processorCores, is created. This instance can be used globally to manage parallel
\cr
\cr
Methods:
\itemize{
  \item \code{set(cores)}: Modifies the private variable \code{cores}.
  \item \code{get()}: Retrieves the value of the private variable \code{cores}.
  \item \code{initCores(cores = NA)}: Sets up the parallel computation system using \code{registerDoParallel(cores)}.
}
}
\usage{
processorCores$set(2)   # Set the number of cores to 2
processorCores$get()    # Retrieve the number of cores
processorCores$initCores() # Initialize parallel computation
}
\arguments{
  \item{cores}{
    Number of CPU cores to be used.
    \itemize{
      \item Type: \code{integer}.
    }
  }
}
\value{
Returns the value of the private class variable \code{cores} or initializes the parallel computation system.
}
