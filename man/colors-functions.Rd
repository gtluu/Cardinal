\name{intensity.colors}

\alias{col.map}
\alias{color.map}
\alias{intensity.colors}
\alias{jet.colors}
\alias{divergent.colors}
\alias{risk.colors}
\alias{gradient.colors}
\alias{bw.colors}
\alias{discrete.colors}
\alias{alpha.colors}

\alias{darkmode}
\alias{lightmode}

\title{Color palettes for imaging}

\description{
	Create a vector of \code{n} continuous or discrete colors.
}

\usage{
color.map(map = c("redblack", "greenblack", "blueblack",
    "viridis", "cividis", "magma", "inferno", "plasma",
    "rainbow", "darkrainbow", "grayscale",
    "jet", "hot", "cool"), n = 100)

col.map(\dots)

intensity.colors(n = 100, alpha = 1)

jet.colors(n = 100, alpha = 1)

divergent.colors(n = 100, start = "#00AAEE",
    middle = "#FFFFFF", end = "#EE2200", alpha = 1)

risk.colors(n = 100, alpha = 1)

gradient.colors(n = 100, start = "#000000",
    end = "#00AAFF", alpha = 1)

bw.colors(n = 100, alpha = 1)

discrete.colors(n = 2, chroma = 150, luminance = 65, alpha = 1)

alpha.colors(col, n = 100,
    alpha = (seq_len(n)/n)^alpha.power,
    alpha.power = 2)

darkmode()

lightmode()
}

\arguments{
    \item{map}{the name of the colormap}
    \item{n}{the number of colors}
    \item{\dots}{arguments passed to \code{color.map()}}
    \item{alpha}{a vector of alpha values between 0 and 1}
    \item{start}{the start color value}
    \item{middle}{the middle color value}
    \item{end}{the end color value}
    \item{chroma}{the chroma of the color}
    \item{luminance}{the luminance of the color}
    \item{col}{the color(s) to expand with transparency}
    \item{alpha.power}{how the alpha should ramp as it increases}
}
\details{
    Most of these functions return a vector of colors.

    Several of the options made available by \code{color.map} are borrowed from the \code{viridisLite} package, including 'viridis', 'cividis', 'magma', 'inferno', and 'plasma'. The original functions for these color palettes are also re-exported for use by users. See the documention for them in that package.

    The \code{darkmode} and \code{lightmode} functions change the graphical parameters for the current graphics device accordingly. The new themes will be used for any subsequent plots.
}
\value{
	A palette of colors.
}
\author{
	Kylie A. Bemis
}
\seealso{
    \code{\link{viridis}},
    \code{\link{cividis}},
    \code{\link{magma}},
    \code{\link{inferno}},
    \code{\link{plasma}}
}
\examples{
col <- gradient.colors(100^2)
if ( interactive() )
	image(matrix(1:(100^2), nrow=100), col=col)
}

\keyword{color}

