library(pacman)
pacman::p_load(readxl, tidyverse, ggplot2, plotly, patchwork, 
               lubridate, treemap, RColorBrewer, ggraph, igraph,
               gapminder)

# Funcao para identificar NAs em colunas de data frames
funcaoNA <- function(df){
  
  library(pacman)
  pacman::p_load(dplyr, tibble)
  
  index_col_na <- NULL
  quantidade_na <- NULL
  
  for (i in 1:ncol(df)) {
    if(sum(is.na(df[,i])) > 0) {
      index_col_na[i] <- i
      quantidade_na[i] <- sum(is.na(df[,i]))
    }
  }
  resultados <- data.frame(index_col_na,quantidade_na)
  resultados <- resultados %>% filter(quantidade_na>0)
  
  return(resultados)
}

# Importacao de tratamento dos dados
dados <- read_xlsx("D:/Projetos_em_R/Diversos/Dados/cotacao_dolar.xlsx")
dados$local <- base::factor(dados$local)
dados$regiao <- base::factor(dados$regiao)

# Preparacao de dados para o Tree Map
grupo <- dados$regiao
valor <- dados$valor

data <- base::data.frame(grupo,valor)
glimpse(dados)

# Grafico "Pirulito"
lollipop <- ggplot2::ggplot(dados, aes(x = dia_cotacao, y = valor)) +
    ggplot2::geom_segment(aes(x = dia_cotacao, xend = dia_cotacao,
                              y = 0, yend = valor)) +
    ggplot2::geom_point(color = "orange", size = 4) +
    ggplot2::labs(x = "Dia da cotacao", y =  "Valor (R$)", 
                  title = "Evolucao da cotacao do dolar") +
    ggplot2::theme(plot.title = element_text(hjust = 0.5, size = 10)) + 
    ggplot2::theme_classic()

# Boxplot
boxPlot <- ggplot2::ggplot(data = dados, aes(regiao,valor)) + 
  ggplot2::geom_boxplot(mapping = aes(colour = regiao), fill = "#FFEBCD", 
                        notch = FALSE, show.legend = TRUE, position = "dodge2") +
  ggplot2::theme_classic() 

# Grafico de Violino
graficoGeom <- ggplot2::ggplot(data = dados, aes(factor(regiao),valor)) + 
  ggplot2::geom_violin(aes(fill = regiao), 
                       draw_quantiles = c(0.25, 0.50, 0.75)) +
  ggplot2::geom_jitter(width = 0.2) + 
  ggplot2::labs(x = "Regiao", y =  "Umidade") +
  ggplot2::theme_classic() 

# Tree map
treemap::itreemap(data,
                  index = "grupo",
                  vSize = "valor",
                  type = "index")

# Grid
lollipop / (boxPlot + graficoGeom)
plotly::ggplotly(graficoGeom)
