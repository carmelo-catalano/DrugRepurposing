\name{JuliaSetuper}
\alias{JuliaSetuper}
\title{Initialize the Julia environment for use in R environment}
\description{
Initialize the Julia environment for use in R environment.
To use this function, the Julia environment must be installed on the system.
}
\usage{
BLAS_num_threads = 5
juliaSetuper <- JuliaSetuper$new()
juliaSetuper$setup(BLAS_num_threads)
}
\arguments{
  \item{BLAS_num_threads}{
    Number of threads for parallel computation using the Julia \code{LinearAlgebra.BLAS} module.
    \cr
    If not specified, the value from \code{processorCores$getJuliaCores()} will be used.
    \itemize{
      \item Type: \code{integer}.
      \item Default value: \code{NA}.
    }
  }
}
\value{
NA
}
