\name{RandomConnectivityScoreDistributionSync}
\alias{RandomConnectivityScoreDistributionSync}
\title{Generate random distribution for p-value computation synchronously}
\description{
Derived class of \code{RandomConnectivityScoreDistributionAbstract}.
\cr
It generates a random distribution for p-value computation using synchronous computation.
\cr
See \code{\link{RandomConnectivityScoreDistributionAbstract}} for additional details.
}
\usage{
randomConnectivityScoreDistributionSync <- RandomConnectivityScoreDistributionSync$new()
randomConnectivityScoreDistributionSync$compute(
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
randomConnectivityScoreDistributionSync <- RandomConnectivityScoreDistributionSync$new()
randomConnectivityScoreDistributionSync$compute(
  n_disease_signature_down_regulated_genes,
  n_disease_signature_up_regulated_genes,
  n_drug_signatures_genes,
  random_distribution_size
)
# output
# c(-0.289021513, 0.135464095, 0.046817017, -0.043967538, -0.179842505,
#   0.332907256, -0.275896118, 0.277629821, -0.140798365, -0.084327114)
}
