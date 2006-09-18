\name{Concorde}
\alias{tsp_concorde_help}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Concorde TSP solver}
\description{
  The Concorde TSP solver (Applegate et al. 2001) is currently one of the most
  advanced and fastest TSP solvers. This solver is freely available for
  academic research and has to be obtained separately from the Concorde web
  site (see details).
}
\usage{
## obtain a list of command line options for Concorde
tsp_concorde_help(exe = NULL)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{exe}{ an optional character string containing the whole path to the
      executable (including the executable's name). If this option is not used,
      the Concorde executable is expected to be either installed
      somewhere in the search path or that the environment variable
      \code{"R\_CONCORDE"} contains the path to the executable (including the
      executable's name).}
}
\details{
The executable program Concorde is not included in this package and has to be
obtained separately from the Concorde web site (see references).  Unpack the
program, place it in a convenient directory (either a directory which is in the
search path or set the environment variable \code{"R\_CONCORDE"}). Make
sure the program is executable. 

To get a list of all available command line options which can be used
via the \code{clo} option for \code{solve_TSP} use
\code{tsp\_concorde\_help()}.  Several options (\option{-x},
\option{-o}, \option{-N}) are not available via \code{solve_TSP} since
they are used by the interface.  }
%\value{
%}
\seealso{
\code{\link{solve_TSP}}
}
\references{
Concorde home page \url{http://www.tsp.gatech.edu/concorde/}

Concorde download page 
\url{http://www.tsp.gatech.edu/concorde/downloads/downloads.htm}

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
%\examples{
%}
\keyword{documentation}% at least one, from doc/KEYWORDS
