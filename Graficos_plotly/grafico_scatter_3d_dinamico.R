# https://plotly.com/r/3d-scatter-plots/
library(plotly)

data <- read.csv("https://raw.githubusercontent.com/plotly/datasets/master/gapminderDataFiveYear.csv")

data_2007 <- data[which(data$year == 2007),]
data_2007 <- data_2007[order(data_2007$continent, data_2007$country),]
data_2007$size <- data_2007$pop
colors <- c('#4AC6B7', '#1972A4', '#965F8A', '#FF7070', '#C61951')

fig <- plot_ly(data_2007, x = ~gdpPercap, y = ~lifeExp, z = ~pop, color = ~continent, size = ~size, colors = colors,
               marker = list(symbol = 'circle', sizemode = 'diameter'), sizes = c(5, 150),
               text = ~paste('Country:', country, '<br>Life Expectancy:', lifeExp, '<br>GDP:', gdpPercap,
                             '<br>Pop.:', pop))
fig <- fig %>% layout(title = 'Life Expectancy v. Per Capita GDP, 2007',
                      scene = list(xaxis = list(title = 'GDP per capita (2000 dollars)',
                                                gridcolor = 'rgb(255, 255, 255)',
                                                range = c(2.003297660701705, 5.191505530708712),
                                                type = 'log',
                                                zerolinewidth = 1,
                                                ticklen = 5,
                                                gridwidth = 2),
                                   yaxis = list(title = 'Life Expectancy (years)',
                                                gridcolor = 'rgb(255, 255, 255)',
                                                range = c(36.12621671352166, 91.72921793264332),
                                                zerolinewidth = 1,
                                                ticklen = 5,
                                                gridwith = 2),
                                   zaxis = list(title = 'Population',
                                                gridcolor = 'rgb(255, 255, 255)',
                                                type = 'log',
                                                zerolinewidth = 1,
                                                ticklen = 5,
                                                gridwith = 2)),
                      paper_bgcolor = 'rgb(243, 243, 243)',
                      plot_bgcolor = 'rgb(243, 243, 243)')

fig