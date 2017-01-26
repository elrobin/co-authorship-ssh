# Analysis of subset of papers w more than 4 authors
#---------------------------------------------------

require(plyr)

#Select subset
mfour <- subset(data.css.edu, subset = nau>4)

# Select variables
mfour <- mfour[,c(1,6,8,9,12,15,17)]

# Remove duplicats
mfour <- unique(mfour)

# Calculate # pubs by wc
pubs <- as.data.frame(t(table(mfour$wc))) #t convierte columnas por filas
pubs <- pubs[,c(2,3)] # Poner bonita
names(pubs) <- c("wc", "# pubs")

# Calculate number of international collaboration
inter.colab <- subset(mfour, subset = inex>0)
inter.colab <- as.data.frame(t(table(inter.colab$wc)))
inter.colab <- inter.colab[,c(2,3)]
names(inter.colab) <- c("wc", "# Colab internacional")

# Calculate number of papers w institutional collab
intra.colab <- subset(mfour, subset = ins>1)
intra.colab <- as.data.frame(t(table(intra.colab$wc)))
intra.colab <- intra.colab[,c(2,3)]
names(intra.colab) <- c("wc", "# Colab institucional")

# EU funded
fund <- subset(mfour, subset = EU_funded==TRUE)
fund <- as.data.frame(t(table(fund$wc)))
fund <- fund[,c(2,3)]
names(fund) <- c("wc", "# EU funded")

# Ave Citations
ave.cit <- as.data.frame(tapply(mfour$citas, mfour$wc, mean))
ave.cit <- cbind(rownames(ave.cit), ave.cit)
names(ave.cit) <- c("wc", "Promedio Citas")

# Median Citations
m.cit <- as.data.frame(tapply(mfour$citas, mfour$wc, median))
m.cit <- cbind(rownames(m.cit), m.cit)
names(m.cit) <- c("wc", "Mediana Citas")

# Join all
tb.mfour <- merge(pubs, intra.colab, all.x = TRUE)
tb.mfour <- merge(tb.mfour, inter.colab, all.x = TRUE)
tb.mfour <- merge(tb.mfour, fund, all.x = TRUE)
tb.mfour <- merge(tb.mfour, ave.cit, all.x = TRUE)
tb.mfour <- merge(tb.mfour, m.cit, all.x = TRUE)

# Export
write.csv2(tb.mfour,
           "C:/Users/Usuario/Google Drive/1. Work sync/Training/co-authorship-ssh/data/tbmas4aut.csv")
