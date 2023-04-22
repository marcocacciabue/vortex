
#' update_fasta_header
#' the hader of the Fasta file is updated.
#'
#' @param DNA_stringset DNA_stringset
#' @param header String
#'
#' @return DNA_stringset
#' @export
#'
#' @examples
#'
#' filepath<-"./extdata/SRR12664421_masked.fasta"
#' DNA_stringset = Biostrings::readDNAStringSet(filepath)
#' header = name_from_string(filepath,...)
#' update_fasta_heade(DNA_stringset,
#'                           header)
#'
update_fasta_header<-function(DNA_stringset,
                              header){
  if (!(class(DNA_stringset)[1]=="DNAStringSet")){stop("'DNA_stringset' must be a object of class DNA_stringset (try loading fasta file as:
                                           Biostrings::readDNAStringSet(filepath)")}
  if (is.null(header)| missing(header) | !assertthat::is.string(header)) {
    stop("'new_header' must be given as a string")
  }
  names(DNA_stringset)<-header

  return(DNA_stringset)
}
