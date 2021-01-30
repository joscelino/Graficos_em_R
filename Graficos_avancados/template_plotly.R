library(plotly)

# basico
graf <- plot_ly(data = iris, x = ~Sepal.Length, y = ~Sepal.Width,
                        type = "scatter", mode = "markers")
graf

# Categoria
graf <- plotly::plot_ly(data = iris, x = ~Sepal.Length, y = ~Sepal.Width,
                        type = "scatter", mode = "markers",
                        color = ~Species)
graf

# Mais de uma dimensao 
graf <- plotly::plot_ly(data = iris, x = ~Sepal.Length, y = ~Sepal.Width,
                        type = "scatter", mode = "markers",
                        color = ~Species, size = ~iris$Petal.Length)
graf

# Label
graf <- plotly::plot_ly(data = iris, x = ~Sepal.Length, y = ~Sepal.Width,
                        type = "scatter", mode = "markers",
                        color = ~Species, size = ~iris$Petal.Length,
                        text = ~Petal.Width)
graf

# Sumarizando dados
InsectSprays
spray <- stats::aggregate(. ~ spray, data = InsectSprays, sum)
spray

# Barras
graf <- plotly::plot_ly(data = spray, x = ~spray, y = ~count, type = "bar")
graf

# Cores
graf <- plotly::plot_ly(data = spray, x = ~spray, y = ~count, type = "bar",
                        color = ~spray)
graf

# setor
graf <- plotly::plot_ly(data = spray,labels = ~spray, 
                        values = ~count, type = "pie")
graf

