\name{AdvanceState}
\alias{.lec.AdvanceState}
\title{Advance the state of a stream}
\description{\code{.lec.AdvanceState} advances the state of a stream by
  \eqn{n} steps (see bellow).
}
\usage{
.lec.AdvanceState (name, e, c)
}
\arguments{
  \item{name}{name of the stream.}
  \item{e, c}{if \eqn{e > 0} then \eqn{n = 2^e + c}; if \eqn{e < 0} then \eqn{n = -2^{-e} + c};
  if \eqn{e = 0} then \eqn{n = c.}}
}

\value{None.}
\details{\code{.lec.AdvanceState} is a wrapper function for the C
  function \code{RngStream_AdvanceState} (L'Ecuyer et al, 2002).}

\references{P. L'Ecuyer, R. Simard, E.J.Chen and W.D.Kelton: An
  Object-Oriented Random-Number Package With Many Long Streams and
  Substreams; Operations Research, vol. 50, nr. 6, 2002.}
\keyword{distribution}

