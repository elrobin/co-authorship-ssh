# Tabla media de autores por año y wc/disc
#-------------------------------------------


# Select variables
tb <- data.css.edu[,c(1, 9, 12, 13, 16)]

# Remove duplicates
tb <- unique(tb)

# Select year and calculate mean by wc

  # 2000
  d0 <- subset(tb, subset = py==2000)
  # Calculate mean
  d0.au <- as.data.frame(tapply(d0$nau, d0$wc, mean)) # 19
  d0.au <- cbind(rownames(d0.au), d0.au)
  names(d0.au) <- c("wc", 2000)
  # 2001
  d1 <- subset(tb, subset = py==2001)
  # Calculate mean
  d1.au <- as.data.frame(tapply(d1$nau, d1$wc, mean)) # 20
  d1.au <- cbind(rownames(d1.au), d1.au)
  names(d1.au) <- c("wc",2001)
  # 2002
  d2 <- subset(tb, subset = py==2002)
  # Calculate mean
  d2.au <- as.data.frame(tapply(d2$nau, d2$wc, mean))
  d2.au <- cbind(rownames(d2.au), d2.au)
  names(d2.au) <- c("wc",2002)
  # 2003
  d3 <- subset(tb, subset = py==2003)
  # Calculate mean
  d3.au <- as.data.frame(tapply(d3$nau, d3$wc, mean))
  d3.au <- cbind(rownames(d3.au), d3.au)
  names(d3.au) <- c("wc",2003)
  # 2004
  d4 <- subset(tb, subset = py==2004)
  # Calculate mean
  d4.au <- as.data.frame(tapply(d4$nau, d4$wc, mean))
  d4.au <- cbind(rownames(d4.au), d4.au)
  names(d4.au) <- c("wc",2004)
  # 2005
  d5 <- subset(tb, subset = py==2005)
  # Calculate mean
  d5.au <- as.data.frame(tapply(d5$nau, d5$wc, mean))
  d5.au <- cbind(rownames(d5.au), d5.au)
  names(d5.au) <- c("wc",2005)
  # 2006
  d6 <- subset(tb, subset = py==2006)
  # Calculate mean
  d6.au <- as.data.frame(tapply(d6$nau, d6$wc, mean))
  d6.au <- cbind(rownames(d6.au), d6.au)
  names(d6.au) <- c("wc",2006)
  # 2007
  d7 <- subset(tb, subset = py==2007)
  # Calculate mean
  d7.au <- as.data.frame(tapply(d7$nau, d7$wc, mean))
  d7.au <- cbind(rownames(d7.au), d7.au)
  names(d7.au) <- c("wc",2007)
  # 2008
  d8 <- subset(tb, subset = py==2008)
  # Calculate mean
  d8.au <- as.data.frame(tapply(d8$nau, d8$wc, mean))
  d8.au <- cbind(rownames(d8.au), d8.au)
  names(d8.au) <- c("wc",2008)
  # 2009
  d9 <- subset(tb, subset = py==2009)
  # Calculate mean
  d9.au <- as.data.frame(tapply(d9$nau, d9$wc, mean))
  d9.au <- cbind(rownames(d9.au), d9.au)
  names(d9.au) <- c("wc",2009)
  # 2010
  d10 <- subset(tb, subset = py==2010)
  # Calculate mean
  d10.au <- as.data.frame(tapply(d10$nau, d10$wc, mean))
  d10.au <- cbind(rownames(d10.au), d10.au)
  names(d10.au) <- c("wc",2010)
  # 2011
  d11 <- subset(tb, subset = py==2011)
  # Calculate mean
  d11.au <- as.data.frame(tapply(d11$nau, d11$wc, mean))
  d11.au <- cbind(rownames(d11.au), d11.au)
  names(d11.au) <- c("wc",2011)
  # 2012
  d12 <- subset(tb, subset = py==2012)
  # Calculate mean
  d12.au <- as.data.frame(tapply(d12$nau, d12$wc, mean))
  d12.au <- cbind(rownames(d12.au), d12.au)
  names(d12.au) <- c("wc",2012)
  # 2013
  d13 <- subset(tb, subset = py==2013)
  # Calculate mean
  d13.au <- as.data.frame(tapply(d13$nau, d13$wc, mean))
  d13.au <- cbind(rownames(d13.au), d13.au)
  names(d13.au) <- c("wc",2013)

# Merge all
tb.au.wc <- merge(d0.au, d1.au, all.y = TRUE)
tb.au.wc <- merge(tb.au.wc, d2.au, all.x = TRUE)
tb.au.wc <- merge(tb.au.wc, d3.au, all.x = TRUE)
tb.au.wc <- merge(tb.au.wc, d4.au, all.x = TRUE)
tb.au.wc <- merge(tb.au.wc, d5.au, all.x = TRUE)
tb.au.wc <- merge(tb.au.wc, d6.au, all.x = TRUE)
tb.au.wc <- merge(tb.au.wc, d7.au, all.x = TRUE)
tb.au.wc <- merge(tb.au.wc, d8.au, all.x = TRUE)
tb.au.wc <- merge(tb.au.wc, d9.au, all.x = TRUE)
tb.au.wc <- merge(tb.au.wc, d10.au, all.x = TRUE)
tb.au.wc <- merge(tb.au.wc, d11.au, all.x = TRUE)
tb.au.wc <- merge(tb.au.wc, d12.au, all.x = TRUE)
tb.au.wc <- merge(tb.au.wc, d13.au, all.x = TRUE)

write.csv2(tb.au.wc,
           "C:/Users/Usuario/Google Drive/1. Work sync/Training/co-authorship-ssh/data/tablaautores.csv")
