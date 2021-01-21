library(ggplot2)
library(dplyr)
library(scales)
library(plotly)
library(gridExtra)

# Classe social, grau de instrucao e estagio da doenca
classe_social <- c('A', 'B', 'C', 'D', 'E')
grau_instrucao <- c('Ensino fundamental', 'Ensino medio', 'Ensino Superior')
grau_doenca <- c('Estagio inicial', 'Estagio intermediario', 'Estagio terminal')
meses <- c('Janeiro', 'Fevereiro', 'Marco')
ranking <- c('Primeiro', 'Segundo', 'Terceiro')

a_classe_social <- sample(classe_social, size = 100, replace = TRUE)
a_grau_instrucao <- sample(grau_instrucao, size = 100, replace = TRUE)
a_grau_doenca <- sample(grau_doenca, size = 100, replace = TRUE)
a_meses <- sample(meses, size = 100, replace = TRUE)
a_ranking <- sample(ranking, size = 100, replace = TRUE)


variaveis_categoricas_ordinais <- data.frame(a_classe_social,
                                             a_grau_instrucao,
                                             a_grau_doenca,
                                             a_meses,
                                             a_ranking)
variaveis_categoricas_ordinais

# Pizza frequencia simples
df_pizza_tab <- table(variaveis_categoricas_ordinais$a_classe_social)
df_pizza <- as.data.frame(df_pizza_tab)
df_pizza

pie(df_pizza$Freq,
    labels = paste(df_pizza$Var1, df_pizza$Freq),
    main = 'Grafico de pizza do numero de pessoas por classe social')

# Pizza frequencia relativa
df_pizza_percent <- prop.table(df_pizza_tab)
df_pizza_percent <- as.data.frame(df_pizza_percent)
df_pizza_percent

pie(df_pizza_percent$Freq,
    labels = paste(df_pizza_percent$Var1, df_pizza_percent$Freq*100, '%'),
    main = 'Grafico de pizza do numero de pessoas por classe social ( Frequencia relativa - %)')

grafico_pizza_iterativo <- plot_ly(df_pizza,
                                   labels = ~Var1,
                                   values = ~Freq,
                                   type = 'pie') %>%
                                   layout(title = 'Frequencia relativa da classa social (%)')
grafico_pizza_iterativo

# Grafico de colunas ou barras verticais
grafico_coluna <- ggplot(variaveis_categoricas_ordinais, aes(x=a_classe_social)) +
  geom_bar(position = 'dodge') +
  ggtitle('Numero de pesssoas por classe social') +
  xlab('Classe Social') + ylab('Numero de pessoas (Frequencia simples)')

ggplotly(grafico_coluna)

# Grafico de colunas ou barras verticais com frequencia relativa
grafico_coluna_percent <- ggplot(variaveis_categoricas_ordinais, aes(x = a_classe_social)) +
  geom_bar(aes(y = (..count..)/sum(..count..))) +
  ggtitle('Numero de pesssoas por classe social') +
  scale_y_continuous(labels = percent) + 
  xlab('Classe Social') + ylab('Numero de pessoas % (Frequencia relativa)')

ggplotly(grafico_coluna_percent)


# Grafico de colunas ou barras verticais com frequencia relativa e grau de instrucao
grafico_coluna_perc_grau_instr<- ggplot(variaveis_categoricas_ordinais, aes(x = a_classe_social,
                                                                     fill = a_grau_instrucao)) +
  geom_bar(position = 'fill', show.legend = FALSE) +
  ggtitle('Numero de pesssoas por classe social') +
  scale_y_continuous(labels = percent) + 
  xlab('Classe Social') + ylab('Numero de pessoas % (Frequencia relativa)')

ggplotly(grafico_coluna_perc_grau_instr)

# Grafico de colunas ou barras verticais com frequencia relativa e grau de instrucao
grafico_coluna_perc_grau_instr_grid<- ggplot(variaveis_categoricas_ordinais, aes(x = a_classe_social,
                                                                       fill = a_grau_instrucao)) +
  geom_bar(aes(y = (..count..)/sum(..count..)), show.legend = FALSE) +
  ggtitle('Numero de pesssoas por classe social') +
  scale_y_continuous(labels = percent) + 
  xlab('Classe Social') + 
  ylab('Numero de pessoas % (Frequencia relativa)') +
  facet_grid(~a_grau_instrucao)

ggplotly(grafico_coluna_perc_grau_instr_grid)


# Grid de Todos os graficos
grid.arrange(grafico_coluna,
             grafico_coluna_percent,
             grafico_coluna_perc_grau_instr,
             grafico_coluna_perc_grau_instr_grid,
             nrow = 2, ncol=2)

