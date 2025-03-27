\name{BinChenDiseaseSignatureDrugListConnectivityScoreParallelFacade}
\alias{BinChenDiseaseSignatureDrugListConnectivityScoreParallelFacade}
\title{Parallel Computation of Connectivity Score for Disease and Drugs}
\description{
Facade for \code{BinChenDiseaseSignatureDrugListConnectivityScoreCore} enabling parallel execution on Unix-like systems.
}
\usage{
BinChenDiseaseSignatureDrugListConnectivityScoreParallelFacade$new()
BinChenDiseaseSignatureDrugListConnectivityScoreParallelFacade$compute(disease_signature, drugs, 
random_distribution_size, disease_name, drug_perturbation_time)
}
\arguments{
  \item{Same as BinChenDiseaseSignatureDrugListConnectivityScoreCore.}
  \item{drugSignatureLoader (constructor argument)}{
    Loader for drug DGEs in \code{drugs}.
    \itemize{
      \item Type: class derived from \code{DrugSignatureLoaderAbstract}
      \item Default value: \code{NA}
    }
  }
}
\value{
Same as \code{BinChenDiseaseSignatureDrugListConnectivityScoreCore}.
}
\examples{
binChenDiseaseSignatureDrugListConnectivityScoreParallelFacade <- BinChenDiseaseSignatureDrugListConnectivityScoreParallelFacade$new()
result <- binChenDiseaseSignatureDrugListConnectivityScoreParallelFacade$compute(disease_signature, drugs, 1e4, "IPF", "6h")
print(result)
}
