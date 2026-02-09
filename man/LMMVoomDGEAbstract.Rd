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
    This package has been tested on Illumina RNA-seq data downloaded from \url{https://www.ncbi.nlm.nih.gov/}.
    \cr
    rna_seq_data_filename can be either a local path or a remote URL (typically hosted by NCBI), example:
    https://www.ncbi.nlm.nih.gov/geo/download/?format=file&type=rnaseq_counts&acc=GSE92592&file=GSE92592_raw_counts_GRCh38.p13_NCBI.tsv.gz\cr
    See example in \code{LMMVoomDGEDream}.
    \itemize{
      \item Type: \code{data.frame}.
    }
  }
  \item{rna_seq_metadata}{
    \code{rna_seq_metadata} contain metadata for \code{rna_seq_data}.
    The first column of \code{rna_seq_metadata} must be named "\code{sample_id}" and must contain the sample IDs of the RNA-seq experiments.
    This column is used to filter \code{rna_seq_data}: \code{rna_seq_data <- rna_seq_data[, rna_seq_metadata$sample_id]}.
    \cr
    The metadata contain the control/altered status of each sample, along with additional conditions.
    \cr
    This package has been tested on Illumina RNA-seq data downloaded from url{https://www.ncbi.nlm.nih.gov/}.
    \cr
    The status column must be a factor. The first level of the factor must be the "control" state.
    \cr
    See example in \code{LMMVoomDGEDream}.
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
