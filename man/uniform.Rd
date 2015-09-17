\name{uniform}
\alias{.lec.uniform}
\alias{.lec.uniform.int}
\title{Generate random numbers}
\description{
\code{.lec.uniform} generates \eqn{U(0,1)} random numbers.

\code{.lec.uniform.int} generates random numbers from the discrete uniform
                        distribution over integers.
}
\usage{
.lec.uniform (name, n = 1)

.lec.uniform.int (name, n = 1, a = 0, b = 10)
}
\arguments{
  \item{name}{name of the stream.}
  \item{n}{number of random numbers to be generated.}
  \item{a,b}{interval from which the integer random numbers should be generated.}
}
\value{A vector of \eqn{n} random numbers.}
\details{\code{.lec.uniform} and \code{.lec.uniform.int}, respectively, are wrapper functions for the C
  functions \code{RngStream_RandU01} and \code{RngStream_RandInt}, respectively (L'Ecuyer et al, 2002). 

Note: Since the stream is here identified by \code{name}, there is no need for using the \code{\link[rlecuyer]{CurrentStream}} pair.
}
\references{P. L'Ecuyer, R. Simard, E.J.Chen and W.D.Kelton: An
  Object-Oriented Random-Number Package With Many Long Streams and
  Substreams; Operations Research, vol. 50, nr. 6, 2002.}
\examples{
nstreams <- 10       # number of streams
seed<-rep(1,6)
.lec.SetPackageSeed(seed)
names <- paste("mystream",1:nstreams,sep="")
.lec.CreateStream(names)
for (i in 1:nstreams)   # generate 10 RNs from each stream
      print(.lec.uniform(names[i],10))
.lec.DeleteStream(names)
}
\keyword{distribution}
\seealso{\code{\link[rlecuyer]{.lec.CurrentStream}}}
