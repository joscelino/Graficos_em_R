library(wordcloud)
library(textreadr)
library(RColorBrewer)
library(tm)

# Buscando dados na web
x <- textreadr::read_html("https://pt.wikipedia.org/wiki/Intelig%C3%AAncia_artificial")

# Substituindo
x <- base::gsub("ê",x,replacement = "e", fixed = T)
x <- base::gsub("á",x,replacement = "a", fixed = T)
x <- base::gsub("í",x,replacement = "i", fixed = T)
x <- base::gsub("é",x,replacement = "e", fixed = T)

#geramos um corpus
corpus = VCorpus(VectorSource(x),readerControl = list(reader=readPlain,language = "por"))

#inspecionamos corpus
inspect(corpus) 

#remoções
#stop words
corpus = tm_map(corpus, removeWords,stopwords("portuguese"))
#espaços
corpus = tm_map(corpus , stripWhitespace)
#pontos
corpus  <- tm_map(corpus , removePunctuation)
#numeros
corpus  <- tm_map(corpus , removeNumbers)

#normal
wordcloud(corpus,max.words=100,random.order=T,colors=brewer.pal(n = 9, name = "RdBu"),
          rot.per=0.5,use.r.layout=T)
#alternando fontes
wordcloud(corpus,max.words=100,random.order=T,colors=brewer.pal(n = 9, name = "RdBu"),
          rot.per=0.5,use.r.layout=T, vfont=c("script","plain"))

wordcloud(corpus,max.words=100,random.order=T,colors=brewer.pal(n = 9, name = "RdBu"),
          rot.per=0.5,use.r.layout=T, vfont=c("gothic english","plain"))

wordcloud(corpus,max.words=100,random.order=T,colors=brewer.pal(n = 9, name = "RdBu"),
          rot.per=0.5,use.r.layout=T, vfont=c("serif","plain"))
