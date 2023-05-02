#' VCFToDataFrame
#' Returns a data frame with the Positions, DP and AF extracted from a file.vcf
#' @param vcf_data collapsedVCF object. Loaded with the [VariantAnnotation::readVcf()].
#'
#' @return Data.frame()
#' @export
#'
#' @examples
#' file <- system.file("extdata", "variant_file.vcf", package = "vortex", mustWork = TRUE)
#' vcf_data <- VariantAnnotation::readVcf(file)
#' VCFToDataFrame(vcf_data)
#'
VCFToDataFrame <- function(vcf_data) {
  objectControl(vcf_data)
  DataFrame <- data.frame(
    Position = Position(vcf_data),
    DP = VariantAnnotation::info(vcf_data)$DP,
    AF = VariantAnnotation::info(vcf_data)$AF
  )
  return(DataFrame)
  # to do agregar funcion fastareader
  # Sample=fasta_header_from_path(file.vcf,
  # first_token="vcf_files/",
  # last_token = ".calls.norm.indels.vcf")
}
