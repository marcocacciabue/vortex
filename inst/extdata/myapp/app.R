library(shiny)
library(ggplot2)
library(voRtex)
library(VariantAnnotation)
library(DT)

max_plots <- 50
ui <- navbarPage(
  theme = "Style.css",
  includeCSS("www/Style.css"),
  title = span(img(src="hex.PNG", style="margin-top: -12px;", height = 45),
              "voRtex"),
  tags$head(
      tags$link(rel = "icon", type = "image/png", sizes = "32x32", href = "hex.PNG"),
  ),
  # Agregar el logo de la aplicación
  # SECCIONES
  tabPanel("Introduction",
          div(
            id = "fullscreen-container",
            img(src = "introduction.jpg", alt = "Descripción de la imagen")
          ),
          div(
             id = "text-container",
             h2(class="Titulo", "voRtex"),
             p( " Nuestro paquete se desarrollado con la finalidad de facilitar la evaluación de
             conjuntos extensos de secuencias de ARN relacionadas con la fiebre aftosa.
             Este conjunto de herramientas incluye una variedad de funciones meticulosamente
             diseñadas para agilizar la gestión y el análisis de datos de muestra de manera eficaz.
             Además, permite la manipulación de una amplia gama de formatos de
             archivo, como VCF, BED, FASTA, DNAStringSet y otros, simplificando así el proceso de análisis
             y visualización de la información."),
             tags$a("Enlace al paquete voRtex", href = "https://github.com/marcocacciabue/voRtex.git", target="_blank"),
             h4("En la esta página podra obtener los siguentes datos"),
             div(
               class = "container",
               div(
                 class = "column",
                 h5("Procesamiento de Archivos .vcf"),
                 img( class= "icon",src= "archVcf.png"),
                 p("La lectura de archivos en formato .vcf
                   resulta en la creación de un Data Frame. Cada columna de este
                   Data Frame almacena información específica como la posición, frecuencia alelica y profundidad de cobertura.
                   Esto facilita el análisis de datos genéticos para investigaciones y aplicaciones genómicas")
               ),
               div(
                 class = "column",
                 h5("Visualizador de Cobertura de Archivos .bed"),
                 img( class= "icon",src= "archBed.png"),
                 p("Un gráfico de cobertura es una representación visual de la profundidad
                   de cobertura en diferentes regiones del genoma, lo que puede ser útil en análisis
                   genéticos y genómicos.")
               )
             )

          )
          ),
  tabPanel( "plot",

      div(
        id = "mi-div",
        h3("Visualizador de Cobertura de Archivos .bed  "),
        img(class="icon2",src = "subir.png")
      ),

      checkboxInput("FilePrueba", "Seleccion de Archivo de prueba", FALSE),
      conditionalPanel(
        condition = '!input.FilePrueba',
        fileInput("files", "Seleccionar archivo(s)", multiple = TRUE, accept = c(".bed"))
      ),
      # tabPanel("Plot",plotOutput("coveragePlot"))),
      tabPanel("Plot",uiOutput("plots"))),


      tabPanel("Table",
               div(
                 id = "mi-div",
                 h3("Procesamiento de Archivos .vcf  "),
                 img(class="icon2",src = "subir.png")
                  ),
             #Interfaz para archivo .vcf
             checkboxInput("FilePruebavcf", "Seleccion de Archivo de prueba", FALSE),

             conditionalPanel(
               condition = '!input.FilePruebavcf',
               fileInput("filesvcf", "Seleccionar archivo(s)", multiple = TRUE, accept = c(".vcf"))
             ),
             actionButton("Grafico2","Generar grafico .vcf"),
             textOutput("text"),
             DT::dataTableOutput("coverageTable")))




server <- function(input, output) {




  output$plots <- renderUI({
    plot_output_list <- lapply(1:length(input$files[,4]), function(i) {
      plotname <- paste("plot", i, sep="")
      plotOutput(plotname,height = "150px")
    })

    # Convert the list to a tagList - this is necessary for the list of items
    # to display properly.
    do.call(tagList, plot_output_list)

  })

  # Call renderPlot for each one. Plots are only actually generated when they
  # are visible on the web page.
  for (i in 1:max_plots) {

    # Need local so that each item gets its own number. Without it, the value
    # of i in the renderPlot() will be the same across all instances, because
    # of when the expression is evaluated.
    local({
      my_i <- i
      plotname <- paste("plot", my_i, sep="")

      output[[plotname]] <- renderPlot({

        if (input$FilePrueba==TRUE){
          file_to_use<-  system.file("extdata", "SRR12664421_full_coverage.bed",
                                     package = "voRtex", mustWork = TRUE)
          name <- "example"
        }else{
          req(input$files)
          # input$files[1,4]
          file_to_use<- input$files[my_i,4]
          name <- input$files[my_i,1]
        }
        data <- read.table(file_to_use, col.names = c("reference", "startpos", "endpos", "coverage"))
        data_processed<-voRtex::compute_coverage(data, 50, TRUE)
        color <- c("#D53E4F","#F46D43","#FDAE61","#FEE08B","#E6F598","#ABDDA4","#66C2A5","#3288BD")

        ggplot_heatmap(inputdata=data_processed,
                       color_pal = color,
                       name = name)
      })
    })
  }
  #Archivo .vcf



  datareactive2<-eventReactive(input$Grafico2,{
    if (input$FilePruebavcf==TRUE){
      file_to_use<-  system.file("extdata", "variant_file.vcf",
                  package = "voRtex", mustWork = TRUE)
    }else{
      #req(input$filesvcf)
      file_to_use <- list()
      for (i in 1:length(input$filesvcf[,4])) {

      file_to_use[[i]]  <-  input$filesvcf[i,4]}

    }
    data_list<-lapply(file_to_use,
              voRtex::read.vcf.to.df)
    df<-do.call(rbind, data_list)
    df
    # voRtex::read.vcf.to.df(file_to_use)
    # Calcular el porcentaje de frecuencia de alelos (AF) y la profundidad (DP)
    if (nrow(df) > 0) {

      #df$AF <- df$AF
      #df$DP <- df$DP

      # Calcular el porcentaje acumulado de profundidad y frecuencia de alelos
      total_DP <- round(mean(df$DP),0)
      total_AF <- round(mean(df$AF) * 100,2)  # Tomo el promedio y luego multiplicamos por 100 para ilustrar
    } else {
      total_DP <- 0
      total_AF <- 0
    }

    # Informe en modo texto
    summary_text <- paste("Informe:\n",
                          "La media de profundidad de los archivos subidos es de", total_DP," x", "\n",
                          "La media de la frecuencia alélica es de", total_AF," %")

    list(df = df, summary_text = summary_text)
  })
  output$coverageTable <- DT::renderDataTable({

    table<-datareactive2()$df
    datatable(table,selection = 'single',
              style = 'bootstrap',
              extensions = 'Buttons',
              options = list(
                dom = 'Bfrtip',
                pageLength = 15,
                buttons =
                  list('copy', 'print', list(
                    extend = 'collection',
                    buttons = list(
                      list(extend = 'csv', filename = "Vortex_results"),
                      list(extend = 'excel', filename = "Vortex_results"),
                      list(extend = 'pdf', filename = "Vortex_results")),
                    text = 'Download'
                  ),
                  list(
                    extend = "collection",
                    text = 'Show All',
                    action = DT::JS("function ( e, dt, node, config ) {
                                    dt.page.len(-1);
                                    dt.ajax.reload();
                                }")
                  ))
              ))
  })
  output$textSummary <- renderText({
    datareactive2()$summary_text
  })

  output$text <- renderText({ datareactive2()$summary_text })
}

shinyApp(ui=ui, server=server)
