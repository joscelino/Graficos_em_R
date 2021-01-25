fix(iris)

#duas dimensões
base::plot(iris$Sepal.Length, iris$Sepal.Width, 
           ylab="Comprimento da Sépala", 
           xlab="Largura da Sépala", 
           main="Iris")

#três dimensões
base::plot(iris$Sepal.Length, iris$Sepal.Width, 
           ylab="Comprimento da Sépala", 
           xlab="Largura da Sépala", 
          main="Iris", cex=log(iris$Petal.Length))

#quatro dimensões
base::plot(iris$Sepal.Length, iris$Sepal.Width, 
           ylab="Comprimento da Sépala", 
           xlab="Largura da Sépala", 
           col=iris$Species, main="Iris", 
           pch=20, cex=log(iris$Petal.Length))

legend("bottomright",legend=unique(iris$Species), 
                  fill=c(1:3), cex=0.8)


#cinco dimensões
text(iris$Sepal.Length, iris$Sepal.Width, labels = iris$Petal.Width, 
     adj=0,pos=4, cex=0.6 )


#jitter
base::plot(jitter(iris$Sepal.Length), iris$Sepal.Width, 
           ylab="Comprimento da Sépala", 
           xlab="Largura da Sépala", 
           col=iris$Species, main="Iris", 
           pch=20, cex=log(iris$Petal.Length))

legend("bottomright",legend=unique(iris$Species), fill=c(1:3), cex=0.8)
text(iris$Sepal.Length, iris$Sepal.Width, labels = iris$Petal.Width, pos=4, cex=0.6 )
