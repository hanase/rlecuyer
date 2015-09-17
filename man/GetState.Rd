\name{GetState}
\alias{.lec.GetState}
\title{Return current state of a stream}
\description{Returns current state (Cg values) of the stream \code{name}.}
\usage{.lec.GetState (name)
}
\arguments{
  \item{name}{a character string giving the name of the stream.}
}
\value{a vector of six integer values that identifies the current state of the
  stream.}
\keyword{distribution}
\seealso{\code{\link[rlecuyer]{SetPackageSeed}}}
