#'Position
#' Returns a vector with the allele positions
#'
#' @param vcf_data CollapsedVCF vcf file
#'
#'
#' @return Vector with the allele positions
#'
#' @export
#'
#' @examples
#' file<-system.file("extdata", "variant_file.vcf", package = "vortex", mustWork = TRUE)
#' vcf_data<-VariantAnnotation::readVcf(file)
#' Position(vcf_data)
Position<-function(vcf_data){
  objectControl(vcf_data)
  IRanges::ranges(vcf_data)@start #ranges es una funcion de variantAnotations que lee los rangos
}

