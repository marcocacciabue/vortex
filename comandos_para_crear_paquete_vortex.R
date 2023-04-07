#  este es un script de trabajo para documentar los pasos a seguir en la creacion
#  del paquete vortex.



#Usamos CREATE_PACKAGE para que cree DESCRIPTION
#Hay alguna manera de generar la descripcion sin utilizar create package??


### Aca hay que usar path relativos!! Consultar cualquier cosa.
# create_package("C:/Users/HP/OneDrive/Documentos/GitHub/vortex")

### vamos a una carpeta SUPERIOR a donde este vortex
devtools::create('./vortex')

### NO suele ser necesario pero por las dudas nos aseguramos que el proyecto activo
### sea el correcto
usethis::proj_activate('./vortex')

setwd("./vortex")
#LIBRERIAS A UTILIZAR:
### Solo cargamos estas tres librerias para el "desarrollo" del paquete
### Agrego roxygen2 para la documentacion.

library("usethis")
library("devtools")
library("roxygen2")

### estas librerias NO las cargamos las tenemos que agregar a la lista de dependencias
### usando un comando particular de usethis
# library("VariantAnnotation")
# library("ggplot2")
# library("regexcite")
# library("Biostrings")


#use_git() Debemos cargar USE_GIT??
### se puede usar git en Rstudio. Sin embargo yo prefiero usar el github desktop



use_r("lector")
load_all()

#Prueba de funcionamiento de Lector.runs:
lector.runs("vortex/datos_crudos2/SraRunInfo_completa_12_12_22.csv",
            folder = "trabajo_6_3_2023",
            output.file = "run",chunklength = 50)

#Control 1
check()

#Licencia
use_mit_license()

#Dumentacion
document()

#Prueba de carga de la funcion
help("lector.runs")

#Control 2
#Comienza a fallar...Al momento de controlar la funcion, no la encuentra...
check()
