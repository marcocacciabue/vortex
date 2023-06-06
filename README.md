Marco Cacciabue, Melina Obregón, Axel N. Fenoglio

<!-- README.md is generated from README.Rmd. Please edit that file -->

# **voRtex** <img src='man/figures/hex.PNG' style="float:right; height:200px;" />

## **voRtex** is an R package

voRtex is a package created with the purpose to help in the data
analysis of large groups of foot and mouth desease rna sequences.

this package contains a collection of functions designed to manage and
analyze sample data in an efficient way.

this package manages VCF files, bed files, fasta files, DNAStringSet

## examples

VCFToDataFrame.R creates a data frame off a vcf file, containing allel
position, allel frecuency and depth coverage

``` r
VCFToDataFrame <- function(vcf_data) {
  objectControl(vcf_data)
  DataFrame <- data.frame(
    Position = Position(vcf_data),
    DP = VariantAnnotation::info(vcf_data)$DP,
    AF = VariantAnnotation::info(vcf_data)$AF
  )
  
  file <- system.file("extdata", "variant_file.vcf", package = "voRtex", mustWork = TRUE)
  vcf_data <- VariantAnnotation::readVcf(file)
  VCFToDataFrame(vcf_data)
```
