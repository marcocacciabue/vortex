#' DataFrameBinder
#'
#' @param vcflist A list of collapsedVCF objects to combine in a single data.frame using
#' [VCFToDataFrame]
#'
#' @return A data.frame
#' @export
#'
#' @examples
#' file <- system.file("extdata", "variant_file.vcf", package = "voRtex", mustWork = TRUE)
#' file2 <- system.file("extdata", "variant_file_2.vcf", package = "voRtex", mustWork = TRUE)
#' vcf_list <- list(
#'   file,
#'   file2
#' )
#' listavcf_salida <- list()
#' for (i in 1:length(vcf_list)) {
#'   listavcf_salida[[i]] <- VariantAnnotation::readVcf(vcf_list[[i]])
#' }
#' DataFrameBinder(listavcf_salida)
#'
DataFrameBinder <- function(vcflist) {
  listavcf_salida <- list()
  for (i in 1:length(vcflist)) {
    listavcf_salida[[i]] <- VCFToDataFrame(vcflist[[i]])
  }
  big_data <- do.call(rbind, listavcf_salida)
  return(big_data)
}


#' read.vcf.to.df
#'
#' @param file A string path to the vcf file to read. Created to reemplace [DataFrameBinder].
#' @param sample A string indicating the name of the sample. If not provided filename is used.
#' @return A data.frame created with [VCFToDataFrame].
#' @export
#'
#' @examples
#' file <- system.file("extdata", "variant_file.vcf", package = "voRtex", mustWork = TRUE)
#' read.vcf.to.df(file)
#'
read.vcf.to.df<-function(file,sample=NULL){
  x<-VariantAnnotation::readVcf(file)

  out<-voRtex::VCFToDataFrame(x)
  if(is.null(sample)){
  out$sample<-file
  }else{
  out$sample<-sample

  }
  return(out)
}
