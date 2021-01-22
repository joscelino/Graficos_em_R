library(pacman)
pacman::p_load(tidyverse, dplyr, scales, ggplot2, plotly, patchwork, gridExtra)

# Grafico histograma
dplyr::glimpse(iris)
dados <- iris
histograma <- ggplot2::ggplot(dados, aes(x = Sepal.Length, colour = Species)) +
  ggplot2::geom_histogram(fill = "lightblue", bins = 30) +
  ggplot2::ggtitle("Histograma do tamanho da sepala das plantas") +
  ggplot2::xlab("Tamanho das sepalas") +
  ggplot2::ylab("Frequencia") +
  ggplot2::theme_classic()

# BoxPlot
graf_boxplot <- ggplot2::ggplot(dados, 
                                aes(x = Sepal.Length, y = Petal.Length,
                                    fill = Species)) +
  ggplot2::geom_boxplot(notch = FALSE, show.legend = TRUE, position = "dodge2") +
  ggplot2::ggtitle("Box plot do tamanho da sepala vs tamano das petalas das plantas") +
  ggplot2::xlab("Tamanho das sepalas") +
  ggplot2::ylab("Tamanho das petalas") +
  ggplot2::theme_classic()

# Violino
violino <- ggplot2::ggplot(dados, 
                           aes(x = Sepal.Length, y = Petal.Length,
                               fill = Species)) +
  ggplot2::geom_violin(aes(fill = Species), 
                       draw_quantiles = c(0.25, 0.50, 0.75), position = "dodge") +
  ggplot2::ggtitle("Grafico Violino do tamanho da sepala vs tamano das petalas das plantas") +
  ggplot2::xlab("Tamanho das sepalas") +
  ggplot2::ylab("Tamanho das petalas") +
  ggplot2::theme_classic()

# Dispersao de cores
grafico_dispersao_cor <- ggplot2::ggplot(dados, 
                                         aes(x = Sepal.Length, y = Petal.Length,
                                             col = Species)) +
  ggplot2::geom_point(size = 2.5)+
  ggplot2::ggtitle("Grafico de dispersao do tamanho da sepala vs tamano das petalas das plantas") +
  ggplot2::xlab("Tamanho das sepalas") +
  ggplot2::ylab("Tamanho das petalas") +
  ggplot2::theme_classic()

# Dispersao cor e tamanho
grafico_dispersao_tam <- ggplot2::ggplot(dados, 
                                         aes(x = Sepal.Length, y = Petal.Length,
                                             col = Species)) +
  ggplot2::geom_point(aes(size = Species)) +
  ggplot2::ggtitle("Grafico de dispersao do tamanho da sepala vs tamano das petalas das plantas") +
  ggplot2::xlab("Tamanho das sepalas") +
  ggplot2::ylab("Tamanho das petalas") +
  ggplot2::theme_classic()

# Grafico dispersao por especie
grafico_dispersao_especie <- ggplot2::ggplot(dados, 
                                         aes(x = Sepal.Length, y = Petal.Length,
                                             col = Species)) +
  ggplot2::geom_point(size = 2.5)+
  ggplot2::ggtitle("Grafico de dispersao do tamanho da sepala vs tamano das petalas das plantas") +
  ggplot2::xlab("Tamanho das sepalas - Por especie") +
  ggplot2::ylab("Tamanho das petalas") +
  ggplot2::facet_wrap(~ Species)
  ggplot2::theme_classic()

# GRID
(histograma + graf_boxplot + violino) / (grafico_dispersao_tam + grafico_dispersao_especie)

# Grafico linhas
  dados2 <- economics
  dplyr::glimpse(dados2)
  grafico_linhas <- ggplot2::ggplot(dados2, aes(x = date, y = unemploy)) +
    ggplot2::geom_line(col = "red") +
    ggplot2::ggtitle("Desemprego nos Estados Unidos de 1967 a 2015 - Economics") +
    ggplot2::xlab("Ano") +
    ggplot2::ylab("Desemprego em milhares") +
    ggplot2::theme_classic()
  
plotly::ggplotly(grafico_linhas)
  