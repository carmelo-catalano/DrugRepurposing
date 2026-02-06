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
filtered_data <- lmmNoGeneFilter(gene_expressions, metadata, random_effect_column_names, counts_filter_column_name)
}
\arguments{
  Same as in \code{LMMGeneFilterAbstract}.
}
\value{
  \code{gene_expressions}
}
