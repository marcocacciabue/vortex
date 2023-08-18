#' DataFrameBinder
#'
#' @param vcflist A list of collapsedVCF objects to combine in a single data.frame using
#' [VCFToDataFrame]
#'
#' @return A [data.frame]
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
#' @param add_sample Logical. if true adds [sample_name] in a new column.
#' @param sample_name string. Name of sample to add if [add_sample] is TRUE.
#' @return A [data.frame] created with [VCFToDataFrame].
#' @export
#'
#' @examples
#' file <- system.file("extdata", "variant_file.vcf", package = "voRtex", mustWork = TRUE)
#' read.vcf.to.df(file)
#'
read.vcf.to.df<-function(file,
                         add_sample=FALSE,
                         sample_name){
  x<-VariantAnnotation::readVcf(file)

  out<-voRtex::VCFToDataFrame(x)
  if(add_sample & missing(sample_name)){
    stop("add_sample TRUE and sample_name is missing, please provide a name")
  }
  if(add_sample){


    out$sample<-sample_name
  }
  return(out)
}
