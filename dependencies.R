# LIST OF REQUIRED PACKAGES -----------------------------------------------

required_packages <- c(
  "checkpoint"
)

# install missing packages

new.packages <- required_packages[!(required_packages %in% installed.packages()[,"Package"])]

if (length(new.packages)) {
  install.packages(new.packages, dependencies = TRUE)
}

rm(new.packages)

library(checkpoint)
checkpoint(snapshotDate = "2021-01-21")

library(pacman)
library(readxl)
library(readr)
library(ggplot2)
library(plotly)
library(patchwork)
library(lubridate)
library(treemap)
library(RColorBrewer)
library(ggraph)
library(igraph)
library(gapminder)
library(packcircles)
library(wordcloud2)
library(tidyverse)
library(hrbrthemes)
library(Hmisc)
library(scales)
library(gridExtra)

