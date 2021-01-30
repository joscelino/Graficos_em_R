library(plotly)
library(gapminder)

# Iris
graf <- plotly::plot_ly(data = iris, x = ~Sepal.Length, y = ~Sepal.Width,
                        type = "scatter", mode = "markers",
                        color = ~Species, size = ~iris$Petal.Length,
                        frame = ~Species)
graf

# Gapminder
graf <- plotly::plot_ly(data = gapminder, x = ~lifeExp, y = ~pop,
                       type = "scatter", color = ~continent,
                       mode = 'markers', text = ~country,
                       frame = ~year)
graf

# Filtrar continente
gapm = gapminder[gapminder$continent=="Americas",]

graf <- plotly::plot_ly(data = gapm, x = ~lifeExp, y = ~pop,
                        type = "scatter", color = ~country,
                        mode = 'markers', text = ~country,
                        frame = ~year)
graf
