#' VCFToDataFrame
#' Returns a data frame with the Positions, DP, AF, INDEL and ANN extracted from a file.vcf
#' @param vcf_data collapsedVCF object. Loaded with the [VariantAnnotation::readVcf].
#'
#' @return data.frame
#' @export
#'
#' @examples
#' file <- system.file("extdata", "variant_file.vcf", package = "voRtex", mustWork = TRUE)
#' vcf_data <- VariantAnnotation::readVcf(file)
#' VCFToDataFrame(vcf_data)
#'
VCFToDataFrame <- function(vcf_data) {
  objectControl(vcf_data)
  if ("ANN" %in% colnames(VariantAnnotation::info(vcf_data))){
    ID<- rownames(VariantAnnotation::info(vcf_data))
    my_list<-strsplit(ID,split=":|_")
    Position_original <- unlist(lapply(my_list, function(x) x[2]))
    Ref_Alt <- unlist(lapply(my_list, function(x) x[3]))
  DataFrame <- data.frame(
    Position = Position(vcf_data),
    Position_original = Position_original,
    DP = VariantAnnotation::info(vcf_data)$DP,
    AF = VariantAnnotation::info(vcf_data)$AF,
    INDEL = VariantAnnotation::info(vcf_data)$INDEL,
    ALT= voRtex::extract_element_from_ANN(vcf_data,1),
    Ref_Alt= Ref_Alt,
    Annotation=voRtex::extract_element_from_ANN(vcf_data,2),
    Annotation_Impact=voRtex::extract_element_from_ANN(vcf_data,3)
  )} else{
    DataFrame <- data.frame(
      Position = Position(vcf_data),
      DP = VariantAnnotation::info(vcf_data)$DP,
      AF = VariantAnnotation::info(vcf_data)$AF)
  }
  return(DataFrame)
  # to do agregar funcion fastareader
  # Sample=fasta_header_from_path(file.vcf,
  # first_token="vcf_files/",
  # last_token = ".calls.norm.indels.vcf")
  # Agregar columna con nombre de la muestra a partir de un argumento
}
