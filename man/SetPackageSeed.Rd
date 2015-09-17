\name{SetPackageSeed}
\alias{.lec.SetSeed}
\alias{.lec.SetPackageSeed}
\title{Set the initial seed of the package or stream}
\description{Sets the initial seed of the package or stream.}
\usage{
.lec.SetPackageSeed(seed)
.lec.SetSeed (name, seed)
}
\arguments{
  \item{name}{a character string giving the name of the stream.}
  \item{seed}{a vector of six integers. If it is shorter, the seed is
    extended to the length of 6 by default values 12345. If it is
    longer, it is truncated to the length of 6 by eliminating the last
elements. } } 

\details{Each state of a stream is given by three
integer vectors of length 6: Ig gives the initital state of the
stream, Bg gives the starting state of the substream that contains the
current state, Cg gives the current state.  Function
\code{.lec.SetPackageSeed} sets Cg, Bg and Ig to the value of
\code{seed}. Function \code{.lec.SetSeed} sets Ig to \code{seed}. L'Ecuyer recommends to use the \code{\link[=.lec.ResetStartStream]{ResetStream}} functions instead of \code{SetSeed}.} 

\value{The (possibly modified) seed that has been used.}
\keyword{distribution}
\seealso{\code{\link[rlecuyer]{ResetNextSubstream}}}
