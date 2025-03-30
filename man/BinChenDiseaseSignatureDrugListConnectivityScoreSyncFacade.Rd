\name{BinChenDiseaseSignatureDrugListConnectivityScoreSyncFacade}
\alias{BinChenDiseaseSignatureDrugListConnectivityScoreSyncFacade}
\title{Facade for BinChenDiseaseSignatureDrugListConnectivityScoreCore using synchronous computation}
\description{
Facade for \code{BinChenDiseaseSignatureDrugListConnectivityScoreCore}.
It creates an instance of \code{BinChenDiseaseSignatureDrugListConnectivityScoreCore} using the synchronous implementations of \code{RandomConnectivityScoreDistributionAbstract} and \code{BinChenConnectivityScoreListApplyerAbstract}.
The synchronous implementations used are: \code{RandomConnectivityScoreDistributionSync} and \code{BinChenConnectivityScoreListApplyerSync}.
This class is identical to \code{BinChenDiseaseSignatureDrugListConnectivityScoreParallelFacade}, except for the computation type.
}
\usage{
BinChenDiseaseSignatureDrugListConnectivityScoreSyncFacade$new()
BinChenDiseaseSignatureDrugListConnectivityScoreSyncFacade$compute(disease_signature, drugs,
random_distribution_size, disease_name, drug_perturbation_time)
}
\arguments{
  \item{disease_signature}{
    A table containing the data of the disease's n most significant genes from DGE. A typical n value ranges from 50 to 300. This table represents the signature.
    For connectivity score computation, only the t-value is needed. The sign of the t-value indicates the status of the gene: positive = upregulated, negative = downregulated.
    \itemize{
      \item Type: \code{data.frame}.
      \item Columns: \code{gene_id}, \code{t.value}.
    }
  }
  \item{drugs}{
    A table containing the drug names and their corresponding DGE filenames. The files must be in RDS format.
    \itemize{
      \item Type: \code{data.frame}.
      \item Columns: \code{name} = drug name, \code{filename} = drug DGE filename.
    }
  }
  \item{n_drug_signatures_genes}{
    For the connectivity score computation, only a subset of drug signature genes is used. This parameter represents the total number of the drug signature genes.
    \itemize{
      \item Type: \code{integer}.
    }
  }
  \item{random_distribution_size}{
    Size of the random connectivity score distribution. Higher values provide more precise p-values.
    \itemize{
      \item Type: \code{integer}.
      \item Default value: \code{10^5}.
    }
  }
  \item{disease_name}{
    Disease name. If specified, it is added to the output table. It is not used for the computation.
    \itemize{
      \item Type: \code{string}.
      \item Default value: \code{NA}.
    }
  }
  \item{disease_signature_type}{
    Specifies the disease signature type. It indicates the technique used to map the DGE to the signature. If provided, it is added to the output table but is not used in the computation.
    \itemize{
      \item Type: \code{string}.
      \item Default value: \code{NA}.
    }
  }
  \item{drug_perturbation_time}{
    Drug perturbation time. If specified, it is added to the output table. It is not used for the computation.
    \itemize{
      \item Type: \code{string}.
      \item Default value: \code{NA}.
    }
  }
  \item{drugSignatureLoader (constructor argument)}{
    Loader for drug DGEs in the argument \code{drugs}.
    \itemize{
      \item Type: class derived from \code{DrugSignatureLoaderAbstract}.
      \item Default value: Instance of class \code{DrugSignatureLoaderByFilename}.
    }
  }
}
\value{
Data frame. Columns: \code{drug}, \code{connectivity_score}, \code{p.value}, \code{adj.p.value}, \code{disease}, \code{disease_signature_type}, \code{drug_perturbation_time}.
}
\examples{
disease_signature <- data.frame(
  gene_id = c(1, 2, 3, 9, 11, 15),
  t.value = c(-9.261609, -10.36986, 8.17305166, 5.60715925, -8.444215, 7.12957687)
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

binChenDiseaseSignatureDrugListConnectivityScoreSyncFacade <- BinChenDiseaseSignatureDrugListConnectivityScoreSyncFacade$new()
binChenDiseaseSignatureDrugListConnectivityScoreSyncFacade$compute(
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
