#' name_from_string
#'  one direction is trimmed and the middle section is returned
#'
#' @param filepath String.direction to trim
#' @param first_token String.first part to cut
#' @param last_token String.last part to cut
#'
#' @return String
#' @export
#'
#' @examples
#' filepath<-"./exdata/SRR12664421_masked.fasta"
#' name_from_string(filepath,
#'                 first_token="exdata/",
#'                 last_token="_masked.fasta" )
#'
name_from_string<-function(filepath,
                                 first_token="exdata/",
                                 last_token="_masked.fasta"){
  if (!assertthat::is.string(first_token)){stop("first_token must be a string")}
  if (!assertthat::is.string(last_token)){stop("last_token must be a string")}
  if (is.null(filepath)| missing(filepath) | !assertthat::is.string(filepath)) {
    stop("'filepath' must be given as a string")
  }
  cat(
    "extracting name from filepath using", first_token," as first token and ", last_token, " as last token"
  )

  header<-unlist(strsplit(filepath,first_token))

  header<-unlist(strsplit(header[length(header)],last_token))
  return(header)
}
