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
    The first column contains the gene ID; the other columns contain the RNA-Seq analysis.
    The first column name is \code{GeneID}, and the rest of the columns are titled according to the RNA analysis identifiers (sample id).
    \cr
    This package has been tested on Illumina RNA-Seq data downloaded from \url{https://www.ncbi.nlm.nih.gov/}.
    \cr
    rna_seq_data_filename can be either a local path or a remote URL (typically hosted by NCBI), example:
    https://www.ncbi.nlm.nih.gov/geo/download/?format=file&type=rnaseq_counts&acc=GSE92592&file=GSE92592_raw_counts_GRCh38.p13_NCBI.tsv.gz\cr
    See example in \code{LMMVoomDGEDream}.
    \itemize{
      \item Type: \code{data.frame}.
    }
  }
  \item{rna_seq_metadata}{
    RNA-Seq metadata table associated with the RNA-Seq data table.\cr
    The metadata contains the control/altered state of the samples, along with additional conditions (e.g., sample origin).\cr
    For each RNA-Seq sample column in the RNA-Seq data table, there must be a corresponding row in the \code{rna_seq_metadata} table.\cr
    One column of \code{rna_seq_metadata} must be named \code{"sample_id"} and must contain the sample IDs of the RNA-Seq experiments.
    This column is used to filter \code{rna_seq_data}: \code{rna_seq_data <- rna_seq_data[, rna_seq_metadata$sample_id]}.\cr
    The status column must be a factor, and the first level of the factor must correspond to the \code{"control"} state.\cr
    This package has been tested on Illumina RNA-Seq data downloaded from \url{https://www.ncbi.nlm.nih.gov/}.
    \itemize{
      \item Type: \code{data.frame}.
    }
  }
  \item{formula (constructor argument)}{
    The formula for LMM computation. The formula includes mixed effects and random effects to account
    for all the conditions under which the RNA experiments were performed.
    \itemize{
      \item Type: \code{R formula}.
    }
  }
  \item{filter_by_protein_coding}{
    If \code{TRUE}, non-protein-coding genes are removed from the analysis.
    \itemize{
      \item Type: \code{boolean}.
      \item Default value: \code{FALSE}.
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
