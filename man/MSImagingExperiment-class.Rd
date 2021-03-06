\name{MSImagingExperiment-class}
\docType{class}

\alias{class:MSImagingExperiment}
\alias{MSImagingExperiment}
\alias{MSImagingExperiment-class}

\alias{spectraData}
\alias{spectraData<-}
\alias{spectraData-methods}

\alias{spectra}
\alias{spectra<-}
\alias{spectra-methods}

\alias{peaks}
\alias{peaks<-}
\alias{peaks-methods}

\alias{peakData}
\alias{peakData<-}
\alias{peakData-methods}

\alias{isCentroided}

\alias{centroided}
\alias{centroided<-}

\alias{show,MSImagingExperiment-method}
\alias{spectraData,MSImagingExperiment-method}
\alias{spectraData<-,MSImagingExperiment-method}
\alias{spectra,MSImagingExperiment-method}
\alias{spectra<-,MSImagingExperiment-method}
\alias{mz,MSImagingExperiment-method}
\alias{mz<-,MSImagingExperiment-method}
\alias{resolution,MSImagingExperiment-method}
\alias{resolution<-,MSImagingExperiment-method}
\alias{centroided,MSImagingExperiment-method}
\alias{centroided<-,MSImagingExperiment-method}
\alias{pixels,MSImagingExperiment-method}
\alias{features,MSImagingExperiment-method}
\alias{cbind,MSImagingExperiment-method}
\alias{rbind,MSImagingExperiment-method}
\alias{collect,MSImagingExperiment-method}

\alias{peaks,MSImagingExperiment-method}
\alias{peaks<-,MSImagingExperiment-method}
\alias{peakData,MSImagingExperiment-method}
\alias{peakData<-,MSImagingExperiment-method}
\alias{isCentroided,MSImagingExperiment-method}

\title{MSImagingExperiment: Mass spectrometry imaging experiments}

\description{
   The \code{MSImagingExperiment} class is designed for mass spectrometry imaging experimental data and metadata. It is designed to contain full MSI experiments, including multiple runs and replicates, potentially across multiple files. Both 2D and 3D imaging experiments are supported, as well as any type of experimental metadata such as diagnosis, subject, time point, etc.
}

\usage{
## Instance creation
MSImagingExperiment(
    imageData = matrix(nrow=0, ncol=0),
    featureData = MassDataFrame(),
    pixelData = PositionDataFrame(),
    metadata = list(),
    processing = SimpleList(),
    centroided = FALSE)

## Additional methods documented below
}

\arguments{
    \item{imageData}{Either a matrix-like object with number of rows equal to the number of features and number of columns equal to the number of pixels, or an \code{\linkS4class{ImageArrayList}}.}

    \item{featureData}{A \code{\linkS4class{MassDataFrame}} with feature metadata, with a row for each m/z value.}

    \item{pixelData}{A \code{\linkS4class{PositionDataFrame}} with pixel metadata, with a row for each pixel.}

    \item{metadata}{A \code{list} with experimental-level metadata.}

    \item{processing}{A \code{\linkS4class{SimpleList}} with processing steps. This should typically be empty for new objects.}

    \item{centroided}{\code{FALSE} if the object contains profile spectra and \code{TRUE} if the spectra have been peak-picked and centroided.}
}

\details{
    The \code{MSImagingExperiment} class is designed as a replacement for the \code{\linkS4class{MSImageSet}} class, using a simplified, robust implementation that should be more future-proof and enable better support for large, high-resolution experiments, multimodal experiments, and experiments with specialized needs such as non-gridded pixel coordinates.

   Subclasses \code{\linkS4class{MSContinuousImagingExperiment}} and \code{\linkS4class{MSProcessedImagingExperiment}} exist to allow downstream methods to make assumptions about the underlying data storage (dense matrices for 'continous' format and sparse matrices for 'processed' format), which can sometimes allow more efficient computations.
}

\section{Slots}{
    \describe{
        \item{\code{imageData}:}{An object inheriting from \code{\linkS4class{ImageArrayList}}, storing one or more array-like data elements with conformable dimensions.}

        \item{\code{featureData}:}{Contains feature information in a \code{\linkS4class{MassDataFrame}}. Each row includes the metadata associated with an m/z value.}

        \item{\code{elementMetadata}:}{Contains pixel information in a \code{\linkS4class{PositionDataFrame}}. Each row includes the metadata for a single observation (e.g., a pixel), including specialized slot-columns for tracking pixel coordinates and experimental runs.}

        \item{\code{metadata}:}{A \code{list} containing experiment-level metadata.}

        \item{\code{processing}:}{A \code{\linkS4class{SimpleList}} containing processing steps (including both queued and previously executed processing steps).}

        \item{\code{centroided}:}{\code{FALSE} if the object contains profile spectra and \code{TRUE} if the spectra have been peak-picked and centroided.}
    }
}

\section{Methods}{
    All methods for \code{\linkS4class{ImagingExperiment}} and \code{\linkS4class{SparseImagingExperiment}} also work on \code{MSImagingExperiment} objects. Additional methods are documented below:

    \describe{
        \item{\code{spectraData(object)}, \code{spectraData(object) <- value}:}{Get or set the spectra list (alias for \code{imageData(object)}).}
        
        \item{\code{spectra(object)}, \code{spectra(object) <- value}:}{Get or set the spectra (alias for \code{iData(object)}).}

        \item{\code{mz(object)}, \code{mz(object) <- value}:}{Get or set the m/z values from \code{pixelData}.}

        \item{\code{resolution(object)}, \code{resolution(object) <- value}:}{Get or set the m/z resolution of the dataset. Typically, this should not be set manually.}

        \item{\code{centroided(object)}, \code{centroided(object) <- value}:}{Get or set the spatial position slot-columns from \code{pixelData}.}

        \item{\code{pixels(object, ..., coord, run)}:}{Returns the row indices of \code{pixelData} corresponding to conditions passed via \dots.}

        \item{\code{features(object, ..., mz)}:}{Returns the row indices of \code{featureData} corresponding to conditions passed via \dots.}

        \item{\code{collect(x, ...)}:}{Pull all data elements of \code{imageData} into memory as matrices.}

        \item{\code{peaks(object)}, \code{peaks(object) <- value}:}{Attempt to get or set the matrix of peaks. Alias for \code{spectra()} if \code{centroided()} is TRUE; replacement version also sets \code{centroided} to TRUE.}

        \item{\code{peakData(object)}, \code{peakData(object) <- value}:}{Attempt to get or set the underlying m/z and intensity arrays of the peak data in processed experiments. (Currently only implemented for \code{\linkS4class{MSProcessedImagingExperiment}}).}

        \item{\code{isCentroided(object)}:}{Attempts to infer if the mass spectra are centroided or not (without referencing the \code{centroided} slot.}

        \item{\code{msiInfo(object, ...)}:}{Returns metadata for writing the object to imzML.}

        \item{\code{rbind(...)}, \code{cbind(...)}:}{Combine \code{MSImagingExperiment} objects by row or column.}
    }
}

\author{Kylie A. Bemis}

\seealso{
    \code{\linkS4class{ImagingExperiment}},
    \code{\linkS4class{SparseImagingExperiment}},
    \code{\linkS4class{MSContinuousImagingExperiment}},
    \code{\linkS4class{MSProcessedImagingExperiment}}
}

\examples{
mz <- mz(from=200, to=220, by=400)
coord <- expand.grid(x=1:3, y=1:3)
data <- matrix(runif(length(mz) * nrow(coord)),
    nrow=length(mz), ncol=nrow(coord))

idata <- ImageArrayList(data)
fdata <- MassDataFrame(mz=mz)
pdata <- PositionDataFrame(coord=coord)

x <- MSImagingExperiment(
    imageData=idata,
    featureData=fdata,
    pixelData=pdata)

print(x)
}

\keyword{classes}
