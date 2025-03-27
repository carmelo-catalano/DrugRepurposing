\name{BinChenDiseaseSignatureDrugListConnectivityScoreSyncFacade}
\alias{BinChenDiseaseSignatureDrugListConnectivityScoreSyncFacade}
\title{Synchronous Computation of Connectivity Score for Disease and Drugs}
\description{
Facade for \code{BinChenDiseaseSignatureDrugListConnectivityScoreCore} enabling synchronous execution.
This class uses the synchronous implementations of \code{RandomConnectivityScoreDistributionAbstract} and \code{BinChenConnectivityScoreListApplyerAbstract}.
It is identical to \code{BinChenDiseaseSignatureDrugListConnectivityScoreParallelFacade}, except for the computation type.
}
\usage{
BinChenDiseaseSignatureDrugListConnectivityScoreSyncFacade$new()
BinChenDiseaseSignatureDrugListConnectivityScoreSyncFacade$compute(disease_signature, drugs, 
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
binChenDiseaseSignatureDrugListConnectivityScoreSyncFacade <- BinChenDiseaseSignatureDrugListConnectivityScoreSyncFacade$new()
result <- binChenDiseaseSignatureDrugListConnectivityScoreSyncFacade$compute(disease_signature, drugs, 1e4, "IPF", "6h")
print(result)
}
