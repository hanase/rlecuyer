\name{CurrentStream}
\alias{.lec.CurrentStream}
\alias{.lec.CurrentStreamEnd}
\title{Set/unset the current stream}
\description{\code{.lec.CurrentStream} sets the current stream for usage
  with the standard R functions for generating random numbers such as
  \code{\link{runif}} or \code{\link{rnorm}}. \code{.lec.CurrentStreamEnd unsets it.}}
\usage{
.lec.CurrentStream (name)
.lec.CurrentStreamEnd (kind.old = c("Marsaglia-Multicarry",
                         "Kinderman-Ramage"))
}
\arguments{
  \item{name}{a character string giving the name of the stream.}
  \item{kind.old}{a length 2 character vector, the old rng kinds
  (possiblly returned by \code{.lec.CurrentStream}).}
}
\value{\code{.lec.CurrentStream} returns a two-element character vector of the RNG and normal kinds
  in use before the call. \code{.lec.CurrentStreamEnd} returns a character string giving the name of the unset current stream.
}
\details{\code{.lec.CurrentStream} sets the RNGkind to user-defined. All succeeding calls of R built-in genertors  will
  generate random numbers from the stream \code{name}, until
  \code{.lec.CurrentStreamEnd} is called. \code{.lec.CurrentStreamEnd} updates the RNG state of the stream \code{name} in the
  table \code{.lec.Random.seed.table} and 
  sets the RNGkind to \code{kind.old}. These two functions are meant to be always used as a pair.  Thus, one can arbitrarily switch
  generating between different streams.
}
\examples{
nstreams <- 10       # number of streams
names <- paste("mystream",1:nstreams,sep="")
.lec.CreateStream(names)
for (i in 1:nstreams) {  # generate 10 RNs from each stream
   .lec.CurrentStream(names[i])
   print(paste("stream no.",i))
   print(runif(10))
   .lec.CurrentStreamEnd()
}
}
\keyword{distribution}
