#' VCFToDataFrame
#' Returns a data frame with the Positions, DP and AF extracted from a file.vcf
#' @param file.vcf
#'
#' @return Data Frame
#' @export
#'
#' @examples
#' file<-system.file("extdata", "variant_file.vcf", package = "vortex", mustWork = TRUE)
#' VCFToDataFrame (file )
VCFToDataFrame<-function(file.vcf){
  vcf_data <- VariantAnnotation::readVcf(file.vcf)
  objectControl(vcf_data)
  DataFrame<-data.frame(Position=Position(vcf_data),
                        DP=VariantAnnotation::info(vcf_data)$DP,
                        AF=VariantAnnotation::info(vcf_data)$AF
                        )
  return(DataFrame)
  #to do agregar funcion fastareader
  #Sample=fasta_header_from_path(file.vcf,
  # first_token="vcf_files/",
  # last_token = ".calls.norm.indels.vcf")
  }


