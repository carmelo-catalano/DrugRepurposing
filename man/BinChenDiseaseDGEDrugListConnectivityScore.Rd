\name{BinChenDiseaseDGEDrugListConnectivityScore}
\alias{BinChenDiseaseDGEDrugListConnectivityScore}
\title{Compute the connectivity score between a disease and a list of drug DGEs}
\description{
Given a disease \link{DGE} and a list of drug DGEs, computes the connectivity score between disease and each drug.
}
\usage{
binChenDiseaseDGEDrugListConnectivityScore <- BinChenDiseaseDGEDrugListConnectivityScore$new()
binChenDiseaseDGEDrugListConnectivityScore$compute(
  disease_dge, drugs, drugs_genes, random_distribution_size, disease_name, drug_perturbation_time,
  parallel_computation, signature_mapper_parameter
)
}
\arguments{
  \item{disease_dge}{
    A table containing the disease \link{DGE}.
    \itemize{
      \item Type: \code{data.frame}.
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
  \item{drugs_genes}{
    The gene ID list to use for connectivity score computation. A subset of the signature may be used.
    \itemize{
      \item Type: \code{vector}.
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
  \item{parallel_computation}{
    If true, enables parallel computation (Unix-like systems only).
    \itemize{
      \item Type: \code{boolean}.
      \item Default value: \code{FALSE}.
    }
  }
  \item{signature_mapper_parameter}{
    Parameter used by the class specified in the constructor argument \code{dgeToSignatureMapper}.
    \cr
    The mapper may use this parameter during the mapping process. If not specified, the default mapper is \code{\link{MostSignificantGenesSignatureMapper}};
    in this case, \code{signature_mapper_parameter} corresponds to \code{n_most_significant_genes}.
    \itemize{
      \item Default value: \code{MostSignificantGenesSignatureMapper}.
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
  \item{dgeToSignatureMapper (constructor argument)}{
    Mapper for transforming a disease \link{DGE} into a disease signature (see \link{Gene-expression-signature}).
    \cr
    In this class, it is used to process the \code{disease_dge} parameter.
    \itemize{
      \item Type: class derived from \code{\link{DGEToSignatureMapperAbstract}}.
      \item Default value: \code{\link{MostSignificantGenesSignatureMapper}}.
    }
  }
}
\value{
Data frame. Columns: \code{drug}, \code{connectivity_score}, \code{p.value}, \code{adj.p.value}, \code{disease}, \code{disease_signature_type}, \code{drug_perturbation_time}.
}
\examples{
disease_dge <- data.frame(
  gene_id = c(1, 2, 3, 9, 11, 15),
  t.value = c(-9.261609, -10.36986, 8.17305166, 5.60715925, -8.444215, 7.12957687)
)

drugs <- data.frame(
  name = c("A-23187", "A-443644", "AG-490", "AG-494", "AG-957", "AM-404"),
  filename = c("A-23187.rds", "A-443644.rds", "AG-490.rds", "AG-494.rds", "AG-957.rds", "AM-404.rds")
)

drugs_genes <- c(1, 2, 3, 9, 11, 15, 826, 11224, 6158)
random_distribution_size <- 1e4
disease_name <- "IPF"
drug_perturbation_time <- "6h"
parallel_computation <- TRUE
signature_mapper_parameter <- 6

binChenDiseaseDGEDrugListConnectivityScore <- BinChenDiseaseDGEDrugListConnectivityScore$new()
binChenDiseaseDGEDrugListConnectivityScore$compute(
  disease_dge, drugs, drugs_genes, random_distribution_size, disease_name, drug_perturbation_time,
  parallel_computation, signature_mapper_parameter
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
