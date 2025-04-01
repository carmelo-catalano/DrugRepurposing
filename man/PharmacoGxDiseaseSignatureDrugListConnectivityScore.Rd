\name{PharmacoGxDiseaseSignatureDrugListConnectivityScore}
\alias{PharmacoGxDiseaseSignatureDrugListConnectivityScore}
\title{Compute connectivity score between disease and drugs}
\description{
Given a disease Differential Gene Expression (DGE) and a list of drug DGEs, this class computes the connectivity score between the disease and each drug.
The computation is based on the \code{PharmacoGx::connectivityScore} function from the \code{PharmacoGx} library.
}
\usage{
pharmacoGxDiseaseSignatureDrugListConnectivityScore <- PharmacoGxDiseaseSignatureDrugListConnectivityScore$new()
pharmacoGxDiseaseSignatureDrugListConnectivityScore$compute(
  disease_signature, drugs, n_permutations, disease_name, disease_signature_type, drug_perturbation_time
)
}
\arguments{
  \item{disease_dge}{
    A table containing a subset of the disease's \code{DGE}. For connectivity score computation, only the \code{t.value} is required. The sign of the \code{t.value} indicates the gene's status: positive = upregulated, negative = downregulated.
    \itemize{
      \item Type: \code{data frame}.
      \item Columns: \code{gene_id}, \code{t.value}.
    }
  }
  \item{drugs}{
    Drug signatures. A table containing the drug names and their corresponding DGE filenames. The files must be in RDS format.
    \itemize{
      \item Type: \code{data frame}.
      \item Columns: \code{name} = drug name, \code{filename} = drug DGE filename.
    }
  }
  \item{n_permutations}{
    Number of permutations to determine significance through permutation testing. The minimum value is 100.
    \itemize{
      \item Type: \code{integer}.
      \item Default value: \code{10^4}.
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
    Gene selection strategy. If specified, it is added to the output table. It is not used for the computation.
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
}
\value{
A \code{data frame}. Columns: \code{drug}, \code{connectivity_score}, \code{p.value}, \code{adj.p.value}, \code{disease} (optional), \code{disease_signature_type} (optional), \code{drug_perturbation_time} (optional).
}
\examples{
disease_signature <- data.frame(
  t.value = c(-9.261609, -10.36986, 8.173052, 5.607159, -8.444215, 7.129577),
  row.names = c(1, 2, 3, 9, 11, 15)
)

# disease_signature =
# row_names    t.value
# 1            -9.261609
# 2            -10.36986
# 3             8.173052
# 9             5.607159
# 11           -8.444215
# 15            7.129577

drugs <- data.frame(
  name = c("A-23187", "A-443644", "AG-490", "AG-494", "AG-957", "AM-404"),
  filename = c("A-23187", "A-443644", "AG-490", "AG-494", "AG-957", "AM-404")
)

# drugs
# name        filename
# A-23187     A-23187
# A-443644    A-443644
# AG-490      AG-490
# AG-494      AG-494
# AG-957      AG-957
# AM-404      AM-404

n_permutations <- 1e4
disease_name <- "IPF"
disease_signature_type <- "150 MostSignificantGenes"
drug_perturbation_time <- "6h"

pharmacoGxDiseaseSignatureDrugListConnectivityScore <- PharmacoGxDiseaseSignatureDrugListConnectivityScore$new()
pharmacoGxDiseaseSignatureDrugListConnectivityScore$compute(
  disease_signature, drugs, n_permutations, disease_name, disease_signature_type, drug_perturbation_time
)
# output:
# drug        connectivity_score   p.value      adj.p.value   disease   disease_signature_type      drug_perturbation_time
# A-23187     -0.00684643          1.44E-16    1.49E-12       IPF       150 MostSignificantGenes    6h
# A-443644    0.042984999          2.35E-14    6.98E-11       IPF       150 MostSignificantGenes    6h
# AG-490      0.320787632          3.35E-14    6.98E-11       IPF       150 MostSignificantGenes    6h
# AG-494      -0.07737998          4.43E-14    7.69E-11       IPF       150 MostSignificantGenes    6h
# AG-957      0.380783267          1.13E-11    9.87E-09       IPF       150 MostSignificantGenes    6h
# AM-404      0.164675860          4.28E-11    3.18E-08       IPF       150 MostSignificantGenes    6h
}
