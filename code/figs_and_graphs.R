#-------------------
# Figuras y tablas - Coautoría ANECA
#-------------------

# Load libraries needed
library(ggplot2)
library(readr)
library(plyr)

# Import data

data <- read_delim("C:/Users/Usuario/Google Drive/1. Work sync/Work in progress/co-authorship-ssh/data/data_00-13.csv",
";", escape_double = FALSE, col_types = cols(EU_funded = col_logical(),
colab_group = col_character(), colab_inst = col_logical(),
colab_inst_ext = col_logical(), sample = col_logical(),
una_inst = col_logical()), trim_ws = TRUE)

# Select sample only
data.css.edu <- subset(data, subset = sample==1)

attach(data.css.edu)

# Exploring dataset
data.css.edu$py <- as.factor(py) # Convert py to factors

# Contingency table with n publications by wc and year
pubs.py.wc <- table(wc, py)
pubs.py <- table(py)

# Publicaciones por año
pubs.py <- as.data.frame(pubs.py)
g <- ggplot(pubs.py, aes(py, weight = Freq))
g+geom_bar()

# Descriptive indicators by year:

nau.resumen <- ddply(data.css.edu,
                      .(py), summarize,
                      avg_au = mean(nau),
                      std_au = sd(nau),
#                      cuartil_au = quantile(nau),
                     avg_auext = mean(nauext),
                     std_auext = sd(nauext),
#                     cuartil_auext = quantile(nauext),
                     avg_auesp = mean(nauesp),
                     std_auesp = sd(nauesp),
#                     cuartil_auesp = quantile(nauesp),
                      avg_ins = mean(ins),
                    std_ins = sd(ins),
#                    cuartil_ins = quantile(ins),
                    avg_ines = mean(ines),
                    std_ines = sd(ines),
#                    cuartil_ines = quantile(ines),
                    avg_ines = mean(ines),
                    std_ines = sd(ines),
#                    cuartil_ines = quantile(inex),
                    avg_inex = mean(inex),
                    std_inex = sd(inex)
#                      ,cuartil_inex = quantile(inex)
)

# Gráfico, promedio de autores, de extranjeros, españoles, instituciones,
# extranjeras, españolas y año

ggplot(nau.resumen, aes(y=avg_au, x = py, group=1)) + geom_line() + geom_point()
ggplot(nau.resumen, aes(y=avg_auext, x = py, group=1)) + geom_line() + geom_point()
ggplot(nau.resumen, aes(y=avg_auesp, x = py, group=1)) + geom_line() + geom_point()

ggplot(nau.resumen, aes(y=avg_ins, x = py, group=1)) + geom_line() + geom_point()
ggplot(nau.resumen, aes(y=avg_ines, x = py, group=1)) + geom_line() + geom_point()
ggplot(nau.resumen, aes(y=avg_inex, x = py, group=1)) + geom_line() + geom_point()

# Figura 1. Promedio de autores en función del tipo de colaboración institucional
nau.resumen2 <- summarySE(data.css.edu,
measurevar="nau",
groupvars=c("py","colab_group"))

# Convertir se=Na en ceros
nau.resumen2$se[is.na(nau.resumen2$se)] <- 0

pd <- position_dodge(0.1)

fig1 <- ggplot(nau.resumen2, aes(x=py, y=nau, colour=colab_group)) +
  geom_errorbar(aes(ymin=nau-se, ymax=nau+se, group=colab_group),
  width=.1,
  position=pd) +
  geom_line(aes(group=colab_group)) +
  geom_point()

# Edición de leyenda
fig1.l <- fig1 +  scale_colour_hue(name="Tipo de colaboración institucional",
                      breaks= c("Inst_internacionales",
                                "Inst_nacionales",
                                "Una_inst"),
                      labels= c("Internacional",
                                "Nacional",
                                "Sin colaboración")) +
  theme_bw() +
  theme(legend.position = "top") +
  labs(x = "Año de publicación", y = "Promedio de autores")



