% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/RandomSearch.R
\name{RandomSearch}
\alias{RandomSearch}
\title{RandomSearch Randomise the output of the Genetic Algorithm.}
\usage{
RandomSearch(result, Polygon1, n, best, Plot, GridMethod)
}
\arguments{
\item{result}{The resulting matrix of the function 'genAlgo' or
'windfarmGA'. (matrix)}

\item{Polygon1}{The Polygon for the wind farm area. (SpatialPolygons)}

\item{n}{The number of random searches to be perfomed. Default is 20.
(numeric)}

\item{best}{Which best indidvuals should be the
starting conditions fo a random search. The default is 1. (numeric)}

\item{Plot}{Should the random serach be plotted? Default is TRUE
(boolean)}

\item{GridMethod}{Should the polygon be divided into rectangular or
hexagonal grid cells? The default is rectangular grid cells and hexagonal
grid cells are computed when assigning "h" or "hexagon" to this input
variable. The randomly generated points may also be paced outside of 
their hexagon. (character)}
}
\value{
Returns a list.
}
\description{
Perform a random search in the grid cells, to
further optimize the output of the wind farm layout.
}
\examples{
\donttest{
load(file = system.file("extdata/resultrect.rda", package = "windfarmGA"))
load(file = system.file("extdata/polygon.rda", package = "windfarmGA"))

RandomSearch(resultrect, polygon, n=2, best=4)
}
}
\author{
Sebastian Gatscha
}
