#' ggplot_heatmap
#' create a custom heatmap plot using ggplot2.
#'
#' @param inputdata data used to create the heatmap chart.
#' @param color_pal vector specifying the colors used in the color scale of the heat map
#' @param name name of the sample seen in the graph
#' @param low_limit lower and upper limits of the color scale
#' @param high_limit lower and upper limits of the color scale
#'
#' @return heatmap chart
#' @export
#'
#' @examples
#'
#'  FilePath <- system.file("extdata", "SRR12664421_full_coverage.bed",
#'                          package = "voRtex", mustWork = TRUE)
#' data <- read.table(FilePath, col.names = c("reference", "startpos", "endpos", "coverage"))
#' data_processed<-compute_coverage(data, 50, TRUE)
#' color  <- c("#D53E4F","#F46D43","#FDAE61","#FEE08B","#E6F598","#ABDDA4","#66C2A5","#3288BD")
#' ggplot_heatmap(inputdata=data_processed,
#'               color_pal = color)

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
