\name{GEORNASeqDichotomicVoomDGE}
\alias{GEORNASeqDichotomicVoomDGE}
\title{Computes the differential gene expression analysis using Voom transformation}
\description{
Computes the differential gene expression analysis (\link{DGE}). The input consists of two groups of RNA-Seq
data from tissues under different conditions, for example, a disease-affected group and a control
group. RNA data must follow a negative binomial distribution, typically data from RNA-Seq-like
analyses.
\cr
For RNA data following a normal distribution, such as microarray data, see \code{\link{DichotomicDGE}}.
\cr
The input RNA-Seq data file is sourced from NCBI (\url{https://www.ncbi.nlm.nih.gov/}).
}
\usage{
geoRNASeqDichotomicVoomDGE <- GEORNASeqDichotomicVoomDGE$new()
geoRNASeqDichotomicVoomDGE$compute(
  rna_seq_data_filename, sample_01_map, filter_by_protein_coding
)
}
\arguments{
  \item{rna_seq_data_filename}{
    Name of the file containing the RNA-Seq data.
    \cr
    The file must be in TSV (tab-separated values) format, optionally compressed in GZ format, and must comply with the GEO NCBI specification.
    \cr
    The file contains a table of RNA-Seq data.\cr
    The table should have gene IDs in the first column (named \code{GeneID}) and RNA-Seq analysis identifiers (sample IDs) as subsequent column headers.
    Each row represents a gene, and each column represents an RNA-Seq sample.
    \cr
    The filename can be a local path (e.g., \file{/user/rna/raw_counts.tsv}) or a URL (e.g., \url{https://www.ncbi.gov/geo/download/raw_counts.tsv.gz}).
    This package has been tested on Illumina RNA-seq data downloaded from \url{https://www.ncbi.nlm.nih.gov/}.
    \itemize{
      \item Type: \code{character}.
    }
  }
  \item{sample_01_map}{
    The map has the same length as the number of columns in the \code{rna_data} table.
    Each character represents the type of the corresponding column in
    \code{rna_data} table (i.e., the group):
    0 = control sample, 1 =  test sample (altered state), X = excluded sample.
    Instead of using 0 and 1, you can label samples as C (control) and T (test).
    \itemize{
      \item Type: \code{string}.
    }
  }
  \item{filter_by_protein_coding}{
    If \code{TRUE}, non-protein-coding genes are removed from the analysis.
    \itemize{
      \item Type: \code{boolean}.
      \item Default value: \code{FALSE}.
    }
  }
  \item{geneFilter (constructor argument)}{
    Instance of a class for filtering non-significant genes.
    \itemize{
      \item Type: derived class of \code{\link{GeneFilterAbstract}}.
      \item Default value: instance of class \code{\link{LowCountsGeneFilter}}.
    }
  }
}
\value{
Data frame. Columns: \code{DE_log2_FC}, \code{std.error}, \code{t.value}, \code{p.value}, \code{adj.p.value}.
\cr
\code{DE_log2_FC} = differential gene expression = log2 fold change.
\cr
See \link{DGE} for additional details.
}
\examples{

rna_seq_data_filename <- "https://www.ncbi.nlm.nih.gov/geo/download/?format=file&type=rnaseq_counts&acc=GSE92592&file=GSE92592_raw_counts_GRCh38.p13_NCBI.tsv.gz"
# a local path is also allowed
# rna_seq_data_filename <- "/home/user/rna/GSE92592_raw_counts_GRCh38.p13_NCBI.tsv"

# File content:
# GeneID   GSM1    GSM2    GSM3    GSM4
# 1        262     116     111     162
# 2        281897  337026  111736  219471
# 3        463     261     193     281
# 9        12301   3277    862     5990
# 10       284     132     88      280
# 11       2966    2006    1371    2241
# 12       4842    3699    2536    4527
# 13       9966    12406   1531    12941

sample_01_map <- "1X01"

# How the map is applied:
#           1      X      0      1
# GeneID   GSM1   GSM2   GSM3   GSM4
# 1        262    116    111    162
# ...
#
#
# GSM1, GSM4 = IPF; GSM3 = control; GSM2 = excluded

filter_by_protein_coding <- FALSE

geoRNASeqDichotomicVoomDGE <- GEORNASeqDichotomicVoomDGE$new()
geoRNASeqDichotomicVoomDGE$compute(
  rna_seq_data_filename, sample_01_map, filter_by_protein_coding
)

# Output:
# gene_id  DE_log2_FC  std.error  t.value    p.value      adj.p.value
# 1        -1.741698   0.1880556 -9.261609  1.64e-11     1.49e-09
# 2        -2.068486   0.1994708 -10.36986  6.49e-13     1.48e-10
# 3         3.150816   0.3855128  8.173051  4.52e-10     1.91e-08
# 9         1.574593   0.2808184  5.607159  1.67e-06     1.54e-05
# 10       -1.162480   0.4794700 -11.98620  6.29e-12     1.28e-11
# 11       -1.578634   0.1869485 -8.444215  1.95e-10     9.84e-09
# 12       -2.231698   0.3184555 -10.22609  1.44e-12     1.40e-10
# 13        2.401361   0.3368167  7.129577  1.22e-08     2.70e-07
}
