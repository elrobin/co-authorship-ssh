#-------------------
# Figuras y tablas - Coautor�a ANECA
#-------------------

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

# Figura 1. Distribuci�n de autores e instituciones

  # Crear data frame con recuento de trabajos por n�mero de instituciones
  insti <- data.frame(table(ins,py))
  # A�adir factor instituciones
  insti$factor <- "Instituciones"
  # Gr�fico instituciones
  p.ins0 <- ggplot(insti, aes(factor(py), Freq)) + geom_boxplot(outlier.shape = NA, fill="#377EB8")
  # Reajustar l�mites
  yp <- subset(insti, Freq>0)
  sts <- boxplot.stats(yp$Freq)$stats
  # Gr�fico final instituciones
  p.ins <- p.ins0 + coord_cartesian(ylim = c(sts[2]/2, max(sts)*0.25)) +
    labs(title = "A",
         x = "A�o de publicaci�n", y = "# instituciones") +
    theme_bw()

  # Crear data frame con recuento de trabajos por n�mero de autores
  aut <- data.frame(table(nau, py))
  # A�adir factor instituciones
  aut$factor <- "Autores"
  # Gr�fico autores
  p.au0 <- ggplot(aut, aes(factor(py), Freq)) + geom_boxplot(outlier.shape = NA, fill = "#FF7F00")
  # Reajustar l�mites
  yp2 <- subset(aut, Freq>0)
  sts2 <- boxplot.stats(aut$Freq)$stats
  # Gr�fico final instituciones
  p.au <- p.au0 + coord_cartesian(ylim = c(sts[2]/2, max(sts)*.5)) +
    labs(title = "B",
         x = "A�o de publicaci�n", y = "# autores") +
    theme_bw()

  #Figura final
  fig1 <- plot_grid(p.ins, p.au, ncol=1, nrow=2)

# Figura 2. Promedio de autores en funci�n del tipo de colaboraci�n institucional
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
  geom_point() +
  geom_hline(aes(yintercept = 4), color = "red", linetype = "dashed")

# Edici�n de leyenda
fig2 <- fig2 +  scale_colour_hue(name="Tipo de colaboraci�n institucional",
                      breaks= c("Inst_internacionales",
                                "Inst_nacionales",
                                "Una_inst"),
                      labels= c("Internacional",
                                "Nacional",
                                "Sin colaboraci�n"),
                      l=40,
                      c=30) +
  theme_bw() +
  theme(legend.position = "top") +
  labs(x = "A�o de publicaci�n", y = "Promedio de autores")

# Figura 3. Financiaci�n, colaboraci�n internacional y citaci�n
  # Crear grupos basados en colab inter/nacional y financiaci�n europea s�/no
  data.css.edu$colab_fund <- ifelse(
    (colab_inst_ext==TRUE) & (EU_funded == TRUE), "EU_inter",
    ifelse(
      (colab_inst_ext==TRUE) & (EU_funded == FALSE), "nEU_inter",
      ifelse(
        (colab_inst_ext==FALSE) & (EU_funded == TRUE), "EU_nac",
        ifelse(
          (colab_inst_ext==FALSE) & (EU_funded == FALSE),"NEU_nAC",NA
        )
      )
    )
  )

  # Crear factores autores en nueva columna
  data.css.edu$Autores <- ifelse(
    (0<nau) & (nau<5), "Entre 1-4 autores", ifelse(
      (4<nau) & (nau<11), "Entre 5-10 autores", ifelse(
        (nau>10), ">10 autores", NA)))

  data.css.edu$Autores <- factor(data.css.edu$Autores, levels = c("Entre 1-4 autores", "Entre 5-10 autores", ">10 autores"))

  # Gr�fico A. Total de publicaciones
  pA <-  ggplot(data.css.edu, aes(colab_fund)) +
    geom_bar(aes(fill = Autores), position = "fill") +
    coord_flip() +
    scale_fill_brewer(palette = "Set1") +
    scale_x_discrete(breaks= c("NEU_nAC", "nEU_inter","EU_nac","EU_inter"),
                     labels=c("Nacional", "Internacional", "Nacional EU", "Internacional EU")) +
    theme_bw() +
    labs(title = "B. Total producci�n", x = element_blank(), y = "Porcentaje de trabajos") +
    theme(legend.position="none")

  # Gr�fico B. 10% m�s citado
  diezmascitado <- subset(data.css.edu, citas>quantile(citas, 0.9))

  pB <-  ggplot(diezmascitado, aes(colab_fund)) +
    geom_bar(aes(fill = Autores), position = "fill") +
    coord_flip() +
    scale_fill_brewer(palette = "Set1") +
    scale_x_discrete(breaks= c("NEU_nAC", "nEU_inter","EU_nac","EU_inter"),
                     labels=c("Nacional", "Internacional", "Nacional EU", "Internacional EU")) +
    theme_bw() +
  labs(title = "C. 10% m�s citado", x = element_blank(), y = "Porcentaje de trabajos") +
    theme(legend.position="none")

  # Gr�fico C. 1% m�s citado
  unomascitado <- subset(data.css.edu, citas>quantile(citas, 0.99))

  pC <-  ggplot(unomascitado[order(unomascitado$Autores),], aes(colab_fund)) +
    geom_bar(aes(fill = Autores), position = "fill") +
    coord_flip() +
    scale_fill_brewer(palette = "Set1") +
    scale_x_discrete(breaks= c("NEU_nAC", "nEU_inter","EU_nac","EU_inter"),
                     labels=c("Nacional", "Internacional", "Nacional EU", "Internacional EU")) +
    theme_bw() +
    labs(title = "D. 1% m�s citado", x = element_blank(), y = "Porcentaje de trabajos") +
    theme(legend.position="none")

  # Gr�fico D. Producci�n

  pD <- total_prod <- data.css.edu[,c(1,13)]
  total_prod$citgroup <- "Total producci�n"
  diez_prod <- diezmascitado[c(1,13)]
  diez_prod$citgroup <- "10% m�s citado"
  uno_prod <- unomascitado[,c(1,13)]
  uno_prod$citgroup <- "1% m�s citado"

  disciplines <- rbind(total_prod,diez_prod,uno_prod)

  disciplines$disc <- factor(disciplines$disc,
                             levels = c("Salud Publica",
                                        "Geografia y Urbanismo",
                                        "Educacion",
                                        "Otras CC Sociales",
                                        "CC Informacion",
                                        "Historia",
                                        "Sociologia",
                                        "Antropologia",
                                        "Ciencias Politicas"))

  colores <- c("#000000", "#999999", "#FFD14C")

  pD <- ggplot(disciplines, aes(disc)) +
    geom_bar(aes(fill= factor(citgroup)), colour="black") +
    theme_bw() +
    scale_fill_manual(values = colores) +
    labs(title = "A. Distribuci�n por disciplinas",
         x = element_blank(), y = element_blank()) +
    theme(legend.title = element_blank(),legend.position = c(.85,.60))


  #Leyenda
  legend <- get_legend(pA + theme(legend.position = "bottom"))

  plots <- grid.arrange(pD, pA, pB, pC, layout_matrix = rbind(c(1,1,1),
                                                              c(2,3,4)))

  #Figura final
  fig3 <- plot_grid(plots, legend, ncol = 1, rel_heights = c(1, .2))
