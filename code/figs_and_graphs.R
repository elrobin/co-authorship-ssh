#-------------------
# Figuras y tablas - Coautoría ANECA
#-------------------

# Import data

library(readr)
data <- read_delim("C:/Users/nirogar/Google Drive/1. Work sync/Work in progress/co-authorship-ssh/data/2000_2013.txt",
"\t", escape_double = FALSE, na = "NULL",
trim_ws = TRUE)

attach(data)

# Exploring dataset
data$py <- as.factor(data$py) # Convert py to factors

# Contingency table with n publications by wc and year
pubs.py.wc <- table(wc, py)

plot(pubs.py.wc)
