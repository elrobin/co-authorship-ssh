#Import data, libraries


# Load libraries needed
library(ggplot2)
library(readr)
library(plyr)
library (Rmisc)
library(cowplot)

# Import data

data <- read_delim("C:/Users/Usuario/Google Drive/1. Work sync/Training/co-authorship-ssh/data/data_00-13.csv",
                   ";", escape_double = FALSE, col_types = cols(EU_funded = col_logical(),
                                                                colab_group = col_character(), colab_inst = col_logical(),
                                                                colab_inst_ext = col_logical(), sample = col_logical(),
                                                                una_inst = col_logical()), trim_ws = TRUE)

# Select sample only
data.css.edu <- subset(data, subset = sample==1)

attach(data.css.edu)
data.css.edu$py <- as.factor(py) # Convert py to factors