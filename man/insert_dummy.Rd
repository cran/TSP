\name{insert_dummy}
\alias{insert_dummy}
\title{Insert dummy cities into a distance matrix}
\description{
   
  Inserts dummy cities into an object of class \code{TSP}.
  A dummy city has constant distance to all other cities and
  is infinitely far from other dummy cities.
  Dummy cities can be used together with TSP solvers to
  find an optimal linear order or to perform
  rearrangement clustering (Climer and Zhang 2006).
  }
\usage{
insert_dummy(x, n = 1, const = max(x), inf = Inf)
}
\arguments{
  \item{x}{an object of class \code{TSP}.}
  \item{n}{number of dummy cities.}
  \item{const}{distance of the dummy cities to all other cities.}
  \item{inf}{distance between dummy cities.}
}
\details{
  The dummy cities are inserted before the other cities in \code{x}. 
}
\seealso{\code{\link{TSP}}}
\references{
Sharlee Climer, Weixiong Zhang (2006): Rearrangement Clustering: Pitfalls,
Remedies, and Applications, \emph{Journal of Machine Learning Research}
\bold{7}(Jun), pp. 919--943.
}
\examples{
data("iris")
tsp <- TSP(dist(iris[1:4]))

## insert 2 dummy cities (as object 1 and 2)
tsp <- insert_dummy(tsp, n = 2)

## get a solution for the TSP
tour <- solve_TSP(tsp, method = "nearest")

## plot the distance matrix
image(tsp, tour)

## draw lines where the dummy cities are located
abline(h=sapply(1:2, FUN = function(i) which(tour == i)), col = "red")
abline(v=sapply(1:2, FUN = function(i) which(tour == i)), col = "red")
}
\keyword{manip}
