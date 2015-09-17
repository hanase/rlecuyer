\name{SetAntithetic}
\alias{.lec.SetAntithetic}
\title{Switch between U and 1-U variates}
\description{Switches between \eqn{U} and \eqn{1-U} variates.
}
\usage{
.lec.SetAntithetic (name, anti=FALSE)
}
\arguments{
  \item{name}{name of the stream.}
  \item{anti}{if \code{anti=TRUE} then antithetic variates are generated (i.e. \eqn{1-U}), until this function is called again with \code{anti=FALSE}.}
}
\value{None.}
\keyword{distribution}

