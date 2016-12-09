#-------------------
# Figuras y tablas - Coautoría ANECA
#-------------------

# Load libraries needed
library(ggplot2)
library(readr)
<<<<<<< HEAD
library(plyr)

# Import data
data <- read_delim(
  "C:/Users/Usuario/Google Drive/1. Work sync/Work in progress/co-authorship-ssh/data/2000_2013.txt",
  "\t",
  escape_double = FALSE,
  na = "NULL",
  trim_ws = TRUE)
=======

# Import data
data <- read_delim("C:/Users/nirogar/Google Drive/1. Work sync/Work in progress/co-authorship-ssh/data/2000_2013.txt",
"\t", escape_double = FALSE, na = "NULL",
trim_ws = TRUE)
>>>>>>> 0fbad9911d9295b41eff33c0a5970fd56b8e68d9

attach(data)

# Exploring dataset
data$py <- as.factor(data$py) # Convert py to factors

# Contingency table with n publications by wc and year
pubs.py.wc <- table(wc, py)
pubs.py <- table(py)

# Publicaciones por año
pubs.py <- as.data.frame(pubs.py)
g <- ggplot(pubs.py, aes(py, weight = Freq))
g+geom_bar()

