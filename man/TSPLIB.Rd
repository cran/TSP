\name{TSPLIB}
\alias{write_TSPLIB}
\alias{read_TSPLIB}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Read and write TSPLIB files}
\description{
Reads and writes TSPLIB format files. TSPLIB files can be used by most
TSP solvers. Sample instances for the TSP in TSPLIB format are available 
on the TSPLIB homepage (see references).
}
\usage{
write_TSPLIB(x, file, precision = 6, inf = NULL)
read_TSPLIB(file, precision = 0)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{ an object of class \code{TSP}.}
  \item{file}{ file name or a \code{connection}.  }
  \item{precision}{ controls the number of decimal places used to represent
      distances (see details). This argument is ignored and \code{x} is used as
      is if \code{x} already is \code{integer}.}
  \item{inf}{ replacement value for \code{Inf} (TSPLIB format cannot handle
      \code{Inf}). If \code{inf} is \code{NULL}, the default value of 2 times
      the maximum value in \code{x} (ignoring the infinity entries) is used.}
}
\details{
In the TSPLIB format distances are represented by integer values. Therefore, if
\code{x} contains \code{double} values (which is normal in R) the values given
in \code{x} are multiplied by \eqn{10^{precision}} before coercion to
\code{integer}. Note that therefore all results produced by programs using the
TSPLIB file as input need to be divided by \eqn{10^{precision}} (i.e., the
decimal point has to be shifted \code{precision} placed to the left).
}
\value{
\code{read_TSPLIB} returns an object of class \code{TSP}.
}
\references{TSPLIB home page \url{http://www.iwr.uni-heidelberg.de/groups/comopt/software/TSPLIB95/}}
%\author{ ~~who you are~~ }
%\seealso{ ~~objects to See Also as \code{\link{help}}, ~~~ }
%\examples{
%}
\keyword{file}% at least one, from doc/KEYWORDS
