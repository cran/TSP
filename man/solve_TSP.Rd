\name{solve_TSP}
\alias{solve_TSP}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{TSP solver interface}
\description{
  Common interface to all symmetric TSP solvers in this package.
}
\usage{
solve_TSP(x, method, control)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{ the TSP given as an object of class \code{TSP}.}
  \item{method}{ method to solve the TSP (default: farthest insertion 
      algorithm; see details). }
  \item{control}{ a list of arguments passed on to the TSP solver
      selected by \code{method}.}
}
\details{
Currently the following methods are available:
\describe{
    \item{\code{"nearest_insertion", "farthest_insertion"}}{
        Nearest and farthest insertion algorithms for a symmetric TSP (Johnson
        and Papadimitriou 1985).  
        
        The two algorithms are variants of the
        minimum spanning tree algorithm for obtaining solutions to the
        traveling salesperson problem.  The distances between cities are stored
        in a distance matrix \eqn{D} with elements \eqn{d(i,j)}.

        The nearest insertion algorithm starts with a partial tour consisting
        of a single, arbitrarily chosen city. As long as not all cities are on
        the tour, find the city \eqn{k} which is \emph{nearest} to a city on
        the tour. Next insert city \eqn{k} into the tour between two
        consecutive cities \eqn{i} and \eqn{j}, such that \eqn{d(i,k) + d(k,j)
        - d(i,j)} is minimized.  Repeat till all cities are on the tour.

        The farthest insertion algorithm used the \emph{farthest} instead of
        the \emph{nearest} city. The idea behind this choice is to link cities
        far away into the tour fist to establish an outline of the whole tour
        early.
        
        Additional control options: \code{start} index of the first city 
        (default: random city)
        }
    
    \item{\code{"greedy"}}{ Greedy algorithm for a symmetric TSP. The algorithm
        is often also called nearest neighbor algorithm (Johnson and
        Papadimitriou 1985).

        The algorithm starts with a tour containing a random city. Then the
        algorithm always adds to last city in the tour the nearest not yet
        visited city. The algorithm stops when all cities are on the tour.
        
        Additional control options: \code{start} index of the first city 
        (default: random city)
        }
    
    \item{\code{"concorde"}}{Concorde algorithm (Applegate et al. 2001).
        
          Concorde is an advanced TSP solver. The program is not included in
          this package and has to be obtained and installed separately (see
          \code{\link{tsp_concorde_help}}).

          Additional control options: 
          
          \code{exe} character string containing the path to the executable 
          (see \code{tsp_concorde_help})

          \code{clo} character string containing command line options for
Concorde, e.g., \code{control = list(clo = "-B -v")}. See
\code{tsp_concorde_help} on how to obtain a complete list of available
command line options. 

          \code{precision} an integer which controls the number of
decimal places used for the internal representation of distances in Concorde.
The values given in \code{x} are multiplied by \eqn{10^{precision}} before
being passed on to Concorde. Note that therefore the results produced by
Concorde (especially lower and upper bounds) need to be divided by
\eqn{10^{precision}} (i.e., the decimal point has to be shifted
\code{precision} placed to the left). Note also, that Concorde cannot handle
\code{Inf} which is therefore replaced by 2 times the maximum value in \code{x}
(ignoring the infinity entries). The interface to Concorde uses 
\code{write_TSPLIB} (see there for more information).
        }
}
}
\value{
An object of class \code{TOUR}.
}
\seealso{
\code{\link{TOUR}},
\code{\link{TSP}},
\code{\link{write_TSPLIB}},
\code{\link{tsp_concorde_help}}.
}
\references{
Concorde home page \url{http://www.tsp.gatech.edu/concorde/}

David Appletgate, Robert Bixby, Vasek Chvatal, William Cook (2001):
TSP cuts which do not conform to the template paradigm,
Computational Combinatorial Optimization, M. Junger and D. Naddef (editors),
Springer.

D. S. Johnson, C. H. Papadimitriou (1985): Performance guarantees for
heuristics (chapter 5). In: E. L. Lawler, J. K. Lenstra, A.H.G. Rinnooy Kan, D.
B. Shmoys (eds.) The traveling salesman problem - A guided tour of
combinatorial optimization, Wiley \& Sons.
}
%\author{Michael Hahsler}
\examples{
data("iris")

## create TSP
tsp <- TSP(dist(iris[1:4]))

## reorder
tour1 <- solve_TSP(tsp)
tour2 <- solve_TSP(tsp, method = "nearest_insertion")
tour3 <- solve_TSP(tsp, method = "greedy", control = list(start = 1)) 

tour1
tour2
tour3

## use the external solver which has to be installed separately
\dontrun{
tour4 <- solve_TSP(tsp, method = "concorde")
tour4
}
}
\keyword{optimize}% at least one, from doc/KEYWORDS
