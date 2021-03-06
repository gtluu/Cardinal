\name{MIAPE-Imaging-class}
\docType{class}

\alias{class:MIAPE-Imaging}
\alias{MIAPE-Imaging}
\alias{MIAPE-Imaging-class}

\alias{show,MIAPE-Imaging-method}
\alias{abstract,MIAPE-Imaging-method}
\alias{samples,MIAPE-Imaging-method}
\alias{pubMedIds,MIAPE-Imaging-method}
\alias{pubMedIds<-,MIAPE-Imaging,ANY-method}
\alias{otherInfo,MIAPE-Imaging-method}
\alias{expinfo,MIAPE-Imaging-method}
\alias{notes,MIAPE-Imaging-method}
\alias{notes<-,MIAPE-Imaging,character-method}
\alias{notes<-,MIAPE-Imaging,list-method}
\alias{preproc,MIAPE-Imaging-method}
\alias{preproc<-,MIAPE-Imaging-method}
\alias{combine,MIAPE-Imaging,MIAPE-Imaging-method}

\alias{msiInfo,MIAPE-Imaging-method}
\alias{specimenOrigin}
\alias{specimenOrigin,MIAPE-Imaging-method}
\alias{specimenType}
\alias{specimenType,MIAPE-Imaging-method}
\alias{stainingMethod}
\alias{stainingMethod,MIAPE-Imaging-method}
\alias{tissueThickness}
\alias{tissueThickness,MIAPE-Imaging-method}
\alias{tissueWash}
\alias{tissueWash,MIAPE-Imaging-method}
\alias{embeddingMethod}
\alias{embeddingMethod,MIAPE-Imaging-method}
\alias{inSituChemistry}
\alias{inSituChemistry,MIAPE-Imaging-method}

\alias{matrixApplication,MIAPE-Imaging-method}
\alias{pixelSize,MIAPE-Imaging-method}
\alias{instrumentModel,MIAPE-Imaging-method}
\alias{instrumentVendor,MIAPE-Imaging-method}
\alias{massAnalyzerType,MIAPE-Imaging-method}
\alias{ionizationType,MIAPE-Imaging-method}
\alias{scanPolarity,MIAPE-Imaging-method}
\alias{softwareName}
\alias{softwareName,MIAPE-Imaging-method}
\alias{softwareVersion}
\alias{softwareVersion,MIAPE-Imaging-method}

\alias{scanType,MIAPE-Imaging-method}
\alias{scanPattern,MIAPE-Imaging-method}
\alias{scanDirection,MIAPE-Imaging-method}
\alias{lineScanDirection,MIAPE-Imaging-method}

\alias{imageShape}
\alias{imageShape,MIAPE-Imaging-method}

\title{MIAPE-Imaging: Class for storing mass spectrometry imaging experiment information}

\description{
    The Minimum Information About a Proteomics Experiment for MS Imaging. The current implementation is based on the imzML specification.
}

\section{Slots}{
    \describe{
        \item{\code{name}:}{Object of class \code{character} containing the experimenter name}
        
        \item{\code{lab}:}{Object of class \code{character} containing the laboratory where the experiment was conducted.}
        
        \item{\code{contact}:}{Object of class \code{character} containing contact information for lab and/or experimenter.}

        \item{\code{title}:}{Object of class \code{character} containing a single-sentence experiment title.}

        \item{\code{abstract}:}{Object of class \code{character} containing an abstract describing the experiment.}
        
        \item{\code{url}:}{Object of class \code{character} containing a URL for the experiment.}
        
        \item{\code{pubMedIds}:}{Object of class \code{character} listing strings of PubMed identifiers of papers relevant to the dataset.}

        \item{\code{samples}:}{Object of class \code{list} containing information about the samples.}
        
        \item{\code{preprocessing}:}{Object of class \code{list} containing information about the pre-processing steps used on the raw data from this experiment.}
        
        \item{\code{other}:}{Object of class \code{list} containing other information for which none of the above slots does not applies.}
                
        \item{\code{specimenOrigin}:}{Object of class \code{character} describing the specimen origin (institution, \ldots).}

        \item{\code{specimenType}:}{Object of class \code{character} describing the specimen type (species, organ, \ldots).}

        \item{\code{stainingMethod}:}{Object of class \code{character} describing the staining method, if any, applied to the sample (H&E, \ldots).}

        \item{\code{tissueThickness}:}{Object of class \code{numeric} giving the tissue thickness in micrometers (um).}

        \item{\code{tissueWash}:}{Object of class \code{character} describing the wash method (spray, dipping, \ldots).}

        \item{\code{embeddingMethod}:}{Object of class \code{character} describing the embedding method (if any); this could be paraffin, \ldots}

        \item{\code{inSituChemistry}:}{Object of class \code{character} describing any on-sample chemistry (tryptic digest, \ldots)}

        \item{\code{matrixApplication}:}{Object of class \code{character} describing how the matrix was applied, if applicable}

        \item{\code{pixelSize}:}{Object of class \code{numeric} describing the size of the pixels in micrometers (um).}

        \item{\code{instrumentModel}:}{Object of class \code{character} indicating the instrument model used to generate the data.}
        
        \item{\code{instrumentVendor}:}{Object of class \code{character} indicating the mass spectrometer vendor.}

        \item{\code{massAnalyzerType}:}{Object of class \code{character} describing the mass analyzer type (LTQ, TOF, \dots).}

        \item{\code{ionizationType}:}{Object of class \code{character} describing the ionization type (MALDI, DESI, \dots).}

        \item{\code{scanPolarity}:}{Object of class \code{character} describing the polarity (negative or positive).}
                
        \item{\code{softwareName}:}{Object of class \code{character} with the control and/or analysis software name.}
        
        \item{\code{softwareVersion}:}{Object of class \code{character} with the version of the control and/or analysis software.}

        \item{\code{scanType}:}{Object of class \code{character} describing the scan type. This must be either 'horizontal line scan' or 'vertical line scan'. See the imzML specifications for more details.}

        \item{\code{scanPattern}:}{Object of class \code{character} describing the scan type. This must be one of 'flyback', 'meandering', or 'random access'. See the imzML specifications for more details.}

        \item{\code{scanDirection}:}{Object of class \code{character} describing the scan type. This must be one of 'bottom up', 'left right', 'right left', or 'top down'. See the imzML specifications for more details.}

        \item{\code{lineScanDirection}:}{Object of class \code{character} describing the scan type. This must be one of 'linescan bottom up', 'linescan left right', 'linescan right left', or 'linescan top down'. See the imzML specifications for more details.}

        \item{\code{imageShape}:}{Object of class \code{character} describing the image shape (rectangular, free form, \ldots). See the imzML specifications for more details.}
    }
}

\section{Extends}{
   Class \code{\linkS4class{MIAxE}}, directly,
   Class \code{\linkS4class{Versioned}}, by class "MIAxE", distance 2.
}

\section{Creating Objects}{
    \code{MIAPE-Imaging} instances can be created through \code{new("MIAPE-Imaging")}. In general, instances should not be created by the user, but are automatically generated when reading an external file to create an \code{\linkS4class{MSImageSet}} object, and then modified through the accessor and setter methods if necessary.
}

\section{Methods}{
    Class-specific methods:
    \describe{
        \item{\code{msiInfo}:}{Displays 'MIAPE-Imaging' information.}

        \item{\code{abstract}:}{An accessor function for \code{abstract}. }
        
        \item{\code{expinfo}:}{An accessor function for \code{name}, \code{lab}, \code{contact}, \code{title}, and \code{url}.} 
        
        \item{\code{notes(object), notes(object) <- value}:}{Accessor functions for \code{other}. \code{notes(object) <- character} \emph{appends} character to notes; use \code{notes(object) <- list} to replace the notes entirely.} 
        
        \item{\code{otherInfo}:}{An accessor function for \code{other}.} 
        
        \item{\code{preproc}:}{An accessor function for \code{preprocessing}.} 
        
        \item{\code{pubMedIds(object), pubMedIds(object) <- value}:}{Accessor function for \code{pubMedIds}.} 

        \item{\code{samples}:}{An accessor function for \code{samples}.}

        \item{\code{specimenOrigin(object)}:}{Accessor function for \code{specimenOrigin}.}

        \item{\code{specimenType(object)}:}{Accessor function for \code{specimenType}.}

        \item{\code{stainingMethod(object)}:}{Accessor function for \code{stainingMethod}.}

        \item{\code{tissueThickness(object)}:}{Accessor function for \code{tissueThickness}.}

        \item{\code{tissueWash(object)}:}{Accessor function for \code{tissueWash}.}

        \item{\code{embeddingMethod(object)}:}{Accessor function for \code{embeddingMethod}.}

        \item{\code{inSituChemistry(object)}:}{Accessor function for \code{inSituChemistry}.}

        \item{\code{matrixApplication(object)}:}{Accessor function for \code{matrixApplication}.}

        \item{\code{pixelSize(object)}:}{Accessor function for \code{pixelSize}.}

        \item{\code{imageShape(object)}:}{Accessor function for \code{imageShape}.}

        \item{\code{instrumentModel(object)}:}{Accessor function for \code{instrumentModel}.}
        
        \item{\code{instrumentVendor(object)}:}{Accessor function for \code{instrumentVendor}.}

        \item{\code{massAnalyzerType(object)}:}{Accessor function for \code{massAnalyzerType}.}

        \item{\code{ionizationType(object)}:}{Accessor function for \code{ionizationType}.}

        \item{\code{scanPolarity(object)}:}{Accessor function for \code{scanPolarity}.}
                
        \item{\code{softwareName(object)}:}{Accessor function for \code{softwareName}.}
        
        \item{\code{softwareVersion(object)}:}{Accessor function for \code{softwareVersion}.}

        \item{\code{scanType(object)}:}{Accessor function for \code{scanType}.}

        \item{\code{scanPattern(object)}:}{Accessor function for \code{scanPattern}.}

        \item{\code{scanDirection(object)}:}{Accessor function for \code{scanDirection}.}

        \item{\code{lineScanDirection(object)}:}{Accessor function for \code{lineScanDirection}.}
    }

    Standard generic methods:
    \describe{
        \item{\code{show}:}{Displays object content.}

        \item{\code{combine(x, y, ...)}:}{Combine two or more \code{MIAPE-Imaging} objects.}
    }
}

\author{Kylie A. Bemis}

\references{
    Schramm T, Hester A, Klinkert I, Both J-P, Heeren RMA, Brunelle A, Laprevote O, Desbenoit N, Robbe M-F, Stoeckli M, Spengler B, Rompp A (2012) imzML - A common data format for the flexible exchange and processing of mass spectrometry imaging data. Journal of Proteomics 75 (16):5106-5110. doi:10.1016/j.jprot.2012.07.026
}

\seealso{
    \code{\linkS4class{MIAxE}},
    \code{\linkS4class{MSImageSet}}
}

\examples{
showClass("MIAPE-Imaging")
}

\keyword{classes}
