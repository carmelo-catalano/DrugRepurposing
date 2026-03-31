\name{LINCSLMMDrugDGEByGeneJuliaFactory}
\alias{LINCSLMMDrugDGEByGeneJuliaFactory}
\title{Create an instance of LMMDGEByGene for LMM computation by Julia}
\description{
Create an instance of \code{\link{LMMDGEByGene}} for LMM computation by Julia.
\cr
To use this class, the Julia environment must be installed on the system.
}
\usage{
BLAS_num_threads <- 5
LMMFormula <- gene_expression ~ pert_iname + (1 | cell_id)
lincsLMMDrugDGEByGeneJuliaFactory <- LINCSLMMDrugDGEByGeneJuliaFactory$new()
lincsLMMDrugDGEByGeneJuliaFactory$create(BLAS_num_threads, LMMFormula)
}
\arguments{
  \item{BLAS_num_threads}{
    Threads number for parallel computation through Julia \code{LinearAlgebra.BLAS} module.
    \cr
    If not specified, the value from \code{processorCores$getJuliaCores()} will be used.
    \itemize{
      \item Type: \code{integer}.
      \item Default value: \code{NA}.
    }
  }
  \item{LMMFormula}{
    Formula for LMM computation
    \itemize{
      \item Type: \code{formula}.
      \item Default value: \code{gene_expression ~ pert_iname + (1 | cell_id) + (1 | rna_plate)}.
    }
  }
}
\value{
Instance of \code{LMMDGEByGene}.
}
