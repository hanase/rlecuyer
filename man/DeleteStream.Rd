\name{DeleteStream}
\alias{.lec.DeleteStream}
\title{Remove streams}
\description{\code{.lec.DeleteStream} removes streams from the global state table.}
\usage{
.lec.DeleteStream (names)
}
\arguments{
  \item{names}{a character string or a vector of character strings
    naming the streams to be deleted.}
}
\value{None.}
\details{All streams given in the argument \code{names} are removed from
  the table \code{.lec.Random.seed.table}.
}
\keyword{distribution}
