% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/TOUR.R
\name{TOUR}
\alias{TOUR}
\alias{as.TOUR}
\alias{as.TOUR.numeric}
\alias{as.TOUR.integer}
\alias{print.TOUR}
\title{Class TOUR -- Solution to a traveling salesperson problem}
\usage{
TOUR(x, method = NA, tsp = NULL)

as.TOUR(object)

\method{as.TOUR}{numeric}(object)

\method{as.TOUR}{integer}(object)

\method{print}{TOUR}(x, ...)
}
\arguments{
\item{x}{an integer permutation vector or, for the methods an object of
class \link{TOUR}.}

\item{method}{character string; method used to create the tour.}

\item{tsp}{\code{TSP} object the tour applies to. If available then the tour
will include the tour length. Also the labels of the cities will be
available in the tour (otherwise the labels of \code{x} are used).}

\item{object}{data (an integer vector) which can be coerced to \code{TOUR}.}

\item{...}{further arguments are passed on.}
}
\description{
Class to store the solution of a TSP. Objects of this class are returned by
TSP solvers in this package.  Essentially, an object of class \code{TOUR} is
a permutation vector containing the order of cities to visit.
}
\details{
Since an object of class \code{TOUR} is an integer vector, it can be
subsetted as an ordinary vector or coerced to an integer vector using
\code{as.integer()}. It also contains the names of the objects as labels.
Additionally, \code{TOUR} has the following attributes: \code{"method"},
\code{"tour_length"}.

For most functions, e.g., \code{\link[=tour_length]{tour_length()}} or \code{\link[=image.TSP]{image.TSP()}}, the
\code{TSP/ATSP} object used to find the tour is still needed, since the tour
does not contain the distance information.
}
\examples{
TOUR(1:10)

## calculate a tour
data("USCA50")
tour <- solve_TSP(USCA50)
tour

## get tour length directly from tour
tour_length(tour)

## get permutation vector
as.integer(tour)

## show labels
labels(tour)
}
\seealso{
Other TOUR: 
\code{\link{cut_tour}()},
\code{\link{solve_TSP}()},
\code{\link{tour_length}()}
}
\author{
Michael Hahsler
}
\concept{TOUR}
\keyword{classes}
