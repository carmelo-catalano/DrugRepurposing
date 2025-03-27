\name{DichotomicVoomDrugRepurpose}
\alias{DichotomicVoomDrugRepurpose}
\title{Compute connectivity score between disease RNA-Seq analysis and drugs}
\description{
Given a disease RNA-Seq analysis and a list of drug DGEs, DichotomicVoomDrugRepurpose compute the connectivity score between the disease and the drugs. This class compose the classes \code{DichotomicDGE} and \code{BinChenDiseaseDGEDrugListConnectivityScore} through \code{DichotomicDrugRepurposeCore} class.
}
\usage{
dichotomicVoomDrugRepurpose <- DichotomicVoomDrugRepurpose$new()
dichotomicVoomDrugRepurpose$compute(rna_seq, sample_01_map, drug_dge_dir, drugs,
                                     drugs_genes, drug_dge_t_value_column_name,
                                     random_distribution_size, disease_name,
                                     drug_perturbation_time, filter_by_protein_coding,
                                     parallel_computation, signature_mapper_parameter)
}
\arguments{
  \item{rna_seq}{
    Table of RNA-Seq data. Each column represents an RNA-Seq sample, and each row represents a gene.
    \itemize{
      \item Type: \code{data frame}.
      \item Columns: first column = gene ID; other columns: RNA-Seq sample data.
    }
    Typically, the first column name is \code{"GeneID"}. The remaining column names correspond to the RNA-Seq sample identifiers. See the example in the \code{Usage} section.
  }
  \item{sample_01_map}{
    The map has the same length as the number of columns in the \code{rna_seq} table. Each character represents the type of the corresponding column in the \code{rna_seq} table (i.e., the group): \code{0} = test sample, \code{1} = control sample, \code{X} = excluded sample.
  }
  \item{drug_dge_dir}{
    The directory containing the drugs DGE.
    \itemize{
      \item Type: \code{string}.
    }
  }
  \item{drugs}{
    A table containing the drugs name and the corresponding DGE filenames. The file must be in Rds format.
    \itemize{
      \item Type: \code{data frame}.
      \item Columns: \code{name} = drug name, \code{filename} = drug DGE filename.
    }
  }
  \item{drugs_genes}{
    The gene id list to use for connectivity score computation. Usually, we use a subset of the entire DGE, some genes are excluded.
    \itemize{
      \item Type: \code{vector}.
    }
  }
  \item{drug_dge_t_value_column_name}{
    The drug DGE parameter used for connectivity score computation is the t-value. This field contains the column name of the t-value in the DGE table.
    \itemize{
      \item Type: \code{string}.
      \item Default value: \code{"t.value"}.
    }
  }
  \item{random_distribution_size}{
    Parameter needed for p-value connectivity score computation. It is the size of the random connectivity score distribution.
    \itemize{
      \item Type: \code{integer}.
      \item Default value: \code{10^5}.
    }
  }
  \item{disease_name}{
    This argument will be \code{test_sample_name} argument for \code{DichotomicVoomDGE}.
    \itemize{
      \item Type: \code{string}.
    }
  }
  \item{drug_perturbation_time}{
    Drug perturbation time. If specified, it is added to the output table. It isn’t used for the computation.
    \itemize{
      \item Type: \code{string}.
      \item Default value: \code{NA}.
    }
  }
  \item{filter_by_protein_coding}{
    If true, remove non-protein coding genes.
    \itemize{
      \item Type: \code{boolean}.
      \item Default value: \code{F}.
    }
  }
  \item{parallel_computation}{
    If true, enables parallel computation (Unix-like systems only).
    \itemize{
      \item Type: \code{boolean}.
      \item Default value: \code{F}.
    }
  }
  \item{signature_mapper_parameter}{
    Parameter used by the constructor argument \code{dgeToSignatureMapper}. The mapper may use this parameter for mapping.
    If not specified, the default mapper is \code{MostSignificantGenesSignatureMapper}, so \code{signature_mapper_parameter} corresponds to \code{n_most_significant_genes}.
    \itemize{
      \item Default value: \code{NA}.
    }
  }
}
\section{Constructor arguments}{
  \item{\code{geneFilter}}{
    Instance of a class for filtering non-significant genes.
    \itemize{
      \item Type: Derived class of \code{GeneFilterAbstract}.
      \item Default value: \code{LowCountsGeneFilter}.
    }
  }
  \item{\code{dgeToSignatureMapper}}{
    Mapper for transform \code{disease_d
