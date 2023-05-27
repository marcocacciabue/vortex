#' NreadFilter
#' reads a dataframe created from a bed file and filters it according to the
#' number of reads.
#'
#' @param OGDataFrame DataFrame.A dataframe Created from a bed file,
#'                    that must have the columns "reference", "startpos", "endpos"
#'                    and "nreads"
#' @param RFilter     Numeric. Minimum read number
#'
#' @return List. With 2 objects: a dataframe, the og dataframe filtered by
#'         number of reads, and with a new column named "width", and a numeric
#'         that says the percentage that passed the filter
#' @export
#'
#' @examples
#' FilePath <- system.file("extdata", "SRR12664421_full_coverage.bed",
#'                          package = "vortex", mustWork = TRUE)
#' OGDataFrame <- read.table(FilePath,
#'                           col.names = c("reference","startpos","endpos","nreads"))
#' salida <- NreadFilter(OGDataFrame,5000)
NreadFilter <- function(OGDataFrame, RFilter=1000){

  if (sum(colnames(OGDataFrame) %in% c("reference","startpos","endpos","nreads")) != 4){
    stop("Data grame must have column names 'reference', 'startpos', 'endpos', 'nreads'")
  }

  Width <- OGDataFrame$endpos-OGDataFrame$startpos

  OGDataFrameWithWidth <- cbind(OGDataFrame,Width)

  FilteredDataFrame <- subset(OGDataFrameWithWidth, OGDataFrameWithWidth$nreads > RFilter)

  FilteredPercent <- sum(FilteredDataFrame[,"Width"])*100/sum(OGDataFrameWithWidth[,"Width"])
  mi_lista <- list(FilteredDataFrame, FilteredPercent)
  return(mi_lista)
}
