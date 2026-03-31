\name{NoGeneFilter}
\alias{NoGeneFilter}
\title{No filtering applied for gene expression data}
\description{
No filtering applied. Used when a filter class is required as a dependency, but no filtering is needed.
\cr
This class is derived from \code{LMMGeneFilterAbstract}.
}
\usage{
lmmNoGeneFilter <- LMMNoGeneFilter$new()
filtered_data <- lmmNoGeneFilter(rna_data, rna_metadata, random_effect_column_names, sample_status_column_name)
}
\arguments{
  Same as in \code{LMMGeneFilterAbstract}.
}
\value{
  \code{rna_data}
}
