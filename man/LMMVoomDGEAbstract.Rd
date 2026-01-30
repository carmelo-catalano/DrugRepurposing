\name{LMMVoomDGEAbstract}
\alias{LMMVoomDGEAbstract}
\title{Base class for LMMVoomDGE implementation}
\description{
Base class for \code{LMMVoomDGE} implementation.
\cr
The derived class computes a voom LMM differential gene expression.
\cr
This package provides three implementations: \code{LMMVoomDreamDGE}, \code{LMMVoomJuliaDGE}, and \code{LMMVoomLmerDGE}.
}
\usage{
LMMVoomDGEImpl <- R6Class(
  "LMMVoomDGEImpl",
  inherit = LMMVoomDGEAbstract,
  public = list(
    filter = function(rna_seq_data, rna_seq_metadata, formula, filter_by_protein_coding) {
      # do something
    }
  )
)
}

\arguments{
  \item{rna_seq_data}{
    Rna-seq data. The first column contains the gene id; the other columns contain the RNA-Seq analysis.
    The first column name is \code{"GeneID"}. The rest of the columns are titled according to the RNA analysis identifier (sample id).
    \cr
    This package has been tested on Illumina RNA-seq data downloaded from \url{https://www.ncbi.nlm.nih.gov/}.
    \itemize{
      \item Type: \code{string}.
    }
  }
  \item{rna_seq_metadata}{
    RNA-seq metadata. For each RNA-seq analysis column in the \code{rna_seq_data} table, there is a row in the \code{rna_seq_metadata} table.
    \cr
    The first column values of \code{rna_metadata} must match the row names of \code{rna_data}.
    \cr
    The metadata contains the status control/altered state of the tissue and the additional conditions.
    \cr
    This package has been tested on Illumina RNA-seq data downloaded from \url{https://www.ncbi.nlm.nih.gov/}.
    \cr
    The status column must be a factor. The first level of the factor must be the "control" state.
    \itemize{
      \item Type: \code{data.frame}.
    }
  }
  \item{formula (constructor argument)}{
    The formula for LMM computation. The formula includes mixed effects and random effects to account for all the conditions under which the RNA-Seq experiments were performed. Because data and metadata are in separate data frames, the dependent variable to the left of the \code{~} operator must not be specified. For example: \code{~ tissue_status + (1 | tissue)}.
    \itemize{
      \item Type: \code{R formula}.
    }
  }
  \item{filter_by_protein_coding}{
    If true, remove non-protein coding genes.
    \itemize{
      \item Type: \code{boolean}.
      \item Default value: \code{F}.
    }
  }
}
\value{
Data frame. Columns: \code{gene_id}, \code{DE_log2_FC}, \code{std.error}, \code{t.value}, \code{p.value}, \code{adj.p.value}.
\cr
The \code{lmer} implementation does not return \code{p.value} and \code{adj.p.value}.
}
\examples{
LMMVoomDGEImpl <- R6Class(
  "LMMVoomDGEImpl",
  inherit = LMMVoomDGEAbstract,
  public = list(
    filter = function(rna_seq_data, rna_seq_metadata, formula, filter_by_protein_coding) {
      # do something
    }
  )
)
}
