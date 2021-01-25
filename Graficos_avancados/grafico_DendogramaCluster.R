library(factoextra)
library(patchwork)

dados <- iris[,-5]

hc <- factoextra::hcut(dados, k = 3, hc_method = "complete", stand = TRUE)
plot(hc)

# Inserindo retagulos ao redor dos grupos
g1 <- factoextra::fviz_dend(hc, show_labels = TRUE, rect = TRUE,
                            ggtheme = ggplot2::theme_bw(),
                            main = "Cluster hieraquico")

# Custer
g2 <- factoextra::fviz_cluster(hc, ellipse.type = "convex",
                            ggtheme = ggplot2::theme_bw(),
                            main = "Agrupamentos do cluster hierarquico")

g1 / g2
