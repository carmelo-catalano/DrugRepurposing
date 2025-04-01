\name{NoGeneFilter}
\alias{NoGeneFilter}
\title{No filtering applied for gene expression data}
\description{
No filtering applied. Used when a filter class is required as a dependency, but no filtering is needed.
\cr
This class is derived from \code{GeneFilterAbstract}.
}
\usage{
noGeneFilter <- NoGeneFilter$new()
filtered_data <- noGeneFilter$filter(gene_expressions)
}
\arguments{
  Same as in \code{GeneFilterAbstract}.
}
\value{
Same as in \code{GeneFilterAbstract}.
}
