# Tabla 1. Descriptiva

attach(data.css.edu)

# Select variables
tb <- data.css.edu[,c(1, 6, 9, 16)]

# Remove duplicates
tb <- unique(tb)

# Count by year
pubs.y <- as.data.frame(t(table(tb$py))) #t convierte columnas por filas
pubs.y <- pubs.y[,c(2,3)] # Poner bonita
names(pubs.y) <- c("py", "pubs")
  # Instituciones
  ins.y.m <- as.data.frame(tapply(tb$ins, tb$py, mean))
  names(ins.y.m) <- "Media Ins"
  ins.y.sd <- as.data.frame(tapply(tb$ins, tb$py, sd))
  names(ins.y.sd) <- "Desviación Ins"
  ins.y.median <- as.data.frame(tapply(tb$ins, tb$py, median))
  names(ins.y.median) <- "Mediana Ins"
  # Autores
  au.y.m <- as.data.frame(tapply(tb$nau, tb$py, mean))
  names(au.y.m) <- "Media Au"
  au.y.sd <- as.data.frame(tapply(tb$nau, tb$py, sd))
  names(au.y.sd) <- "Desviación Au"
  au.y.median <- as.data.frame(tapply(tb$nau, tb$py, median))
  names(au.y.median) <- "Mediana Au"
  # Unir todo
tb1 <- cbind(pubs.y, au.y.m, au.y.sd, au.y.median, ins.y.m, ins.y.sd, ins.y.median)

# Export table

write.csv2(tb1,
           "C:/Users/Usuario/Google Drive/1. Work sync/Training/co-authorship-ssh/data/tabla1.csv")
