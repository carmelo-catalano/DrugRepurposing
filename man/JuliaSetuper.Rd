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
    Threads number for parallel computation through Julia LinearAlgebra.BLAS module.
    \itemize{
      \item Type: \code{integer}.
      \item Default value: \code{4}.
    }
  }
}
\value{
NA
}
