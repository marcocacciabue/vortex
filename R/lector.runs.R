#'  lector.runs
#' lee archivos csv de Sra, y crea archivos de texto en
#' paquetes especificados por el usuario, con
#' la informacion de los runs
#'
#' @param input.file string con la direccion relativa del archivo
#' @param folder string con el nombre de la carpeta de salida (deafult=salida)
#' @param output.file string con el nombre del archivo de salida (default=prueba.txt)
#' @param chunklength numeric con maximo numero de muestras por archivo (default=100)
#'
#' @return multiples archivos de texto con la informacion de la columna run
#' @export
#'
#' @examples
#'  lector.runs("vortex/datos_crudos2/SraRunInfo_completa_12_12_22.csv",
#'  output.file = "run",
#'  chunklength = 250)


lector.runs<-function(input.file=NULL,
                      folder="Salida",
                      output.file="prueba.txt",
                      chunklength=100){
  if (is.null(input.file)){
    stop("You haven't loaded a file!")
  }

  Srarunsinfo <- read.csv(input.file)
  if (!"Run" %in% colnames(Srarunsinfo)){
    stop("The file doesn't have col Run")
  }


  if (dir.exists(folder)){
    print("Dir already exists!")
  } else {
    dir.create(folder)
  }
}
