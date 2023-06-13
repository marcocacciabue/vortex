#' extract_element_from_ANN
#'
#' @inheritParams VCFToDataFrame
#' @param index A numeric that indicates the index of the element of ANN to extract (tested for 2 and 3).
#'
#' @return A character vector
#' @export
#'
#' @examples
#' file <- system.file("extdata", "annotated.vcf", package = "voRtex", mustWork = TRUE)
#'
#' vcf<- VariantAnnotation::readVcf(file)
#'
#' Annotation<-extract_element_from_ANN(vcf_data=vcf, index=2)
#' Annotation_Impact<-extract_element_from_ANN(vcf_data=vcf,index=3)

extract_element_from_ANN<- function(vcf_data,
                                    index){
  x <- vector()

  for(i in 1:length(VariantAnnotation::info(vcf_data)$DP)){
    x[i] <-  unlist(Biostrings::strsplit((VariantAnnotation::info(vcf_data)$ANN)[[i]][1],"\\|"))[index]
  }
  return(x)
}
