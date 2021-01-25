library(igraph)
library(igraphdata)
library(rgl)

# Pontes de Koenigsberg
utils::data(Koenigsberg)
base::plot(Koenigsberg)

# Sociedade ficticia
utils::data(kite)

# Alterando a cor do vertice
base::plot(kite, vertex.color = "gray", main = "Kite")

# Alterando o tamanho do vertice
base::plot(kite, vertex.color = "gray", vertex.size = 23, main = "Kite")

# Alterando a largura da aresta
base::plot(kite, vertex.color = "gray", vertex.size = 23, 
           edge.width = 3, main = "Kite")

# Alterando a cor da aresta
base::plot(kite, vertex.color = "gray", vertex.size = 23, 
           edge.width = 3, edge.color = "green", main = "Kite")

# Alterando a curvatura da aresta
base::plot(kite, vertex.color = "gray", vertex.size = 23, 
           edge.width = 3, edge.color = "green", 
           edge.curved = 0.4, main = "Kite")

# Muda o formato do vertice e adiciona moldura
base::plot(kite, vertex.color = "gray", vertex.size = 23, 
           edge.width = 3, edge.color = "green", vertex.shape = "square",
           edge.curved = 0.4, frame = TRUE, main = "Kite")

# 2d interativo
igraph::tkplot(kite)

# 3d interativo
igraph::rglplot(kite)
