\name{IncreasedPrecis}
\alias{.lec.IncreasedPrecis}
\title{Switch between 32 and 53 bits of resolution}
\description{Switch between 32 and 53 bits of resolution as described in
  L'Ecuyer et al (2002).
}
\usage{
.lec.IncreasedPrecis (name, incp=FALSE)
}
\arguments{
  \item{name}{name of the stream.}
  \item{incp}{see  L'Ecuyer et al (2002).}
}
\value{None.}
\details{\code{.lec.IncreasedPrecis} is a wrapper function for the C
  function \code{RngStream_IncreasedPrecis}.}

\references{P. L'Ecuyer, R. Simard, E.J.Chen and W.D.Kelton: An
  Object-Oriented Random-Number Package With Many Long Streams and
  Substreams; Operations Research, vol. 50, nr. 6, 2002.}
\keyword{distribution}
