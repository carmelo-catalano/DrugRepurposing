\name{RandomConnectivityScoreDistributionParallel}
\alias{RandomConnectivityScoreDistributionParallel}
\title{Generate random distribution for p-value computation using parallel processing}
\description{
Derived class of \code{RandomConnectivityScoreDistributionAbstract}.
\cr
\code{RandomConnectivityScoreDistributionParallel} generates a random distribution for p-value computation using parallel processing.
\cr
See \code{\link{RandomConnectivityScoreDistributionAbstract}} for additional details.
}
\usage{
randomConnectivityScoreDistributionParallel <- RandomConnectivityScoreDistributionParallel$new()
randomConnectivityScoreDistributionParallel$compute(
  n_disease_signature_down_regulated_genes,
  n_disease_signature_up_regulated_genes,
  n_drug_signatures_genes,
  random_distribution_size
)
}
\arguments{
  See RandomConnectivityScoreDistributionAbstract.
}
\value{
 See RandomConnectivityScoreDistributionAbstract.
}
\examples{
n_disease_signature_down_regulated_genes <- 20
n_disease_signature_up_regulated_genes <- 30
n_drug_signatures_genes <- 100
random_distribution_size <- 10
randomConnectivityScoreDistributionParallel <- RandomConnectivityScoreDistributionParallel$new()
randomConnectivityScoreDistributionParallel$compute(
  n_disease_signature_down_regulated_genes,
  n_disease_signature_up_regulated_genes,
  n_drug_signatures_genes,
  random_distribution_size
)
# output
# c(-0.263576684, 0.273944539, -0.264391624, 0.119434069, -0.145297114,
#   -0.283033390, 0.398607810, 0.035382003, 0.368364460, 0.324063384)
}
