library(pacman)
pacman::p_load(readxl, tidyverse, ggplot2, plotly, patchwork, lubridate,
               packcircles)

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

# Analises Graficas
# Variacao 1
bin <- ggplot2::ggplot(dados, aes(x = diaria, y = passagem)) +
    ggplot2::geom_bin2d(bins = 5) +
    ggplot2::scale_fill_continuous(type = "viridis") +
    ggplot2::labs(x = "Valor da diaria (R$)", y = "valor da Passagem (R$)") +
    ggplot2::theme_bw() +
    ggplot2::theme_classic()

# Variacao 2
bin2 <- ggplot2::ggplot(dados, aes(x = diaria, y = passagem)) +
  ggplot2::stat_density2d(aes(fill = ..level..), geom = "polygon",
                          colour = "white") +
  ggplot2::scale_fill_continuous(type = "viridis") +
  ggplot2::labs(x = "Valor da diaria (R$)", y = "valor da Passagem (R$)") +
  ggplot2::theme_bw() +
  ggplot2::theme_classic()

# Variacao 3
densidade <- ggplot2::ggplot(dados, aes(x = diaria, y = passagem)) +
        ggplot2::stat_density2d(aes(fill = ..level..), geom = "polygon",
                                colour = "white") +
        ggplot2::scale_fill_distiller(palette = "Spectral", direction = 1) +
        ggplot2::scale_x_continuous(expand = c(0, 0)) +
        ggplot2::scale_y_continuous(expand = c(0, 0)) +
        ggplot2::labs(x = "Valor da diaria (R$)", 
                      y = "valor da Passagem (R$)") +
        ggplot2::theme_bw() +
        ggplot2::theme_classic()

# BoxPlot
boxPlot <- ggplot2::ggplot(data = dados, aes(situacao, diaria)) + 
  ggplot2::geom_boxplot(mapping = aes(colour = situacao), fill = "#FFEBCD", 
                        notch = TRUE, show.legend = TRUE, position = "dodge2") +
  ggplot2::labs(x = "Situacao", y =  "Valor da Passagem (R$)") +
  ggplot2::theme_classic() 

# Grafico de Violino
violino <- ggplot2::ggplot(data = dados, aes(factor(situacao),diaria)) + 
  ggplot2::geom_violin(aes(fill = situacao), 
                       draw_quantiles = c(0.25, 0.50, 0.75)) +
  ggplot2::geom_jitter(width = 0.2) + 
  ggplot2::labs(x = "Valor da diaria (R$)", 
                y = "valor da Passagem (R$)") + 
  ggplot2::theme_classic() 

# Donut
# Preparando dados para grafico circular
df <- base::data.frame(
  categoria = dados$situacao,
  medida = dados$diaria
)

data <- stats::aggregate(medida ~ categoria,
                         data = df,
                         FUN = sum)

# Percentuais
data$fraction <- data$medida / sum(data$medida)

# Acumuludado dos percentuais
data$ymax <- base::cumsum(data$fraction)

# Tamanho do retangulo
data$ymin <- c(0, head(data$ymax, n = -1))

# Onde o label caira
data$labelPosition <- (data$ymax + data$ymin) / 2

# Ajuste do valor do label
data$label <- base::paste0(data$categoria, "\n value: ", data$medida)

data <- tibble::as_tibble(data)

# Grafico do donut
donut <- ggplot2::ggplot(data = data, aes(ymax = ymax, ymin = ymin, 
                                          xmax = 4, xmin = 3, 
                                          fill = categoria)) +
  ggplot2::geom_rect() +
  ggplot2::geom_label(x = 3.5, aes(y = labelPosition, label = label), size = 2.5) +
  ggplot2::scale_fill_brewer(palette = 4) +
  ggplot2::coord_polar(theta = "y") +
  ggplot2::xlim(c(2, 4)) +
  ggplot2::theme_void() +
  ggplot2::theme(legend.position = "tail")

# Grafico de bolhas
# Preparabdo os dados
dfBolha <- base::data.frame(
  categoria = dados$nome_orgao,
  medida = dados$diaria
)

dadosBolha <- stats::aggregate(medida ~ categoria,
                               data = dfBolha,
                               FUN = base::sum)

dataBolha <- base::data.frame(grupo = dadosBolha$categoria, 
                              valor = dadosBolha$medida)

packing <- packcircles::circleProgressiveLayout(dataBolha$valor, 
                                                sizetype = "area")

# Ajustando a separacao das bolhas
dataBolha <- base::cbind(dataBolha, packing)

# Centralizacao das bolhas e calculo ao redor do poligono
dat.gg <- packcircles::circleLayoutVertices(packing, npoints = 30)

 # Criando o grafico
bolha <- ggplot2::ggplot() +
  ggplot2::geom_polygon(data = dat.gg, 
                        aes(x, y, group = id, fill = as.factor(id),
                            colour = "black", alpha = 0.6)) +
  ggplot2::geom_text(data = dataBolha, 
                     aes(x, y, size = valor, label = grupo)) +
  ggplot2::scale_size_continuous(range = c(1, 4)) +
  ggplot2::theme_void() +
  ggplot2::theme(legend.position = "none") +
  ggplot2::theme_classic() +
  ggplot2::coord_equal()


(densidade + bin) / (boxPlot + violino + donut) 
bolha
