\name{ProcessorCores}
\alias{ProcessorCores}
\title{Manage parallel computation with CPU cores}
\description{
This class provides methods for specifying the processor cores to be used in parallel computation.
\cr
The class cannot be instantiated; you must use the already instantiated object \code{processorCores}.\cr
\cr
R environment provide two main ways in which code can be parallelized, via sockets or via forking.
\cr
The fork-based approach copies the entire current R session and moves it to a new core. This approach works only on Linux and Mac and not on Windows.
\cr
The socket approach launches a new R session on each core. Technically, this connection occurs over a network (as if connecting to a remote server), but in reality the connection takes place on your own computer. The operating system may ask whether to allow R to accept incoming connections; you will need to allow this for the computation to start. This approach is available on all platforms, including Windows; however, it is more complex and slower than the fork method.
\cr
The Julia environment also supports parallel computation. Unlike the R environment, it provides a single type of parallel computation that works very efficiently on all operating systems.
\cr
\code{ProcessorCores} provides two parameters: \code{cores} and \code{BPPARAMCores}.
\code{cores} affects all classes that contain the word "Parallel" in their name.
If Julia is not involved, it indicates how many processes should be forked for computations — that is, the number of parallel executions.
If Julia is involved, it specifies how many processors Julia uses for the computation.
\cr
\code{BPPARAMCores} affects dream function (variancePartition package) computations and specifies the parallel processing parameters.
\cr
Upon initialization, the constructor detects the number of CPU cores and sets the \code{cores} parameter accordingly.
\code{BPPARAMCores} is set equal to \code{cores} when the operation system is Linux or Mac. \code{BPPARAMCores} is set to 1 when the operation system is Windows.
\cr
When the \code{ProcessorCores} package is loaded, an instance of the \code{processorCores} class, named processorCores, is created. This instance can be used globally to manage parallel computation.
\cr
The methods \code{setBPPARAMCores} and \code{set} change the number of cores used for parallel computation.
They must be called before the computation begins.
\cr
\cr
Methods:
\itemize{
  \item \code{set(cores)}: Modifies the private variable \code{cores}.
  \item \code{get()}: Retrieves the value of the private variable \code{cores}.
  \item \code{setBPPARAMCores(cores)}: Modifies the private variable \code{BPPARAMCores}.
  \item \code{getBPPARAMCores()}: Retrieves the value of the private variable \code{BPPARAMCores}.
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
