library(pacman)
pacman::p_load(gapminder, tidyverse, ggplot2, plotly, patchwork, hrbrthemes)

#Carga de dados
data <- read.table("https://raw.githubusercontent.com/holtzy/data_to_viz/master/Example_dataset/3_TwoNumOrdered.csv", header=T)
data$date <- as.Date(data$date)
data <- tibble::as_tibble(data)

# Plot
grafico <- data %>% 
        utils::tail(500) %>%
        ggplot2::ggplot( aes(x=date, y=value)) +
        ggplot2::geom_line( color="blue") +
        ggplot2::geom_point(shape=21, color="black", fill="#69b3a2", size=2) +
        hrbrthemes::theme_ipsum() +
        ggplot2::ggtitle("Evolução preço do Bitcoin") +
        ggplot2::labs(x = "Data Avaliação", y = "Valor Bitcon")

plotly::ggplotly()
