\name{DichotomicVoomDrugRepurpose}
\alias{DichotomicVoomDrugRepurpose}
\title{Compute the connectivity score between a disease and a list of drugs}
\description{
Given a disease RNA-Seq analysis and a list of drug DGEs (\link{DGE}), \code{DichotomicVoomDrugRepurpose} computes the
connectivity score between the disease and the drugs. This class composes the
classes \code{DichotomicDGE} and \code{BinChenDiseaseDGEDrugListConnectivityScore}
through the \code{DichotomicDrugRepurposeCore} class.
\cr
Disease RNA-Seq data must be expressed as counts.
}
\usage{
dichotomicVoomDrugRepurpose <- DichotomicVoomDrugRepurpose$new()
dichotomicVoomDrugRepurpose$compute(
  rna_seq, sample_01_map, drugs, drugs_genes, random_distribution_size, disease_name,
  drug_perturbation_time, filter_by_protein_coding, parallel_computation,
  signature_mapper_parameter
)
}
\arguments{
  \item{rna_seq}{
    Table of RNA-Seq data analysis. Each column represents an RNA-Seq analysis sample, and each row corresponds to a gene.
    \cr
    RNA data must follow a "negative binomial distribution".
    \cr
    Row names are gene IDs; column names are experiment IDs.
    \itemize{
      \item Type: \code{matrix}.
    }
  }
  \item{sample_01_map}{
    The map has the same length as the number of columns in the \code{rna_data} table.
    Each character represents the type of the corresponding column in
    \code{rna_data} table (i.e., the group):
    0 = control sample, 1 =  test sample (altered state), X = excluded sample.
    Instead of using 0 and 1, you can label samples as C (control) and T (test).
    \itemize{
      \item Type: \code{character}.
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
  \item{filter_by_protein_coding}{
    If \code{TRUE}, non-protein-coding genes are removed from the analysis.
    \itemize{
      \item Type: \code{boolean}.
      \item Default value: \code{FALSE}.
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
  \item{geneFilter (constructor argument)}{
    Instance of a class for filtering non-significant genes.
    \itemize{
      \item Type: derived class of \code{\link{GeneFilterAbstract}}.
      \item Default value: instance of class \code{\link{LowCountsGeneFilter}}.
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
    \itemize{
      \item Type: class derived from \code{\link{DGEToSignatureMapperAbstract}}.
      \item Default value: \code{\link{MostSignificantGenesSignatureMapper}}.
    }
  }
}
\value{
Data frame. Columns: \code{drug}, \code{connectivity_score}, \code{disease}, \code{disease_signature_type}, \code{drug_perturbation_time}. The column \code{drug_perturbation_time} is optional.
}
\examples{
rna_seq <- matrix(
  c(
    262, 281897, 463, 12301, 284, 2966, 4842, 9966,
    116, 337026, 261, 3277, 132, 2006, 3699, 12406,
    111, 111736, 193, 862, 88, 1371, 2536, 1531,
    162, 219471, 281, 5990, 280, 2241, 4527, 12941
  ),
  nrow = 8,
  ncol = 4,
  dimnames = list(
    c(1, 2, 3, 9, 10, 11, 12, 13),
    c("GSM1", "GSM2", "GSM3", "GSM4")
  )
)

sample_01_map <- "1X01"
drugs <- data.frame(
  name = c("A-23187", "A-443644", "AG-490", "AG-494", "AG-957", "AM-404"),
  filename = c("drugs_dge/A-23187.Rds", "drugs_dge/A-443644.Rds", "drugs_dge/AG-490.Rds",
               "drugs_dge/AG-494.Rds", "drugs_dge/AG-957.Rds", "drugs_dge/AM-404.Rds")
)
drugs_genes <- c(1, 2, 3, 9, 10, 11, 12, 13, 6158)

dichotomicVoomDrugRepurpose <- DichotomicVoomDrugRepurpose$new()
dichotomicVoomDrugRepurpose$compute(
  rna_seq = rna_seq,
  sample_01_map = sample_01_map,
  drugs = drugs,
  drugs_genes = drugs_genes,
  random_distribution_size = 10^5,
  disease_name = "IPF",
  drug_perturbation_time = "6h",
  filter_by_protein_coding = FALSE,
  parallel_computation = FALSE,
  signature_mapper_parameter = 8
)
# Output:
# drug        connectivity_score   disease  disease_signature_type  drug_perturbation_time
# ----------------------------------------------------------------------------------------
# A-23187     0.0006964073         ipf      100 MostSignificantGenes  6h
# A-443644    -0.0753171062        ipf      100 MostSignificantGenes  6h
# AG-490      0.0047974725         ipf      100 MostSignificantGenes  6h
# AG-494      0.3687839200         ipf      100 MostSignificantGenes  6h
# AG-957      -0.2329153916        ipf      100 MostSignificantGenes  6h
# AM-404      0.4272237341         ipf      100 MostSignificantGenes  6h
}
