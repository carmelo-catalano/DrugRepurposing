\name{LINCSLMMDrugDGEByGeneJuliaFactory}
\alias{LINCSLMMDrugDGEByGeneJuliaFactory}
\title{Create an instance of LMMDGEByGene for LMM computation by Julia}
\description{
Create an instance of \code{LMMDGEByGene} for LMM computation by Julia.
\cr
To use this function, the Julia environment must be installed on the system.
}
\usage{
BLAS_num_threads <- 5
lincsLMMDrugDGEByGeneJuliaFactory <- LINCSLMMDrugDGEByGeneJuliaFactory$new()
lincsLMMDrugDGEByGeneJuliaFactory$create(BLAS_num_threads)
}
\arguments{
  \item{BLAS_num_threads}{
    Threads number for parallel computation through Julia \code{LinearAlgebra.BLAS} module.
    \itemize{
      \item Type: \code{integer}.
      \item Default value: \code{4}.
    }
  }
}
\value{
Instance of \code{LMMDGEByGene}.
}
