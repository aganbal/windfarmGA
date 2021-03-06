#' @title Plot if previous population was better or worse
#' @name plotbeorwor
#' @description  Plot the changes in mean and max fitness values to previous
#' generation.
#'
#' @export
#'
#' @importFrom graphics plot par abline title
#'
#' @param result The output matrix of \code{\link{windfarmGA}} or
#' \code{\link{genAlgo}}, which has stored all relevant information. (matrix)
#'
#' @return NULL
#' @examples \donttest{
#' ## Add some data examples from the package
#' load(file = system.file("extdata/resulthex.rda", package = "windfarmGA"))
#'
#' ## Plot the results of a hexagonal grid optimization
#' result <- resulthex
#' plotbeorwor(result)
#' }
#' @author Sebastian Gatscha
plotbeorwor <- function(result){
  parbeorwo <- par(ask=F, no.readonly = T)
  on.exit(par(parbeorwo))
  
  beorworse <- do.call("rbind",result[,9]);

  par(mfrow=c(2,1))
  maxdif <- as.data.frame(beorworse[,1]);
  maxdif$farbe <- 0
  maxdif$farbe[maxdif$`beorworse[, 1]` < 0]  <- "red"
  maxdif$farbe[maxdif$`beorworse[, 1]` > 0] <- "green"
  maxdif$farbe[maxdif$`beorworse[, 1]` == 0] <- "orange"
  plot(maxdif$`beorworse[, 1]`, type="b", col=maxdif$farbe, pch=20,cex=2); abline(0,0)
  title("Max Difference to previous generation")


  meandif <- as.data.frame(beorworse[,2]);
  meandif$farbe <- 0
  meandif$farbe[meandif$`beorworse[, 2]` < 0]  <- "red"
  meandif$farbe[meandif$`beorworse[, 2]` > 0] <- "green"
  meandif$farbe[meandif$`beorworse[, 2]` == 0] <- "orange"
  plot(meandif$`beorworse[, 2]`, type="b", col=meandif$farbe, pch=20,cex=2); abline(0,0)
  title("Mean Difference to previous generation")

  return()
}

