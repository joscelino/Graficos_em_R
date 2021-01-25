library(treemap)

# Copiando as varaveis
usarrests <- USArrests

# Linha para coluna
usarrests['states'] <- base::rownames(USArrests)

# Assault
treemap::treemap(usarrests, index = c('states'),
                 vSize = 'Assault', 
                 title = 'Assaltos nos EUA')
# Murder
treemap::treemap(usarrests, index = c('states'),
                 vSize = 'Murder', 
                 title = 'Assassinatos nos EUA')

# Exemplo 2
# Transformando em Data Frame
titanic <- base::as.data.frame(Titanic)

#Por classe
treemap::treemap(titanic, index = c('Class', 'Survived'),
                 vSize = 'Freq', 
                 title = 'Sobreviventes do Titanic')

# Por classe e sexo
treemap::treemap(titanic, index = c('Class', 'Sex', 'Survived'),
                 vSize = 'Freq', 
                 title = 'Sobreviventes do Titanic')
