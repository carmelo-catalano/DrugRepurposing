\name{GEORNASeqDichotomicVoomDGE}
\alias{GEORNASeqDichotomicVoomDGE}
\title{Compute differential gene expression analysis for RNA-Seq data}
\description{
Compute the differential gene expression analysis for two groups of RNA-Seq data under different conditions (e.g., control vs. altered state). RNA data must follow a negative binomial distribution and be sourced from NCBI RNA-Seq datasets.
}
\usage{
geoRNASeqDichotomicVoomDGE <- GEORNASeqDichotomicVoomDGE$new()
geoRNASeqDichotomicVoomDGE$compute(rna_seq_filename, sample_01_map, test_sample_name, filter_by_protein_coding)
}
\arguments{
  \item{rna_seq_filename}{
    Path to the RNA-Seq data file. The file must be in TSV format (or compressed as \code{*.gz}).
    \itemize{
      \item Type: \code{string}.
    }
  }
  \item{sample_01_map}{
    A mapping of RNA-Seq sample groups in the file: \code{0} = test sample, \code{1} = control sample, \code{X} = excluded sample.
    \itemize{
      \item Type: \code{string}.
    }
  }
  \item{test_sample_name}{
    Name of the test sample.
    \itemize{
      \item Type: \code{string}.
    }
  }
  \item{filter_by_protein_coding}{
    If true, removes non-protein-coding genes.
    \itemize{
      \item Type: \code{boolean}.
      \item Default value: \code{FALSE}.
    }
  }
}
\section{Constructor arguments}{
  \item{\code{geneFilter}}{
    Instance for filtering non-significant genes.
    \itemize{
      \item Type: Derived class of \code{GeneFilterAbstract}.
      \item Default value: \code{LowCountsGeneFilter}.
    }
  }
}
\value{
A data frame with columns:
\itemize{
  \item \code{DE_log2_FC}
  \item \code{std.error}
  \item \code{t.value}
  \item \code{p.value}
  \item \code{adj.p.value}
}
}
\examples{
rna_seq_filename <- "/path/to/rna_seq_data.tsv"
sample_01_map <- "0X10"
test_sample_name <- "IPF"
filter_by_protein_coding <- FALSE

geoRNASeqDichotomicVoomDGE <- GEORNASeqDichotomicVoomDGE$new()
result <- geoRNASeqDichotomicVoomDGE$compute(rna_seq_filename, sample_01_map, test_sample_name, filter_by_protein_coding)
print(result)
}
