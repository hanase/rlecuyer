\name{CreateStream}
\alias{.lec.CreateStream}
\alias{.lec.StreamExists}

\title{Spawn new streams}
\description{\code{.lec.CreateStream} creates new streams of random
  numbers. \code{.lec.StreamExists} checks the existence of a stream.}
\usage{
.lec.CreateStream (names)
.lec.StreamExists (name)
}
\arguments{
  \item{names}{a character string or a vector of character strings
    naming the streams to be created. The argument must be
    provided and the names must be unique within the set of existing
    streams. If for one \code{i} a
    stream of the name \code{names[i]} already exists,
    its state is replaced by the
    state of the new created stream.}
  \item{name}{name of stream}
}
\value{\code{.lec.StreamExists} returns \code{TRUE} or \code{FALSE}.}

\details{\code{.lec.CreateStream} is a wrapper function for the C
  function \code{RngStream_CreateStream} (L'Ecuyer et al, 2002). The state of
  the created stream returned by the C function is stored in the global
  object \code{.lec.Random.seed.table}.
  
  \code{.lec.StreamExists} returns \code{TRUE} if the stream is found in
  \code{.lec.Random.seed.table}, otherwise \code{FALSE}.
}
\references{P. L'Ecuyer, R. Simard, E.J.Chen and W.D.Kelton: An
  Object-Oriented Random-Number Package With Many Long Streams and
  Substreams; Operations Research, vol. 50, nr. 6, 2002.}
\examples{
nstreams <- 10       # number of streams
names <- paste("mystream",1:nstreams,sep="")
.lec.CreateStream(names)
.lec.WriteStateFull(names)
}
\keyword{distribution}
