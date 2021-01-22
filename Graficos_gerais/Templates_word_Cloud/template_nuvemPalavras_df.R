library(wordcloud2)
library(RColorBrewer)
library(tibble)

# Dados
palavras <- c("AI", "Machine Learning", "Neural Networks", "Deep Learning",
              "Random Forest", "SVM", "GA", "Naive Bayes", "Python",
              "CNN", "Spark", "Hadoop", "SOM", "Radial Basis Function",
              "Estatistica", "Pesquisa Operacional")
frequencia <- c(29, 15, 25, 17,
                25, 4, 12, 7, 9,
                5, 8, 35, 13, 6,
                33, 3)
# Data Frame
words <- data.frame(palavras,frequencia)
words <- tibble::as_tibble(words)
words$palavras <- base::factor(words$palavras)

# Basico
wordcloud2::wordcloud2(data = words, 
                       color = RColorBrewer::brewer.pal(n = 9, name = "RdBu"))
# Definindo percentual de rotacao
wordcloud2::wordcloud2(data = words, 
                       color = RColorBrewer::brewer.pal(n = 9, name = "RdBu"),
                       rotateRatio = 0.8)
