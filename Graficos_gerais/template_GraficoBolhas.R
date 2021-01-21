library(pacman)
pacman::p_load(gapminder, tidyverse, ggplot2, plotly, patchwork)

# Carga dos dados
dados <- gapminder::gapminder %>% dplyr::filter(year=="2007") %>%
  dplyr::select(-year)

# Exibicao do grafico de Bolhas
graficoBolhas <- dados %>% 
              dplyr::arrange(desc(pop)) %>%
              dplyr::mutate(country = base::factor(country, country)) %>%
              ggplot2::ggplot(aes(x = gdpPercap, y = lifeExp, 
                                  size = pop, color = continent)) +
              ggplot2::geom_point(alpha = 0.7) +
              ggplot2::scale_size(range = c(.5, 20), name = "Populacao (M)") +
              ggplot2::labs(x = "Valor per Capita", y = "Expectiva de Vida") +
              ggplot2::theme_classic() 
plotly::ggplotly(graficoBolhas)              
