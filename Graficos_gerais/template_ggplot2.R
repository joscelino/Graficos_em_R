library(pacman)
pacman::p_load(readxl, tidyverse, ggplot2, plotly, patchwork)

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
dados <- read_xlsx("D:/Projetos_em_R/Diversos/Dados/temperatura_porto_alegre.xlsx")
dplyr::glimpse(dados)
dados$codigo_estacao <- base::factor(dados$codigo_estacao)
dados$temp_inst <- base::as.numeric(dados$temp_inst)
dados$temp_max <- base::as.numeric(dados$temp_max)
dados$temp_min <- base::as.numeric(dados$temp_min)
dados$pto_orvalho_inst <- base::as.numeric(dados$pto_orvalho_inst)
dados$pto_orvalho_max <- base::as.numeric(dados$pto_orvalho_max)
dados$pto_orvalho_min <- base::as.numeric(dados$pto_orvalho_min)
dados$pressao  <- base::as.numeric(dados$pressao)
dados$pressao_max <- base::as.numeric(dados$pressao_max)
dados$pressao_min <- base::as.numeric(dados$pressao_min)
dados$vento_direcao <- base::factor(dados$vento_direcao)
dados$vento_rajada <- base::as.numeric(dados$vento_rajada)
dados$radiacao <- base::as.numeric(dados$radiacao)
dados$precipitacao <- base::as.numeric(dados$precipitacao)
dados$regiao <- base::factor(dados$regiao)

# Verificando NAs
funcaoNA(dados)

# Grafico de dispersao (Temperatura instante x Ponto Orvalho x Hora)
dispersaoTemperatura <- ggplot2::ggplot(data = dados) +
  ggplot2::geom_point(mapping = aes(x = umid_inst, y = pto_orvalho_inst,
                                    colour = temp_inst, size = hora)) +
  ggplot2::labs(x = "Umidade", y =  "Ponto Orvalho") +
  ggplot2::theme_classic()

plotly::ggplotly(dispersaoTemperatura)

# Grafico dispersao com reta (Velocidade do vento x Umidade instante)
dispersaoVento <- ggplot2::ggplot(data = dados) +
  ggplot2::geom_point(mapping = aes(x = vento_vel, y = umid_inst,
                                    colour = pressao, size = radiacao)) +
  ggplot2::geom_abline(intercept = 80, slope = 0.05) +
  ggplot2::labs(x = "Velocidade do Vento", y =  "Umidade") +
  ggplot2::theme_classic()

dispersaoTemperatura / dispersaoVento

# Calculo do coeficiente angular
coeficiente <- stats::coef(lm(vento_vel ~ umid_inst, data = dados))

dispersaoVento2 <- ggplot2::ggplot(data = dados) +
  ggplot2::geom_point(mapping = aes(x = vento_vel, y = umid_inst,
                                    colour = pressao, size = radiacao)) +
  ggplot2::geom_abline(intercept = coeficiente[1], slope = coeficiente[2]) +
  ggplot2::labs(x = "Velocidade do Vento", y =  "Umidade") +
  ggplot2::theme_classic()

dispersaoVento3 <- ggplot2::ggplot(data = dados, aes(x = vento_vel, y = umid_inst)) +
  ggplot2::geom_point(mapping = aes(colour = pressao, size = radiacao)) +
  geom_smooth(method = "lm", se = TRUE) +
  ggplot2::labs(x = "Velocidade do Vento", y =  "Umidade") +
  ggplot2::theme_classic()

dispersaoVento / dispersaoVento2 / dispersaoVento3

# BoxPlot
boxPlot <- ggplot2::ggplot(data = dados, aes(regiao, umid_inst)) + 
  ggplot2::geom_boxplot(mapping = aes(colour = regiao), fill = "#FFEBCD", 
                        notch = TRUE, show.legend = TRUE, position = "dodge2") +
  ggplot2::labs(x = "Regiao", y =  "Umidade") +
  ggplot2::theme_classic() 

boxPlotPontos <- ggplot2::ggplot(data = dados, aes(regiao, umid_inst)) + 
  ggplot2::geom_boxplot(mapping = aes(colour = regiao), fill = "#FFEBCD", 
                        notch = TRUE, show.legend = TRUE, position = "dodge2") +
  ggplot2::geom_jitter(width = 0.2) + 
  ggplot2::labs(x = "Regiao", y =  "Umidade") +
  ggplot2::theme_classic() 

boxPlotEstacoes <- ggplot2::ggplot(data = dados, aes(regiao, umid_inst)) + 
  ggplot2::geom_boxplot(mapping = aes(colour = codigo_estacao), fill = "#F5FFFA", 
                        notch = FALSE, show.legend = TRUE, position = "dodge2") +
  ggplot2::scale_alpha_continuous() +
  ggplot2::labs(x = "Regiao", y =  "Umidade") +
  ggplot2::theme_classic() 

dispersaoVento3 + (boxPlotPontos / boxPlotEstacoes)

# Grafico de barras
graficoBarra <- ggplot2::ggplot(dados) +
  ggplot2::geom_bar(aes(y =  codigo_estacao))

graficoBarra2 <- ggplot2::ggplot(dados, aes(umid_inst)) +
  ggplot2::geom_bar(aes(fill =  codigo_estacao)) +
  ggplot2::theme_classic() +
  ggplot2::theme(legend.position = "top")

(dispersaoVento3 + graficoBarra2) / (boxPlotPontos + boxPlotEstacoes) 

# Histograma
histograma <- ggplot2::ggplot(dados, aes(umid_inst, 
                                         colour = regiao)) +
  ggplot2::geom_histogram(binwidth = 1.0) +
  ggplot2::theme_classic()


densidade1 <- ggplot2::ggplot(dados, aes(umid_inst, 
                                         after_stat(density),
                                         colour = codigo_estacao)) +
  ggplot2::geom_freqpoly(binwidth = 1.0) +
  ggplot2::theme_classic()

densidade2 <- ggplot2::ggplot(dados, aes(umid_inst,after_stat(density))) +
  ggplot2::geom_freqpoly(binwidth = 6.0) +
  ggplot2::theme_classic()


# Formas geometricas
graficoGeom <- ggplot2::ggplot(data = dados, aes(factor(regiao),umid_inst)) + 
  ggplot2::geom_violin(aes(fill = regiao), 
                       draw_quantiles = c(0.25, 0.50, 0.75)) +
  ggplot2::geom_jitter(width = 0.2) + 
  ggplot2::labs(x = "Regiao", y =  "Umidade") +
  ggplot2::theme_classic() 

plotly::ggplotly(graficoGeom)

# Mapa de CAlor
heatMap <- ggplot2::ggplot(data = dados, aes(codigo_estacao, regiao, 
                                             fill = umid_inst)) + 
  ggplot2::geom_tile() +
  ggplot2::scale_fill_distiller(palette = "RdPu") +
  ggplot2::labs(x = "Regiao", y =  "Umidade") +
  ggplot2::theme_classic() 
