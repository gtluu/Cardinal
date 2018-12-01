\name{spatialFastmap-methods}
\docType{methods}
\alias{spatialFastmap}
\alias{class:spatialFastmap}
\alias{spatialFastmap-class}
\alias{spatialFastmap-methods}
\alias{spatialFastmap,SImageSet-method}
\alias{summary,SpatialFastmap-method}
\alias{print.summary.SpatialFastmap}
\alias{plot.summary.SpatialFastmap}

\title{Spatially-aware FastMap projection}
\description{
	Performs spatially-aware FastMap projection.
}
\usage{
    \S4method{spatialFastmap}{SImageSet}(x, r = 1, ncomp = 2,
        method = c("gaussian", "adaptive"),
        iter.max = 1, \dots)
}
\arguments{
    \item{x}{The imaging dataset for which to calculate the FastMap components.}
    \item{r}{The neighborhood spatial smoothing radius.}
    \item{ncomp}{The number of FastMap components to calculate.}
    \item{method}{The method to use to calculate the spatial smoothing kernels for the embedding. The 'gaussian' method refers to spatially-aware (SA) weights, and 'adaptive' refers to spatially-aware structurally-adaptive (SASA) weights.}
    \item{iter.max}{The number of iterations to perform when choosing the pivot vectors for each dimension.}
    \item{\dots}{Ignored.}
}
\value{
    An object of class \code{SpatialFastmap}, which is a \code{ResultSet}, where each component of the \code{resultData} slot contains at least the following components:

    \describe{
        \item{\code{scores}:}{A matrix with the FastMap component scores.}
        \item{\code{cor}:}{A matrix with the feature correlations with each FastMap projection.}
        \item{\code{sdev}:}{The standard deviations of the FastMap scores.}
        \item{\code{method}:}{The method used to calculate the spatially-aware weights.}
        \item{\code{ncomp}:}{The number of FastMap components calculated.}
        \item{\code{r}:}{The neighborhood spatial smoothing radius.}
        \item{\code{pivot.array}:}{The pixel IDs of the selected pivot vectors for each FastMap dimension.}
    }
}
\author{
	Kylie A. Bemis
}
\seealso{
    \code{\link{PCA}},
    \code{\link{spatialKMeans}},
    \code{\link{spatialShrunkenCentroids}}
}
\examples{
sset <- generateImage(diag(4), range=c(200, 300), step=1)

fmap <- spatialFastmap(sset, ncomp=2)
}
\keyword{spatial}
