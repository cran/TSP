\name{TOUR}
\alias{TOUR}
\alias{print.TOUR}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Class TOUR -- Solution to a traveling salesperson problem}
\description{
  Class to store the solution of a TSP.
  Essentially, an object of class \code{TOUR} is an integer vector
  containing the order of cities to visit.
}
\usage{
\method{print}{TOUR}(x, \ldots)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{ an object of class \code{TOUR}}.
  \item{\ldots}{ further arguments are passed on.}
}
\details{
Since an object of class \code{TOUR} is an integer vector, it can be 
subsetted as an ordinary vector or coerced to vector using \code{as.vector}.
Additionally, \code{TOUR} has the following attributes: 
\code{"method"}, \code{"tour_length"}.

For most functions, e.g., \code{tour_length} or \code{image}, the \code{TSP}
object used to find the tour is still needed, since the tour does not contain
the distance information.
}
%\value{
%}
%\references{}
%\author{}
\seealso{
\code{\link{TSP}},
\code{\link{tour_length}},
\code{\link{image}}.
}
\examples{
data("iris")
tsp <- TSP(dist(iris[1:4]))

## calculate a tour
tour <- solve_TSP(tsp)
tour

str(tour)
}
\keyword{classes}% at least one, from doc/KEYWORDS
