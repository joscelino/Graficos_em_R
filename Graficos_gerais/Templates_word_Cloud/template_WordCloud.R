library(pacman)
pacman::p_load(readxl, tidyverse, ggplot2, plotly, wordcloud2, patchwork)

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
dados <- read_xlsx("D:/Projetos_em_R/Diversos/Dados/viagem.xlsx")
dados$identificador <- base::factor(dados$identificador)
dados$situacao <- base::factor(dados$situacao)
dados$cod_orgao <- base::factor(dados$cod_orgao)
dados$nome_orgao <- base::factor(dados$nome_orgao)
dados$nome_orgao_solicitado <- base::factor(dados$nome_orgao_solicitado)
dados$periodo_ida <- lubridate::ymd(dados$periodo_ida)
dados$periodo_volta <- lubridate::ymd(dados$periodo_volta)
dados$destino <- base::factor(dados$destino)

glimpse(dados)

# Verificando NAs
funcaoNA(dados)

repeticao <- base::as.data.frame(table(dados$nome_orgao_solicitado))
repeticao <- tibble::as_tibble(repeticao)

# WordCloud
# Modelo 1
wordcloud2::wordcloud2(repeticao, size = 1)

# Modelo 2
wordcloud2::wordcloud2(repeticao, size = 1.6, color = "random-light",
                       backgroundColor = "black")

# Modelo 3
wordcloud2::wordcloud2(repeticao, size = 2.3, minRotation = -pi/6,
                       rotateRatio = 2)
