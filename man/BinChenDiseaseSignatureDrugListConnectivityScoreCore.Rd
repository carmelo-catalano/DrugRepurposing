\name{BinChenDiseaseSignatureDrugListConnectivityScoreCore}
\alias{BinChenDiseaseSignatureDrugListConnectivityScoreCore}
\title{Compute Connectivity Score Between Disease Signature and Drug List DGEs}
\description{
Given a disease signature and a list of drug DGEs, computes the connectivity score between the disease and each drug.
The class requires two collaborators:
\itemize{
  \item \code{randomConnectivityScoreDistribution (constructor argument)}
  \item \code{binChenConnectivityScoreListApplyer (constructor argument)}
}
This package provides two types of implementations:
\itemize{
  \item Parallel computation: \code{RandomConnectivityScoreDistributionParallel} and \code{BinChenConnectivityScoreListApplyerParallel}
  \item Synchronous computation: \code{RandomConnectivityScoreDistributionSync} and \code{BinChenConnectivityScoreListApplyerSync}
}
Additionally, it provides two facades:
\itemize{
  \item \code{BinChenDiseaseSignatureDrugListConnectivityScoreParallelFacade} for parallel execution.
  \item \code{BinChenDiseaseSignatureDrugListConnectivityScoreSyncFacade} for synchronous execution.
}
}
\usage{
BinChenDiseaseSignatureDrugListConnectivityScoreCore$new()
BinChenDiseaseSignatureDrugListConnectivityScoreCore$compute(disease_signature, drugs, 
n_drug_signatures_genes, random_distribution_size, disease_name, 
disease_signature_type, drug_perturbation_time)
}
\arguments{
  \item{disease_signature}{
    A table representing the signature of the disease's n most significant genes (usually between 50-300 genes). Only the t-value is required for computation; the sign indicates gene status: positive = upregulated, negative = downregulated.
    \itemize{
      \item Type: \code{data.frame}
      \item Columns: \code{gene_id}, \code{t.value}
    }
  }
  \item{drugs}{
    Drug signatures: A table containing drug names and their corresponding DGE filenames (in RDS format).
    \itemize{
      \item Type: \code{data.frame}
      \item Columns: \code{name} (drug name), \code{filename} (drug DGE filename)
    }
  }
  \item{n_drug_signatures_genes}{
    Total number of drug signature genes required for the connectivity score computation and for generating the random connectivity score distribution.
    \itemize{
      \item Type: \code{integer}
    }
  }
  \item{random_distribution_size}{
    Size of the random connectivity score distribution. Higher values provide more precise p-values.
    \itemize{
      \item Type: \code{integer}
      \item Default value: \code{10^5}
    }
  }
  \item{disease_name}{
    Name of the disease. Added to the output table but not used in the computation.
    \itemize{
      \item Type: \code{string}
      \item Default value: \code{NA}
    }
  }
  \item{disease_signature_type}{
    Specifies the disease signature type (mapping technique used). Added to the output table but not used in the computation.
    \itemize{
      \item Type: \code{string}
      \item Default value: \code{NA}
    }
  }
  \item{drug_perturbation_time}{
    Drug perturbation time. Added to the output table but not used in the computation.
    \itemize{
      \item Type: \code{string}
      \item Default value: \code{NA}
    }
  }
  \item{randomConnectivityScoreDistribution (constructor argument)}{
    Instance for generating the random connectivity score distribution.
    \itemize{
      \item Type: class derived from \code{RandomConnectivityScoreDistributionAbstract}
    }
  }
  \item{binChenConnectivityScoreListApplyer (constructor argument)}{
    Instance for computing the connectivity score between disease up/downregulated genes and drugs.
    \itemize{
      \item Type: class derived from \code{BinChenConnectivityScoreListApplyerAbstract}
    }
  }
}
\value{
A \code{data.frame} with columns: \code{drug}, \code{connectivity_score}, \code{p.value}, \code{adj.p.value}, \code{disease}, \code{gene_selection_strategy}, \code{drug_perturbation_time}.
}
\examples{
disease_signature <- data.frame(gene_id = c(1, 2, 3, 9, 11, 15),
                                t.value = c(-9.26, -10.37, 8.17, 5.60, -8.44, 7.13))
drugs <- data.frame(name = c("A-23187", "A-443644", "AG-490", "AG-494", "AG-957", "AM-404"),
                    filename = c("A-23187.rds", "A-443644.rds", "AG-490.rds", 
                                 "AG-494.rds", "AG-957.rds", "AM-404.rds"))
n_drug_signatures_genes <- 10174
random_distribution_size <- 1e4
disease_name <- "IPF"
disease_signature_type <- "MostSignificantGenes"
drug_perturbation_time <- "6h"

binChenDiseaseSignatureDrugListConnectivityScoreCore <- BinChenDiseaseSignatureDrugListConnectivityScoreCore$new()
result <- binChenDiseaseSignatureDrugListConnectivityScoreCore$compute(disease_signature, drugs, 
                                                                       n_drug_signatures_genes, 
                                                                       random_distribution_size, 
                                                                       disease_name, 
                                                                       disease_signature_type, 
                                                                       drug_perturbation_time)
print(result)
}
