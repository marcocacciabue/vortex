#ignoramos en el armado del paquete la carpeta que incluye los models
use_build_ignore("inst/myapp/")

#cargamos modelo
FMDV_model <- readRDS("inst/myapp/models/FMDV_model.rds")

#lo comprimimos para que este disponible en el paquete
usethis::use_data(FMDV_model,overwrite = TRUE,compress = "bzip2")

FMDV_model$info


usethis::use_package("ranger")
usethis::use_package("DT")


usethis::use_package("ape")
# usethis::use_package("usethis")

usethis::use_package("kmer")
