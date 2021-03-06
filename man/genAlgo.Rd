% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/genAlgo.R
\name{genAlgo}
\alias{genAlgo}
\title{Start The Genetic Algorithm for a wind Farm Layout}
\usage{
genAlgo(Polygon1, GridMethod, Rotor, n, fcrR, referenceHeight, RotorHeight,
  SurfaceRoughness, Proportionality, iteration, mutr, vdirspe, topograp,
  elitism, nelit, selstate, crossPart1, trimForce, Projection, sourceCCL,
  sourceCCLRoughness, weibull, weibullsrc, Parallel, numCluster)
}
\arguments{
\item{Polygon1}{The considered area as shapefile (SpatialPolygons)}

\item{GridMethod}{Should the polygon be divided into rectangular or
hexagonal grid cells? The default is "Rectangular" grid cells and hexagonal
grid cells are computed when assigning "h" or "hexagon" to this input
variable. (character)}

\item{Rotor}{A numeric value that gives the rotor radius in meter
(numeric)}

\item{n}{A numeric value indicating the required amount of turbines
(numeric)}

\item{fcrR}{A numeric value that is used for grid spacing (numeric)}

\item{referenceHeight}{The height at which the incoming
wind speeds were measured. (numeric)}

\item{RotorHeight}{The desired height of the turbine.
(numeric)}

\item{SurfaceRoughness}{A surface roughness length of the
considered area in m.  If the terrain effect model is activated, a
surface roughness will be calculated for every grid cell with the
elevation and land cover information. (numeric)}

\item{Proportionality}{A numeric factor used for grid calculation.
Determines the percentage a grid has to overlay (numeric)}

\item{iteration}{A numeric value indicating the desired amount
of iterations of the algorithm (numeric)}

\item{mutr}{A numeric mutation rate with low default value of 0.008
(numeric)}

\item{vdirspe}{A data.frame containing the incoming wind speeds,
wind directions and probabilities (data.frame)}

\item{topograp}{Logical value, which indicates if the terrain effect model
should be activated or not. (logical)}

\item{elitism}{Boolean value, which indicates whether elitism should
be included or not. (logical)}

\item{nelit}{If \code{elitism} is TRUE, then this input variable
determines the amount of individuals in the elite group. (numeric)}

\item{selstate}{Determines which selection method is used,
"FIX" selects a constant percentage and "VAR" selects a variable percentage,
depending on the development of the fitness values. (character)}

\item{crossPart1}{Determines which crossover method is used,
"EQU" divides the genetic code at equal intervals and
"RAN" divides the genetic code at random locations. (character)}

\item{trimForce}{If activated (\code{trimForce}==TRUE),
the algorithm will take a probabilistic approach to trim the windfarms
to the desired amount of turbines. If deactivated
(\code{trimForce}==FALSE) the adjustment will be random.
(logical)}

\item{Projection}{A desired Projection can be used instead
of the default Lambert Azimuthal Equal Area Projection. (character)}

\item{sourceCCL}{The source to the Corine Land Cover raster (.tif). Only
required when the terrain effect model is activated. (character)}

\item{sourceCCLRoughness}{The source to the adapted
Corine Land Cover legend as .csv file. Only required when terrain
effect model is activated. As default a .csv file within this
package (\file{~/extdata}) is taken that was already adapted
manually. To use your own .csv legend this variable has to be assigned.
See Details. (character)}

\item{weibull}{A logical value that specifies whether to take Weibull
parameters into account. If weibull==TRUE, the wind speed values from the
'dirSpeed' data frame are ignored. The algorithm will calculate the mean
wind speed for every wind turbine according to the Weibull parameters.
(logical)}

\item{weibullsrc}{A list of Weibull parameter rasters, where the first list
item must be the shape parameter raster k and the second item must be the
scale parameter raster a of the Weibull distribution. If no list is given,
then rasters included in the package are used instead, which currently
only cover Austria. This variable is only used if weibull==TRUE. (list)}

\item{Parallel}{Boolean value, indicating whether parallel processing
should be used. The parallel and doParallel packages are used for parallel
processing.}

\item{numCluster}{If Parallel is TRUE, this variable defines the number
of clusters to be used.}
}
\value{
The result of this run is a matrix of all relevant output
parameters. This output can be used for several plotting functions.
(matrix)
}
\description{
This function coordinates all other elements of the
genetic algorithm. To initiate an optimization run, this method has to
be called with the desired inputs. To be able to include the terrain effect
model, the source of the Corine Land cover raster has to be given.
This function will not control user inputs before an optimization process.
It is therefore recommended to start an optimization run with
the \code{\link{windfarmGA}} function.
}
\examples{
\donttest{
## Create a random rectangular shapefile
library(sp)
Polygon1 <- Polygon(rbind(c(4498482, 2668272), c(4498482, 2669343),
                          c(4499991, 2669343), c(4499991, 2668272)))
Polygon1 <- Polygons(list(Polygon1), 1);
Polygon1 <- SpatialPolygons(list(Polygon1))
Projection <- "+proj=laea +lat_0=52 +lon_0=10 +x_0=4321000 +y_0=3210000
+ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs"
proj4string(Polygon1) <- CRS(Projection)
plot(Polygon1,axes=TRUE)

## Create a uniform and unidirectional wind data.frame and plot the
## resulting wind rose
data.in <- as.data.frame(cbind(ws=12,wd=0))
windrosePlot <- plotWindrose(data = data.in, spd = data.in$ws,
                dir = data.in$wd, dirres=10, spdmax=20)

## Runs an optimization run for 10 iterations (iteration) with the
## given shapefile (Polygon1), the wind data.frame (data.in),
## 12 turbines (n) with rotor radii of 30m (Rotor) and a grid spacing
## factor of 5 (fcrR) and other required inputs.
result <- genAlgo(Polygon1 = Polygon1, n=12, Rotor=30,fcrR=5,iteration=10,
             vdirspe = data.in,crossPart1 = "EQU",selstate="FIX",mutr=0.8,
             Proportionality = 1, SurfaceRoughness = 0.3, topograp = FALSE,
             elitism=TRUE, nelit = 7, trimForce = TRUE,
             referenceHeight = 50,RotorHeight = 100)
PlotWindfarmGA(result = result, Polygon1 = Polygon1)

## Runs the same optimization, but with parallel processing and 3 cores.
result_par <- genAlgo(Polygon1 = Polygon1, GridMethod ="h", n=12, Rotor=30,
                 fcrR=5,iteration=10, vdirspe = data.in,crossPart1 = "EQU",
                 selstate="FIX",mutr=0.8, Proportionality = 1,
                 SurfaceRoughness = 0.3, topograp = FALSE,
                 elitism=TRUE, nelit = 7, trimForce = TRUE,
                 referenceHeight = 50,RotorHeight = 100, 
                 Parallel = TRUE, numCluster = 3)
PlotWindfarmGA(result = result_par, GridMethod = "h", Polygon1 = Polygon1)

## Runs the same optimization, this time with hexagonal grids.
result_hex <- genAlgo(Polygon1 = Polygon1, GridMethod ="h", n=12, Rotor=30,
                 fcrR=5,iteration=10, vdirspe = data.in,crossPart1 = "EQU",
                 selstate="FIX",mutr=0.8, Proportionality = 1,
                 SurfaceRoughness = 0.3, topograp = FALSE,
                 elitism=TRUE, nelit = 7, trimForce = TRUE,
                 referenceHeight = 50,RotorHeight = 100)
PlotWindfarmGA(result = result_hex, GridMethod = "h", Polygon1 = Polygon1)

## Run an optimization with the Weibull parameters included in the package.
result_weibull <- genAlgo(Polygon1 = Polygon1, GridMethod ="h", n=12,
                 fcrR=5,iteration=10, vdirspe = data.in,crossPart1 = "EQU",
                 selstate="FIX",mutr=0.8, Proportionality = 1, Rotor=30,
                 SurfaceRoughness = 0.3, topograp = FALSE,
                 elitism=TRUE, nelit = 7, trimForce = TRUE,
                 referenceHeight = 50,RotorHeight = 100,
                 weibull = TRUE)
PlotWindfarmGA(result = result_weibull, GridMethod= "h", Polygon1= Polygon1)

## Run an optimization with given Weibull parameter rasters.
araster <- "/..pathto../a_param_raster.tif"
kraster <- "/..pathto../k_param_raster.tif"
weibullrasters <- list(raster(kraster), raster(araster))
result_weibull <- genAlgo(Polygon1 = Polygon1, GridMethod ="h", n=12,
                 fcrR=5,iteration=10, vdirspe = data.in,crossPart1 = "EQU",
                 selstate="FIX",mutr=0.8, Proportionality = 1, Rotor=30,
                 SurfaceRoughness = 0.3, topograp = FALSE,
                 elitism=TRUE, nelit = 7, trimForce = TRUE,
                 referenceHeight = 50,RotorHeight = 100,
                 weibull = TRUE, weibullsrc = weibullrasters)
PlotWindfarmGA(result = result_weibull, GridMethod= "h", Polygon1= Polygon1)
}
}
\author{
Sebastian Gatscha
}
