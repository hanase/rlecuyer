\name{init}
\alias{.lec.init}
\alias{.lec.exit}

\title{Initialization and Cleaning}
\description{Initialize and remove the RNG}


\usage{
.lec.init()
.lec.exit()
}

\details{
The package uses a global table object \code{.lec.Random.seed.table} to keep information about the current state of the streams. Functions \code{.lec.init} creates this global object and function \code{.lec.exit} deletes it. However, in most cases these two functions will not be needed, as the table is automatically created when the package is loaded and it is deleted when the package is unloaded. If there is however a need to explicitely delete the table of streams and create a new empty one, these two functions can be used for that purpose.

\code{.lec.init} initializes the workspace: removes old and creates new
  global object \cr \code{.lec.Random.seed.table}. It also 
  allocates memory for the current stream used by \cr
  \code{\link{.lec.CurrentStream}}.

\code{.lec.exit} removes the global object \code{.lec.Random.seed.table} and
  frees memory used for the current stream.
}

\keyword{manip}
