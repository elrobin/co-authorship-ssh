#-------------------
# Figuras y tablas - Coautoría ANECA
#-------------------

# Load libraries needed
library(ggplot2)
library(readr)
library(plyr)
library (Rmisc)

# Import data

data <- read_delim("C:/Users/nirogar/Google Drive/1. Work sync/Work in progress/co-authorship-ssh/data/data_00-13.csv",
";", escape_double = FALSE, col_types = cols(EU_funded = col_logical(),
colab_group = col_character(), colab_inst = col_logical(),
colab_inst_ext = col_logical(), sample = col_logical(),
una_inst = col_logical()), trim_ws = TRUE)

# Select sample only
data.css.edu <- subset(data, subset = sample==1)

attach(data.css.edu)

# Exploring dataset
data.css.edu$py <- as.factor(py) # Convert py to factors

# Gráfico, promedio de autores, de extranjeros, españoles, instituciones,
# extranjeras, españolas y año

ggplot(nau.resumen, aes(y=avg_au, x = py, group=1)) + geom_line() + geom_point()
ggplot(nau.resumen, aes(y=avg_auext, x = py, group=1)) + geom_line() + geom_point()
ggplot(nau.resumen, aes(y=avg_auesp, x = py, group=1)) + geom_line() + geom_point()

ggplot(nau.resumen, aes(y=avg_ins, x = py, group=1)) + geom_line() + geom_point()
ggplot(nau.resumen, aes(y=avg_ines, x = py, group=1)) + geom_line() + geom_point()
ggplot(nau.resumen, aes(y=avg_inex, x = py, group=1)) + geom_line() + geom_point()

# Figura 1. Distribución de autores e instituciones

  # Crear data frame con recuento de trabajos por número de instituciones
  insti <- data.frame(table(ins,py))
  # Añadir factor instituciones
  insti$factor <- "Instituciones"
  # Gráfico instituciones
  p.ins0 <- ggplot(insti, aes(factor(py), Freq)) + geom_boxplot(outlier.shape = NA)
  # Reajustar límites
  yp <- subset(insti, Freq>0)
  sts <- boxplot.stats(yp$Freq)$stats
  # Gráfico final instituciones
  p.ins <- p.ins0 + coord_cartesian(ylim = c(sts[2]/2, max(sts)*0.25)) +
    labs(title = "A. Instituciones por trabajo",
         x = "Año de publicación", y = "# de autores") +
    theme_bw()

  # Crear data frame con recuento de trabajos por número de autores
  aut <- data.frame(table(nau, py))
  # Añadir factor instituciones
  aut$factor <- "Autores"
  # Gráfico autores
  p.au0 <- ggplot(aut, aes(factor(py), Freq)) + geom_boxplot(outlier.shape = NA)
  # Reajustar límites
  yp2 <- subset(aut, Freq>0)
  sts2 <- boxplot.stats(aut$Freq)$stats
  # Gráfico final instituciones
  p.au <- p.au0 + coord_cartesian(ylim = c(sts[2]/2, max(sts)*1.05)) +
    labs(title = "B. Autores por trabajo",
         x = "Año de publicación", y = "# de autores") +
    theme_bw()

  #Figura final
  fig1 <- plot_grid(p.ins, p.au, ncol=1, nrow=2)

# Figura 2. Promedio de autores en función del tipo de colaboración institucional
nau.resumen2 <- summarySE(data.css.edu,
measurevar="nau",
groupvars=c("py","colab_group"))

# Convertir se=Na en ceros
nau.resumen2$se[is.na(nau.resumen2$se)] <- 0

pd <- position_dodge(0.1)

fig2 <- ggplot(nau.resumen2, aes(x=py, y=nau, colour=colab_group)) +
  geom_errorbar(aes(ymin=nau-se, ymax=nau+se, group=colab_group),
  width=.1,
  position=pd) +
  geom_line(aes(group=colab_group)) +
  geom_point()

# Edición de leyenda
fig2 <- fig2 +  scale_colour_hue(name="Tipo de colaboración institucional",
                      breaks= c("Inst_internacionales",
                                "Inst_nacionales",
                                "Una_inst"),
                      labels= c("Internacional",
                                "Nacional",
                                "Sin colaboración")) +
  theme_bw() +
  theme(legend.position = "top") +
  labs(x = "Año de publicación", y = "Promedio de autores")



