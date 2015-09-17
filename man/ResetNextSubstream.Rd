\name{ResetStream}
\alias{.lec.ResetNextSubstream}
\alias{.lec.ResetStartSubstream}
\alias{.lec.ResetStartStream}
\title{Reset the state of a stream}
\description{Resets the state of a stream to its initial state, beginning of the current substream or beginning of the next substream.}
\usage{
.lec.ResetNextSubstream(name)
.lec.ResetStartStream(name)
.lec.ResetStartSubstream(name)
}
\arguments{
  \item{name}{a character string giving the name of the stream.}
 }
\details{\code{.lec.ResetNextSubstream} reinitializes the stream to the
  beginning of its next substream.

  \code{.lec.ResetStartStream} reinitializes the stream to its initial state.

  \code{.lec.ResetStartSubstream} reinitializes the stream to the
  beginning of its current substream.
}
\value{None.}
\keyword{distribution}
\seealso{\code{\link[rlecuyer]{SetPackageSeed}}}
