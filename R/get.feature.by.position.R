

#' get.feature.by.position
#'
#' @param features a data.frame with at least three columns: Feature, Start and End. Describes the features of the genome and their coordinates.
#' Can be created with [import.features.to.df]
#' @param query a numeric that indicates the nucleotide position.
#'
#' @return A string with the feature name at the query position
#' @export
#'
#' @examples
#' features_fmdv <- import.features.to.df()
#' get.feature.by.position(features_fmdv,2000)
get.feature.by.position<-function(features,
                                  query){
  if (is(features)[1]!="data.frame"){
    stop("Features is not a data.frame!")
  }
  test<-colnames(features) %in% c("Feature","Start","End")
  if(sum(test)!=3){
    stop("Names of columns must be Feature, Start and End)")
  }
  if (missing(query)) {
    stop("You haven't indicated a query!")
  }
  if (is.null(query)) {
    stop("You haven't indicated a query!")
  }

  if (is(query)[1] != "numeric") {
    stop("query must be a numeric!")
  }

  target.index <- which(query>=features$Start & query<=features$End)
  return(features$Feature[target.index])

}


#' import.features.to.df
#'
#' @param file path to a .csv file to import the genome features. Must include the columns: Feature, Start and End.
#'
#' @return a dataframe with the relevant features
#' @export
#'
#' @examples
#' features_fmdv <- import.features.to.df()
import.features.to.df<-function(file=system.file("extdata","fmdv_features.csv",package="voRtex")){
  df<- utils::read.csv2(file)
  test<-colnames(df) %in% c("Feature","Start","End")
  if(sum(test)!=3){
    stop("Names of columns must be Feature, Start and End)")
  }
  return(df)
}
