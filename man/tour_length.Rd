\name{tour_length}
\alias{tour_length}
\title{Calculate the length of a tour}
\description{
Calculate the length of a tour given a TSP and an order.
  }
\usage{
tour_length(x, order)
}
\arguments{
  \item{x}{an object of class \code{TSP}.}
  \item{order}{ optional order of the visited cities
      as a integer vector or an object of class \code{TOUR}.  If no order is
      given, the cities are visited in the original order in \code{x}. }
}
%\details{
%}
\seealso{
\code{\link{TSP}},
\code{\link{TOUR}}.
}
%\references{
%}
\examples{
data("iris")
tsp <- TSP(dist(iris[1:4]))

## original order
tour_length(tsp)

## random tour
tour_length(tsp, sample(1:n_of_cities(tsp)))
}
\keyword{optimize}
