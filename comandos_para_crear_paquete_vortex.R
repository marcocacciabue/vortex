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


### vamos a crear el archivo de descripcion

### TODO Nahuel y Melina crearse un ORCID y agregarlo aca y decidir que direccion de mail usaran
options(
  usethis.description = list(    "Authors@R" = c(utils::person(
    "Marco", "Cacciabue",
    email = "marcocacciabue@yahoo.com",
    role = c("aut", "cre"),
    comment = c(ORCID = "http://orcid.org/0000-0002-1429-4252")
  ),
  utils::person(
    "Melina", "Obregon",
    email = "meliobre06@gmail.com",
    role = c("aut"),
    comment = c(ORCID = "http://orcid.org/0000-0002-1429-4252")
  ),
  utils::person(
    "Nahuel", "Fenoglio",
    email = "pequefenoglio99@gmail.com",
    role = c("aut"),
    comment = c(ORCID = "http://orcid.org/0000-0002-1429-4252")
  )))
  )





usethis::use_description(fields=list(
  Title="voRtex",
  Description="A set of functions for processing VCF files in the context of datamining from illumina data."))


### esto algo extra que les tengo que explicar
# Manually add   biocViews:       before the imports in the description file
# this allows R to download bioconductors packages see ()


### estas librerias NO las cargamos las tenemos que agregar a la lista de dependencias
### usando un comando particular de usethis
# library("VariantAnnotation")
# library("ggplot2")
# library("regexcite")
# library("Biostrings")

usethis::use_package("VariantAnnotation")
usethis::use_package("IRanges")
usethis::use_package("Biostrings")
usethis::use_package("ggplot2", type = "Suggests")
usethis::use_package("RColorBrewer", type = "Suggests")

usethis::use_testthat()
usethis::use_package("assertthat")


usethis::use_import_from("VariantAnnotation","readVcf")
#use_git() Debemos cargar USE_GIT??
### se puede usar git en Rstudio. Sin embargo yo prefiero usar el github desktop



### vamos a saltear la creacion de la funcion de lector. Vamos a arrancar con object control


# use_r("lector")

### creamos archivo en blanco y luego copiamos y pegamos el codigo de la funcion.
use_r("objectControl")


### creamos test correspondiente
usethis::use_test("objectControl")


### cargamos todo lo que tenemos hasta ahora
load_all()

### testeamos
devtools::test()

### lo mismo para la funcion "Position"
use_r("Position")

### copiamos funcion manualmente.

### para poder testear correctamente esta funcion necesitamos
### que el paquete incluya al menos un archivo de vcf.
### para eso lo guardamos en una carpeta especial inst/extdata



### creamos test correspondiente

usethis::use_test("Position")

### cargamos todo lo que tenemos hasta ahora
load_all()

### testeamos
devtools::test()

#Licencia
use_mit_license()

#Domentacion
devtools::document()

#Control 1
devtools::check()

devtools::install()

#Creamos funcion VCFToDataFrame
use_r("VCFToDataFrame")


#Testeamos la funcion
usethis::use_test("VCFToDataFrame")

load_all()

#Creamos la funcion DataFrameBinder
use_r("DataFrameBinder")

devtools::install()

devtools::test_coverage()

#Testemos la funcion DataFrameBinder
usethis::use_test("DataFrameBinder")

#Creamos la funcion name_from_string
use_r("name_from_string")

#Testeamos la funcion name_from_string
usethis::use_test("name_from_string")

#Creamos la funcion update_fasta_header
use_r("update_fasta_header")


usethis::use_test("update_fasta_header")

check()
install.packages("rmarkdown")
install.packages("knitr")
library("rmarkdown")
library("knitr")
install.packages("hexSticker")
library("hexSticker")
stic<-hexSticker::sticker("man/figures/VoRtex.PNG",package = "VoRtex")
plot(stic)


stic2<-sticker("man/figures/vORTEX.jpeg",
        package="voRtex",
        p_size = 60,
        p_fontface="italic",
        s_x=0.984,
        s_y=0.98,
        s_width=1.3,
        s_height=-2,
        h_fill="#f7f7f7",
        h_color="black",
        p_y=1,
        filename="man/figures/hex.png",
        white_around_sticker = TRUE,
        dpi= 800)

plot(stic2)

help("sticker")


use_r("NreadFilter")
usethis::use_test("NreadFilter")
devtools::test()
check()

use_r("NCountFilter")
usethis::use_test("NCountFilter")
devtools::test()
load_all()
check()

#Paleta de colores
color <- brewer.pal(8, "Spectral")

#Creamos la funcion compute_coverage
use_r("compute_coverage")
usethis::use_test("compute_coverage")

#Creamos la funcion ggplot_heatmap
use_r("ggplot_heatmap")

