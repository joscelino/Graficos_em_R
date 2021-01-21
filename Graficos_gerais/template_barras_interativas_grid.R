library(pacman)
pacman::p_load(ggplot2,tidyverse,scales,gridExtra,plotly)

sexo <- c('M', 'F')
cor <- c('Preto', 'Castanho', 'Azul', 'Verde')
cigarro <- c('Fumante', 'Nao fumante')
saude <- c('Doente', 'Sadio')
estado_civil <- c('Solteiro(a)', 'Casado(a)')


a_sexo <- sample(sexo, size = 100, replace = TRUE)
a_cor_olhos <- sample(cor, size = 100, replace = TRUE)
a_fumante <- sample(cigarro, size = 100, replace = TRUE)
a_saude <- sample(saude, size = 100, replace = TRUE)
a_dummy_estado_civil <- ifelse(estado_civil=='Solteiro(a)', '1', '0')


variaveis_categoricas_nominais <- data.frame(a_sexo,
                                             a_cor_olhos,
                                             a_fumante,
                                             a_saude,
                                             a_dummy_estado_civil)
variaveis_categoricas_nominais
view(variaveis_categoricas_nominais)

# Graficos
# ggplot2
# Elementos do grafico ggplot2
#1. Base de dados que sera utilizada
#2. Geometria que sera utilizada (tipo do grafico)
#3. Aesthetic Mapping (parte estetica do grafico)
#5. Rotulos, titulos, legendas

# Grafico de colunas ou barras verticais
grafico_coluna_geral <- ggplot(variaveis_categoricas_nominais, aes(a_cor_olhos)) +
  geom_bar(position = "dodge", fill="red") +
  ggtitle("Numero de pessoas por cor de olhos") + xlab("cor dos olhos") + 
  ylab("Frequencia simples (quantidades de pessoas)")

ggplotly(grafico_coluna_geral)

# Grafico de colunas ou barras verticais
grafico_coluna <- ggplot(variaveis_categoricas_nominais, aes(a_cor_olhos, fill=a_sexo)) +
  geom_bar(position = "dodge") + labs(colour = a_cor_olhos) + 
  ggtitle("Numero de pessoas por cor de olhos e sexo.") + labs(fill = "Sexo") + 
  xlab("cor dos olhos") + ylab("Frequencia simples (quantidades de pessoas)")

ggplotly(grafico_coluna)

# Grafico de colunas ou barras verticais (%)
grafico_coluna_porcent <- ggplot(variaveis_categoricas_nominais, aes(a_cor_olhos, fill=a_sexo)) +
  geom_bar(position = "dodge", aes(y = (..count..)/sum(..count..))) + 
  scale_y_continuous(labels = percent) +
  ggtitle("Numero de pessoas por cor de olhos e sexo.") + labs(fill = "Sexo") + 
  xlab("cor dos olhos") + ylab("Frequencia simples (quantidades de pessoas)")

ggplotly(grafico_coluna_porcent)

# Grafico de colunas ou barras verticais empilhadas(%)
grafico_coluna_empilhada <- ggplot(variaveis_categoricas_nominais, aes(a_cor_olhos, fill=a_sexo)) +
  geom_bar(position = "fill") + 
  scale_y_continuous(labels = percent) +
  ggtitle("Numero de pessoas por cor de olhos e sexo.") + labs(fill = "Sexo") + 
  xlab("cor dos olhos") + ylab("Frequencia simples (quantidades de pessoas)")

ggplotly(grafico_coluna_empilhada)

# Grafico de barras horizontais
grafico_barras_horizontais <- grafico_coluna + coord_flip()
ggplotly(grafico_barras_horizontais)

# Graficos de barras horizontais por sexo
grafico_barras_horizontais_sexo <- grafico_coluna + coord_flip() + facet_grid(~a_sexo)
ggplotly(grafico_barras_horizontais_sexo)


grid.arrange(grafico_coluna_geral,
             grafico_coluna,
             grafico_coluna_porcent,
             grafico_barras_horizontais,
             grafico_barras_horizontais_sexo,
             grafico_coluna_empilhada, nrow = 3, ncol = 2)
