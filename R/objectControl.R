#' objectControl
#' Controls if the correct class is indicated
#'
#' @param object class object to control
#'
#'
#' @return null
objectControl<-function(object){
  if (missing(object)){
    stop("You haven't indicated a class colapsedVCF object!")
  }
  if (is.null(object)){
    stop("You haven't indicated a class colapsedVCF object!")
  }

  if (is(object)[1]!="CollapsedVCF"){
    stop("The object is not a CollapsedVCF class!")
  }
  #to do: controlar que el archivo vcf sea de lofreq
}
