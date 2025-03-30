\name{GEORNASeqLMMVoomDGEAbstract}
\alias{GEORNASeqLMMVoomDGEAbstract}
\title{Base class for computing differential gene expression using Linear Mixed Models and Voom-transformed data}
\description{
Base class for the constructor parameter \code{lmmVoomDGE} of the class \code{GEORNASeqLMMVoomDGE}.
\cr
This class computes differential gene expression analysis using the Linear Mixed Model (LMM) with
Voom-transformed data.
\cr
RNA-seq data and metadata files are sourced from NCBI (\url{https://www.ncbi.nlm.nih.gov/}).
}
\usage{
GEORNASeqLMMVoomDGEImpl <- R6Class(
  "GEORNASeqLMMVoomDGEImpl",
  inherit = GEORNASeqLMMVoomDGEAbstract,
  public = list(
    compute = function(rna_seq_data_filename, rna_seq_metadata_filename,
                  formula, tissue_status_field_name,
                  tissue_statuses_to_be_tested, tissue_statuses_map,
                  sample_id_field_name, additional_fields,
                  filter_by_protein_coding) {
      # do something
    }
  )
)
}
\arguments{
  \item{rna_seq_data_filename}{
    Filename for RNA-seq data compatible with the Gene Expression Omnibus (GEO) format. The file must be in tsv (tab-separated value) format.
    \cr
    The file may also be compressed in gz format.
    \cr
    The first column contains the gene ID; the other columns contain the RNA-Seq analysis. The first column name is \code{GeneID}, and the rest of the columns are titled according to the RNA analysis identifiers (sample id).
    \cr
    This package has been tested on Illumina RNA-seq data downloaded from \url{https://www.ncbi.nlm.nih.gov/}.
    \itemize{
      \item Type: \code{string}.
    }
  }
  \item{rna_seq_metadata_filename}{
    Filename of the RNA-seq metadata file. The file is in csv format and uses the “;” separator.
    \cr
    For each RNA-seq analysis column in the \code{rna_seq_data} table, there is a row in the \code{rna_seq_metadata} table.
    \cr
    The metadata contains the status control/altered state of the tissue and the additional conditions.
    \cr
    This package has been tested on Illumina RNA-seq data downloaded from url{https://www.ncbi.nlm.nih.gov/}.
    \itemize{
      \item Type: \code{string}.
    }
  }
  \item{formula}{
    The formula for LMM computation. The formula includes mixed effects and random effects to account for all the conditions under which the RNA-seq experiments were performed.
    \cr
    Because data and metadata are in separate files, the dependent variable to the left of the ~ operator must not be specified. For example: \code{~ tissue_status + (1 | tissue)}.
    \itemize{
      \item Type: \code{R formula}.
    }
  }
  \item{tissue_status_field_name}{
    Name of the column in the \code{rna_seq_metadata} table that contains the tissue status.
    \itemize{
      \item Type: \code{string}.
    }
  }
  \item{tissue_statuses_to_be_tested}{
    A list of length 2 containing tissue statuses, usually a control tissue and a disease-affected tissue.
    \itemize{
      \item Type: \code{string vector}.
    }
  }
  \item{tissue_statuses_map}{
    A list of length 2 containing tissue statuses to rename the statuses in \code{tissue_statuses_to_be_tested}.
    \cr
    \code{tissue_statuses_map} and \code{tissue_statuses_to_be_tested} must have the same size.
    \itemize{
      \item Type: \code{string vector}.
    }
  }
  \item{sample_id_field_name}{
    Column name in the \code{rna_seq_metadata} table that contains the sample id.
    \cr
    The sample id is used to match metadata with RNA-seq data.
    \itemize{
      \item Type: \code{string}.
    }
  }
  \item{additional_fields}{
    Additional fields to use for LMM computation. These fields represent the additional conditions under which the experiments were conducted.
    \itemize{
      \item Type: \code{string vector}.
    }
  }
  \item{filter_by_protein_coding}{
    If true, removes non-protein coding genes.
    \itemize{
      \item Type: \code{boolean}.
      \item Default value: \code{FALSE}.
    }
  }
}
\value{
Data frame. Columns: \code{DE_log2_FC}, \code{std.error}, \code{t.value}, \code{p.value}, \code{adj.p.value}.
\cr
\code{DE_log2_FC} represents differential expression = log2 fold change.
\cr
\code{Lmer} does not return p-value fields. Therefore, when LMM is computed using \code{lmer}, the fields \code{p.value} and \code{adj.p.value} are not included.
}
