#' extract_element_from_ANN
#'
#' @param vcf_data
#' @param index A numeric that indicates the index of the element of ANN to extract (tested for 2 and 3).
#'
#' @return A character vector
#' @export
#'
#' @examples
#' file <- system.file("extdata", "ERR180978.calls.norm.indels.vcf_annotated.vcf", package = "vortex", mustWork = TRUE)
#' vcf<- VariantAnnotation::readVcf(file)
#'
#' Annotation<-extract_element_from_ANN(vcf_data=vcf, index=2)
#' Annotation_Impact<-extract_element_from_ANN(vcf_data=vcf,index=3)

extract_element_from_ANN<- function(vcf_data,
                                    index){
  x <- vector()

  for(i in 1:length(VariantAnnotation::info(vcf)$DP)){
    x[i] <-  unlist(Biostrings::strsplit((VariantAnnotation::info(vcf)$ANN)[[i]][1],"\\|"))[index]
  }
  return(x)
}
