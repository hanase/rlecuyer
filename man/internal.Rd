\name{internal}
\alias{.lec.init}
\alias{.lec.exit}
\alias{.lec.StreamExists}
\title{Internal functions}
\description{Internal functions, it is not recommended to use them from outside of the package.

\code{.lec.init} initializes the workspace: removes old and creates new
  global object \cr \code{.lec.Random.seed.table}. It also 
  allocates memory for the current stream used by \cr
  \code{\link{.lec.CurrentStream}}.

\code{.lec.exit} removes the global object \code{.lec.Random.seed.table} and
  frees memory used for the current stream.

\code{.lec.StreamExists} returns \code{TRUE} if the stream is found in
  \code{.lec.Random.seed.table}, otherwise \code{FALSE}.
}

\usage{
.lec.init ()

.lec.exit ()

.lec.StreamExists (name)
}

\arguments{
  \item{name}{name of the stream.}
}
\keyword{internal}

