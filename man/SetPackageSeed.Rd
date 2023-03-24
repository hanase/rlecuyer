\name{SetPackageSeed}
\alias{.lec.SetSeed}
\alias{.lec.SetPackageSeed}

\title{Set RNG Seed}
\description{Set the initial seed of the package or stream.}

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

\details{
\code{.lec.SetPackageSeed} sets the  the starting state of the next stream to be created. If there are no streams yet, it is the initial seed of the RNG. \code{.lec.SetSeed} sets the seed of a specific stream.

A state of each stream is given by three
integer vectors of length 6: Ig gives the initital state of the
stream, Bg gives the starting state of the substream that contains the
current state, Cg gives the current state.  Function
\code{.lec.SetPackageSeed} sets Cg, Bg and Ig to the value of
\code{seed}. Function \code{.lec.SetSeed} sets Ig to \code{seed}. L'Ecuyer recommends to use the \code{\link[=.lec.ResetStartStream]{ResetStream}} functions instead of \code{SetSeed}.
}

\value{The (possibly modified) seed that has been used.}
\keyword{distribution}
\seealso{\code{\link[rlecuyer]{ResetNextSubstream}}}

\examples{
# Set the seed of the first stream
.lec.SetPackageSeed(1:6)

# Create the first stream and print out its state
.lec.CreateStream("A")
.lec.WriteStateFull("A")

# Create two more streams
.lec.CreateStream(c("B", "C"))
.lec.WriteStateFull(c("A", "B", "C"))

# Cet the seed of the next stream and create it
.lec.SetPackageSeed(rep(5678, 6))
.lec.CreateStream("D")
.lec.WriteStateFull(c("A", "B", "C", "D"))

}
