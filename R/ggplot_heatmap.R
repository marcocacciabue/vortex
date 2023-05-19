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
#' data <- read.table("Resultados/run1/coverage/SRR13776172_full_coverage.bed",
#'         col.names = c("reference", "startpos", "endpos", "coverage"))
#' data_processed<-compute_coverage(data, 50, TRUE)
#'
#' ggplot_heatmap(inputdata=data_processed,
#'               color_pal = color)

ggplot_heatmap<-function(inputdata,
                         color_pal,
                         name ="Sample",
                         low_limit=0,
                         high_limit=5){


  p1 <- ggplot(inputdata, aes(y = 1, x = pos, fill = Coverage)) +
    geom_raster() +
    scale_fill_gradientn(
      colours = c(color_pal[1], color_pal[5], color_pal[8]),
      limits = c(low_limit,high_limit)
    ) +
    theme_minimal(base_size = 13) +
    ylab(name) +
    theme(
      axis.text.x = element_blank(),
      axis.text.y = element_blank(),
      axis.ticks = element_blank(),
      axis.title.x = element_blank()
    ) +
    coord_cartesian(xlim = c(1, 8500)) +
    theme(
      panel.grid.major = element_blank(),
      panel.grid.minor = element_blank()
    )+
    theme(panel.border = element_rect(color = "black", fill = NA, size = 1.5),
          plot.background = element_rect(fill = "white"))

  return(p1)
}
