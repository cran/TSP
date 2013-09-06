\name{TSPLIB}
\alias{TSPLIB}
\alias{write_TSPLIB}
\alias{write_TSPLIB.TSP}
\alias{write_TSPLIB.ATSP}
\alias{read_TSPLIB}
\title{Read and write TSPLIB files}
\description{
Reads and writes TSPLIB format files. TSPLIB files can be used by most
TSP solvers. Sample instances for the TSP in TSPLIB format are available 
on the TSPLIB homepage (see references).
}
\usage{
write_TSPLIB(x, file, precision = 6, inf = NULL, neg_inf = NULL)
read_TSPLIB(file, precision = 0)
}
\arguments{
  \item{x}{ an object of class \code{TSP} or \code{ATSP}.}
  \item{file}{ file name or a \code{connection}.  }
  \item{precision}{ controls the number of decimal places used to represent
      distances (see details).  If \code{x} already is \code{integer}, this
      argument is ignored and \code{x} is used as is.}
  \item{inf}{ replacement value for \code{Inf} (TSPLIB format cannot handle
      \code{Inf}). If \code{inf} is \code{NULL}, the default value of 2 times
      the maximum value in \code{x} (ignoring the infinity entries) is used.}
  \item{neg_inf}{ replacement value for \code{-Inf}. 
      If no value is specified, the default value of
      2 times the smalles neg. number is used. 
      If \code{x} only contains positive
      values, -1 is used.}
}
\details{
In the TSPLIB format distances are represented by integer values. Therefore, if
\code{x} contains \code{double} values (which is normal in R) the values given
in \code{x} are multiplied by \eqn{10^{precision}} before coercion to
\code{integer}. Note that therefore all results produced by programs using the
TSPLIB file as input need to be divided by \eqn{10^{precision}} (i.e., the
decimal point has to be shifted \code{precision} placed to the left).

Currently only \code{EDGE\_WEIGHT\_TYPE} \code{EXPLICIT} is implemented!
}
\value{
\code{read_TSPLIB} returns an object of class \code{TSP} or \code{ATSP}.
}
\references{TSPLIB home page, 
\url{http://www.iwr.uni-heidelberg.de/groups/comopt/software/TSPLIB95/}}
\keyword{file}% at least one, from doc/KEYWORDS
