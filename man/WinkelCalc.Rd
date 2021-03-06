% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/WinkelCalc.R
\name{WinkelCalc}
\alias{WinkelCalc}
\title{Calculates Angles between 3 Points}
\usage{
WinkelCalc(Aa, Bb, Cc)
}
\arguments{
\item{Aa}{A numeric value with the x and y coordinates of a
potentially influencing turbine (numeric)}

\item{Bb}{A numeric value with the x and y coordinates of the
current turbine (numeric)}

\item{Cc}{A numeric value with the x and y coordinates of the
imaginary right angle (numeric)}
}
\value{
Returns a matrix with the alpha, betha and gamma angles of the
imaginary right triangle (matrix)
}
\description{
Calculates all three angles for an imaginary right triangle
between the actual turbine, the possible influencing turbine and a
right angle. The function works as well with non-right triangles, although
it is not needed for the genetic algorithm, as only the distance
perpendicular to the wind direction and the sidewise distance to the
potentially influencing turbine is required for further calculations.
Point C, where the right angle is located will therefore be calculated
by the algorithm itself. See also \code{\link{PointToLine2}}.
}
\examples{
  Aa= as.numeric(cbind(1,1))
  Bb= as.numeric(cbind(10,3))
  Cc= as.numeric(cbind(10,1))
  plot(rbind(Aa,Bb,Cc,Aa), type="b", xlab="x",
       ylab="y", ylim=c(0,4), xlim=c(0,11));
  points(x=Aa[1],y=Aa[2],col="green",pch=20);
  points(x=Bb[1],y=Bb[2],col="red",pch=20);
  points(x=Cc[1],y=Cc[2],col="blue",pch=20)
  Angles <- WinkelCalc(Aa,Bb,Cc); Angles
  text(rbind(Aa,Bb,Cc),labels=round(Angles,2),pos=1)
}
\author{
Sebastian Gatscha
}
