
#' write_updated_fasta
#' wrraper around [update_fasta_header()] reads a fasta file from path, updates the header and writes the new file
#' @param file string. The path of the fasta file.
#' @param output_dir string. Where to save the new fasta.
#' @inheritParams name_from_string
#'
#' @return
#' @export
#'
#' @examples
#' file <- system.file("extdata", "SRR12664421_masked.fasta", package = "voRtex", mustWork = TRUE)
#' \dontrun{
#' write_updated_fasta(file,
#' output_dir="out",
#' first_token = "extdata/",
#' last_token = "_masked.fasta")
#' }
#'
write_updated_fasta<-function(file,
                              output_dir,
                              first_token,
                              last_token){

  DNA_stringset <- Biostrings::readDNAStringSet(file)
  header <- voRtex::name_from_string(file,
                                     first_token = first_token,
                                     last_token = last_token)
  DNA_stringset <-voRtex::update_fasta_header(
    DNA_stringset,
    header
  )

  Biostrings::writeXStringSet(DNA_stringset,
                              filepath=paste0(output_dir,"/",header,".fasta"))
}
