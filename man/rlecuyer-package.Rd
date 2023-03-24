\name{rlecuyer-package}
\alias{rlecuyer-package}
\alias{rlecuyer}
\docType{package}
\title{
    R Interface to Random Number Generator with Multiple Streams
}

\description{
    Provides an interface to the C implementation of the
        random number generator (RNG) with multiple independent streams
        developed by L'Ecuyer et al (2002). The package enables to use this random number generator in
        parallel R applications.
}

\details{
When the \pkg{rlecuyer} package is loaded, the L'Ecuyer RNG is initialized by creating a global table object (\code{.lec.Random.seed.table}) which allows to keep information and account for multiple random number streams that the user can create. The individual streams are identified by names which must be unique. The workflow starts with initializing the RNG with a seed via \code{\link{.lec.SetPackageSeed}} and creating one or more streams via \code{\link{.lec.CreateStream}}.

When the RNG is deployed in a parallel application, one stream can be used for generating all random numbers (RNs) on one node, or all RNs generated within one task. The master node would hold the global table object, initialize it with a package seed (via \code{\link{.lec.SetPackageSeed}}), create the amount of streams that are needed for the application (via \code{\link{.lec.CreateStream}}) and send each worker information about the stream assigned to it. Alternatively, all workers could be initialized with an identical global table and identical streams, and the master node could be only sending the identifiers of the streams on which each worker should operate. If streams are assigned to tasks instead of nodes, one can assure reproducibility regardless of the number of nodes the application is running on, or regardless if it is run sequentially or in parallel.

To generate RNs from a particular stream, start with the function \code{\link{.lec.CurrentStream}}. This will assure that any subsequent call to standard R functions that use RNs (e.g. \code{\link{runif}} or \code{\link{rnorm}} will draw from the current stream. \code{\link{.lec.CurrentStreamEnd}} unsets the stream. Thus, by using these two functions in pair, one can switch between different streams. Alternatively, if drawing from a uniform distribution is sufficient, by using the function \code{\link{.lec.uniform}} one can omit the CurrentStream and CurrentStreamEnd pair, as the \code{\link{.lec.uniform}} function includes the name of the stream to draw from.

Each stream is given by its current state (see \code{\link[=.lec.SetPackageSeed]{SetPackageSeed}} for description) that can be viewed by \code{\link{.lec.WriteStateFull}}. To reset a stream to its initial state, use \code{\link{.lec.ResetStartStream}}. To extract the curent state of a stream, one can use \code{\link{.lec.GetState}}. 

Other useful functions are available. For example, one can advance the state of a stream by given number of steps via the \code{\link{.lec.AdvanceState}} function. Function \code{\link{.lec.GetStreams}} allows to retrieve names of all streams in the global table.  To delete a stream from the table, use \code{\link{.lec.DeleteStream}}. If there is a need to delete the whole table of streams and initialize a new one, one can use \code{\link{.lec.init}} and  \code{\link{.lec.exit}}.
}


\references{
P. L'Ecuyer, R. Simard, E.J.Chen and W.D.Kelton: An
  Object-Oriented Random-Number Package With Many Long Streams and
  Substreams; Operations Research, vol. 50, nr. 6, 2002.    
}

\keyword{ package }
\examples{
# Initialize the RNG with package seed
seed <- rep(85424, 6) 
.lec.SetPackageSeed(seed)

# Create 5 streams
nstream <- 5
snames <- as.character(1:nstream) # unique stream identifiers 
.lec.CreateStream(snames)

# Generate 10 RNs from each of the 5 streams
# (each of the iterations could run on a different node)
rns <- NULL
for (i in 1:nstream) {
    old.kind <- .lec.CurrentStream(snames[i])
    rns <- rbind(rns, runif(10))
   .lec.CurrentStreamEnd(old.kind)
}
rns

# Reproduce results on the second stream
.lec.ResetStartStream("2")
rns2 <- .lec.uniform("2", 10)
all(rns2 == rns[2,])

# Reproduce the last three RNs on stream 5
.lec.ResetStartStream("5")
.lec.AdvanceState("5", 0, 7) # move the state by 7 steps
rns5p <- .lec.uniform("5", 3)
all(rns5p == rns[5, 8:10])


}
