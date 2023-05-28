#'  name_from_string
#'  extracts the relevant part of a string delimited by first_token and last_token
#'
#' @param sample_string String. Sample string to extract from.-
#' @param first_token String.first part to cut
#' @param last_token String.last part to cut
#' @param verbose Boolean. Sets verbose mode (default: false)
#'
#' @return String. Relevant part of the string.
#' @export
#'
#' @examples
#' file <- system.file("extdata", "SRR12664421_masked.fasta", package = "voRtex", mustWork = TRUE)
#' name_from_string(file,
#'   first_token = "extdata/",
#'   last_token = "_masked.fasta"
#' )
#'
name_from_string <- function(sample_string,
                             first_token = "extdata/",
                             last_token = "_masked.fasta",
                             verbose = FALSE) {
  if (!assertthat::is.string(first_token)) {
    stop("first_token must be a string")
  }
  if (!assertthat::is.string(last_token)) {
    stop("last_token must be a string")
  }
  if (is.null(sample_string) | missing(sample_string) | !assertthat::is.string(sample_string)) {
    stop("'sample_string' must be given as a string")
  }

  if (verbose) {
    cat(
      "extracting name from sample_string using", first_token, " as first token and ", last_token, " as last token"
    )
  }

  extracted_string <- unlist(strsplit(sample_string, first_token))

  extracted_string <- unlist(strsplit(extracted_string[length(extracted_string)], last_token))
  return(extracted_string)
}
