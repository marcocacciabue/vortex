#' NCountFilter
#' Filters objects from the class DNAStringSet, using as parameter the number
#' of "N" bases
#'
#' @param dna_seq Object from the class DNAStringSet
#' @param filter Numeric to use as a filter
#'
#' @return Object from the class DNAStringSet
#' @export
#'
#' @examples
#' FilePath <- system.file("extdata",
#'                         "renamed_all.fasta",
#'                         package = "voRtex",
#'                         mustWork = TRUE)
#'
#' DNASequence <- Biostrings::readDNAStringSet(FilePath)
#'
#' NCountFilter(DNASequence)
#'
NCountFilter<-function(dna_seq,filter=1000){
  Ncount<-Biostrings::vcountPattern("N",dna_seq)
  Ncount_filter<-Ncount<filter
  dna_seq_filterd<-dna_seq[Ncount_filter]
  if(length(dna_seq_filterd)==0){
    stop("No sequence passed the filter")
  } else {
    return(dna_seq_filterd)
  }
}
