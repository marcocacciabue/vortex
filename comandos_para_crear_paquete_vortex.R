#  este es un script de trabajo para documentar los pasos a seguir en la creacion
#  del paquete vortex.

#LIBRERIAS A UTILIZAR:

library("usethis")
library("devtools")
library("VariantAnnotation")
library("ggplot2")
library("regexcite")
library("Biostrings")

#Usamos CREATE_PACKAGE para que cree DESCRIPTION
#Hay alguna manera de generar la descripcion sin utilizar create package??
create_package("C:/Users/HP/OneDrive/Documentos/GitHub/vortex")

#use_git() Debemos cargar USE_GIT??

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
