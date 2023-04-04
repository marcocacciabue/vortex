#  este es un script de trabajo para documentar los pasos a seguir en la creacion
#  del paquete vortex.
library("usethis")
library("devtools")
library("VariantAnnotation")
library("ggplot2")
library("regexcite")
library("Biostrings")
create_package("C:/Users/HP/OneDrive/Documentos/GitHub/vortex")

#use_git()#pregunta...

use_r("lector")
load_all()

#prueba de la funcion lector
lector.runs("vortex/datos_crudos2/SraRunInfo_completa_12_12_22.csv",
            folder = "trabajo_6_3_2023",
            output.file = "run",chunklength = 50)

#control 1
check()

#Licencia
use_mit_license()

document()

help("lector.runs")

#control 2
check()
