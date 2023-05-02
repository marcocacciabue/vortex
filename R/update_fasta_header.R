#' update_fasta_header
#' updates the Fasta header by a user-given string.
#'
#' @param DNA_stringset DNA_stringset object. The fasta file to update
#' @param header String. The new header (name).
#'
#' @return DNA_stringset.
#' @export
#'
#' @examples
#'
#' file <- system.file("extdata", "SRR12664421_masked.fasta", package = "vortex", mustWork = TRUE)
#' DNA_stringset <- Biostrings::readDNAStringSet(file)
#' header <- name_from_string(file)
#' update_fasta_header(
#'   DNA_stringset,
#'   header
#' )
#'
update_fasta_header <- function(DNA_stringset,
                                header) {
  if (!(class(DNA_stringset)[1] == "DNAStringSet")) {
    stop("'DNA_stringset' must be a object of class DNA_stringset (try loading fasta file as:
           Biostrings::readDNAStringSet(filepath)")
  }
  if (is.null(header) | missing(header) | !assertthat::is.string(header)) {
    stop("'new_header' must be given as a string")
  }
  names(DNA_stringset) <- header

  return(DNA_stringset)
}
