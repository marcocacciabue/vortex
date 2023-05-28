#' compute_coverage
#' returns data containing the average position and coverage
#'
#' @param inputdata dataframe
#' @param windowsize calculates the average coverage of contiguous windows of size windowsize
#' @param logarize takes the base 10 log of coverage values
#'
#' @return returns data containing the average position and coverage
#' @export
#'
#' @examples
#'  FilePath <- system.file("extdata", "SRR12664421_full_coverage.bed",
#'                          package = "voRtex", mustWork = TRUE)
#' data <- read.table(FilePath, col.names = c("reference", "startpos", "endpos", "coverage"))
#' data_processed<-compute_coverage(data, 50,TRUE)
#' data_processed

compute_coverage <- function(inputdata,
                             windowsize=100,
                             logarize=TRUE) {
  if(logarize==TRUE){
    inputdata$coverage <- log10(inputdata$coverage)
  }

  starts <-
    seq(1, max(inputdata$endpos) - windowsize, by = windowsize)
  n <- length(starts)
  chunkCOVERAGEs <- numeric(n)
  for (i in 1:n) {
    chunk <-
      subset(inputdata, (startpos >= starts[i]) &
               (endpos < (starts[i] + windowsize - 1)))

    # chunk <- inputseq[starts[i]:(starts[i]+windowsize-1)]
    chunkCOVERAGEs[i] <- mean(chunk$coverage)
  }
  pos <- seq(
    from = 1,
    to = n * windowsize,
    by = windowsize
  )
  out <- data.frame(pos = pos, Coverage = chunkCOVERAGEs)


  return(out)
}
