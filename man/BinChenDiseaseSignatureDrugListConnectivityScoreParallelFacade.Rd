\name{BinChenDiseaseSignatureDrugListConnectivityScoreParallelFacade}
\alias{BinChenDiseaseSignatureDrugListConnectivityScoreParallelFacade}
\title{Facade for BinChenDiseaseSignatureDrugListConnectivityScoreCore using parallel computation}
\description{
Computes the connectivity score between a disease signature (see \link{Gene-expression-signature}) and a list of drug DGEs (see \link{DGE}).
\cr
Facade for \code{\link{BinChenDiseaseSignatureDrugListConnectivityScoreCore}}. It creates an instance
of \code{BinChenDiseaseSignatureDrugListConnectivityScoreCore} using the parallel
implementations of \code{\link{RandomConnectivityScoreDistributionAbstract}} and
\code{\link{BinChenConnectivityScoreListApplyerAbstract}}.
\cr
The parallel implementations used are: \code{RandomConnectivityScoreDistributionParallel} and \code{BinChenConnectivityScoreListApplyerParallel}.
\cr
This class is identical to \code{BinChenDiseaseSignatureDrugListConnectivityScoreSyncFacade}, except for the computation type.
\cr
Due to R architecture, it works only on Unix-like systems.
}
\usage{
BinChenDiseaseSignatureDrugListConnectivityScoreParallelFacade$new()
BinChenDiseaseSignatureDrugListConnectivityScoreParallelFacade$compute(disease_signature, drugs,
random_distribution_size, disease_name, drug_perturbation_time)
}
\arguments{
  \item{disease_signature}{
    A table containing the disease signature, defined as in \link{Gene-expression-signature}
    \itemize{
      \item Type: \code{data.frame}.
      \item Columns: \code{gene_id}, \code{estimate}.
    }
  }
  \item{drug_signatures}{
    A table (data.frame) containing drug signatures.
    It must contain two columns:
    \itemize{
        \item \code{name}: The name of the drug.
        \item \code{signature_reference}: Either a data.frame containing the \link{Gene-expression-signature}, or a reference (e.g., a filename) used by the signature loader class to retrieve the data.
    }
    \itemize{
      \item Type: \code{data.frame}
      \item Columns: \code{name} (drug name), \code{signature_reference}
    }
  }
  \item{n_drug_signatures_genes}{
    Total number of genes in the drug signature. This value is required for computing the random distribution used for p-value estimation.\cr
    See \code{\link{RandomConnectivityScoreDistributionAbstract}} for additional details on the random distribution.
    \itemize{
      \item Type: \code{integer}.
    }
  }
  \item{random_distribution_size}{
    This parameter specifies the size of the random connectivity score distribution generated for p-value computation.
    Higher values provide more precise p-values. \cr
    See \code{\link{RandomConnectivityScoreDistributionAbstract}} for additional details.
    \itemize{
      \item Type: \code{integer}.
      \item Default value: \code{10^5}.
    }
  }
  \item{disease_name}{
    Disease name. If specified, a column containing the disease name will be added to the output table.
    \cr
    This parameter is optional and is ignored by the computation logic.
    \itemize{
      \item Type: \code{character}.
      \item Default value: \code{NA}.
    }
  }
  \item{disease_signature_type}{
    Specifies the disease signature type. It indicates the technique used to map the DGE to the signature. If provided, it is added to the output table but is not used in the computation.
    \itemize{
      \item Type: \code{character}.
      \item Default value: \code{NA}.
    }
  }
  \item{drug_perturbation_time}{
      Drug perturbation time, i.e., the duration for which the sample is treated with the drug.
      If specified, a column containing the drug perturbation time will be added to the output table.
      \cr
      This parameter is optional and is ignored by the computation logic.
      \itemize{
        \item Type: \code{character}.
        \item Default value: \code{NA}.
      }
  }
  \item{drugSignatureLoader (constructor argument)}{
    Loader for drug signatures provided in the \code{drug_signatures} argument.
    \cr
    This class uses the \code{signature_reference} column of the \code{drug_signatures} table to load the drug signature.
    \cr
    The \code{signature_reference} field may contain either the signature itself or a reference to it (e.g., a filename).
    \itemize{
      \item Type: class derived from \code{\link{DrugSignatureLoaderAbstract}}.
      \item Default value: Instance of class \code{\link{DrugSignatureLoaderByFilename}}.
    }
  }
}
\value{
Data frame. Columns: \code{drug}, \code{connectivity_score}, \code{p.value}, \code{adj.p.value}, \code{disease}, \code{disease_signature_type}, \code{drug_perturbation_time}.
}
\examples{
disease_signature <- data.frame(
  gene_id = c(1, 2, 3, 9, 11, 15),
  estimate = c(-9.261609, -10.36986, 8.17305166, 5.60715925, -8.444215, 7.12957687)
)

drugs <- data.frame(
  name = c("A-23187", "A-443644", "AG-490", "AG-494", "AG-957", "AM-404"),
  filename = c("A-23187.rds", "A-443644.rds", "AG-490.rds", "AG-494.rds", "AG-957.rds", "AM-404.rds")
)

n_drug_signatures_genes <- 10174
random_distribution_size <- 1e4
disease_name <- "IPF"
disease_signature_type <- "MostSignificantGenes"
drug_perturbation_time <- "6h"

binChenDiseaseSignatureDrugListConnectivityScoreParallelFacade <- BinChenDiseaseSignatureDrugListConnectivityScoreParallelFacade$new()
binChenDiseaseSignatureDrugListConnectivityScoreParallelFacade$compute(
  disease_signature, drugs, n_drug_signatures_genes, random_distribution_size,
  disease_name, disease_signature_type, drug_perturbation_time
)
# output
#
# drug          connectivity_score   p.value               adj.p.value           disease    disease_signature_type    drug_perturbation_time
# A-23187       -0.00684643          1.43635193616633e-16  1.4939496488066e-12   IPF        150 MostSignificantGenes  6h
# A-443644       0.042984999         2.35094164810416e-14  6.98801868826549e-11  IPF        150 MostSignificantGenes  6h
# AG-490         0.320787632         3.35930135961229e-14  6.98801868826549e-11  IPF        150 MostSignificantGenes  6h
# AG-494        -0.07737998          4.43902897324016e-14  7.69505672511181e-11  IPF        150 MostSignificantGenes  6h
# AG-957         0.380783267         1.13824000462484e-11  9.86569524008579e-09  IPF        150 MostSignificantGenes  6h
# AM-404         0.164675860         4.28827062937116e-11  3.18587877257781e-08  IPF        150 MostSignificantGenes  6h
}
