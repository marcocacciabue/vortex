Marco Cacciabue, Melina Obregón, Axel N. Fenoglio

<!-- README.md is generated from README.Rmd. Please edit that file -->

# **voRtex** <img src='man/figures/hex.PNG' style="float:right; height:200px;" />

## **voRtex** is an R package

voRtex is a package created with the purpose to help in the data
analysis of large groups of foot and mouth desease rna sequences.

this package contains a collection of functions designed to manage and
analyze sample data in an efficient way. It manages VCF files, bed
files, fasta files, DNAStringSet and else.

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

With compute_coverage.R we can create a dataframe containing the average
position and coverage of a mouth and foot desease sequence, using a .bed
file, giving the function a window size of choosing

``` r
compute_coverage <- function(inputdata,
                             windowsize=100,
                             logarize=TRUE) {
  if(logarize==TRUE){
    inputdata$coverage <- log10(inputdata$coverage)
  }

  starts <-
    seq(1, max(inputdata$endpos) - windowsize, by = windowsize)
  n <- length(starts)
  chunkCOVERAGEs <- numeric(n)
  for (i in 1:n) {
    chunk <-
      subset(inputdata, (startpos >= starts[i]) &
               (endpos < (starts[i] + windowsize - 1)))

    # chunk <- inputseq[starts[i]:(starts[i]+windowsize-1)]
    chunkCOVERAGEs[i] <- mean(chunk$coverage)
  }
  pos <- seq(
    from = 1,
    to = n * windowsize,
    by = windowsize
  )
  out <- data.frame(pos = pos, Coverage = chunkCOVERAGEs)


  return(out)
}

FilePath <- system.file("extdata", "SRR12664421_full_coverage.bed",
                          package = "voRtex", mustWork = TRUE)

data <- read.table(FilePath, col.names = c("reference", "startpos", "endpos", "coverage"))

data_processed<-compute_coverage(data, 50,TRUE)

```

Then with ggplot_heatmap.R we can create a heatmap based on the data
frame created with compute_coverage

``` r
ggplot_heatmap<-function(inputdata,
                         color_pal,
                         name ="Sample",
                         low_limit=0,
                         high_limit=5){


  p1 <- ggplot2::ggplot(inputdata, ggplot2::aes(y = 1, x = pos, fill = Coverage)) +
    ggplot2::geom_raster() +
    ggplot2::scale_fill_gradientn(
      colours = c(color_pal[1], color_pal[5], color_pal[8]),
      limits = c(low_limit,high_limit)
    ) +
    ggplot2::theme_minimal(base_size = 13) +
    ggplot2::ylab(name) +
    ggplot2::theme(
      axis.text.x = ggplot2::element_blank(),
      axis.text.y = ggplot2::element_blank(),
      axis.ticks = ggplot2::element_blank(),
      axis.title.x = ggplot2::element_blank()
    ) +
    ggplot2::coord_cartesian(xlim = c(1, 8500)) +
    ggplot2::theme(
      panel.grid.major = ggplot2::element_blank(),
      panel.grid.minor = ggplot2::element_blank()
    )+
    ggplot2::theme(panel.border = ggplot2::element_rect(color = "black", fill = NA, size = 1.5),
          plot.background = ggplot2::element_rect(fill = "white"))

  return(p1)
}
FilePath <- system.file("extdata", "SRR12664421_full_coverage.bed",
                          package = "voRtex", mustWork = TRUE)
data <- read.table(FilePath, col.names = c("reference", "startpos", "endpos", "coverage"))

data_processed<-compute_coverage(data, 50, TRUE)

color  <- c("#D53E4F","#F46D43","#FDAE61","#FEE08B","#E6F598","#ABDDA4","#66C2A5","#3288BD")

ggplot_heatmap(inputdata=data_processed,
               color_pal = color)
```

Resulting in this beautiful heat map

![SRR12664421_Heatmap](Rplot.png)
