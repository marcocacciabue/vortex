

#' recalibrate_vcf
#' Take a vcf object and update the position of each SNP based on the coordintates of a
#' aligned sequence. Each gap in the sequence adds a nt to the relevant position.
#' @param vcf_data collapsedVCF object. Loaded with the [VariantAnnotation::readVcf].
#' @param DNA_stringset DNA_stringset. Loaded with [Biostrings::readDNAStringSet].
#'
#' @return an updated collapsedVCF object.
#' @export
#'
#' @examples
#' FilePath <- system.file("extdata", "aligned_sample.fasta",
#'                          package = "voRtex", mustWork = TRUE)
#' DNA_stringset<-Biostrings::readDNAStringSet(FilePath)
#' vcf_path<-  system.file("extdata", "vcf_to_update.vcf",
#'                          package = "voRtex", mustWork = TRUE)
#' Vcf_object<-VariantAnnotation::readVcf(vcf_path)
#' recalibrate_vcf(Vcf_object,
#'                DNA_stringset)
#'
recalibrate_vcf<-function(vcf_data,
                          DNA_stringset){


  vcf<-vcf_data
  d<-DNA_stringset
  d2<-Biostrings::DNAString(gsub("[-]","",d))
  d2.length<-length(d2)
  pos <- seq(1,d2.length,by=1)
  a <-unlist(Biostrings::vmatchPattern("-",d))
  contador <- 0
  #sequence could not have any "-". If that is the case, skips update.
  if(length(a)!=0){
    for(i in 1:length(a)){
      aux <- IRanges::start(a[i]) - contador
      contador<- contador + 1
      pos[aux:d2.length]<-pos[aux:d2.length] + 1
    }

    pos.old<-Biostrings::start(vcf)
    for(j in 1:length(pos.old)){
      pos.old[j] <- pos[pos.old[j]]

    }
    IRanges::end(IRanges::ranges(vcf))<-pos.old
    IRanges::start(IRanges::ranges(vcf))<-pos.old

    return(vcf)
  }else{
    return(vcf)
  }
}
