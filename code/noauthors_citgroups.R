# Por citación e intervalos de número de autores
# FIGURA 3

# Seleccionar variables
cit.inter <- data.css.edu[,c(1, 5, 9, 13,15, 17)]
cit.inter <- unique(cit.inter)

# Crear factores autores en nueva columna
attach(cit.inter)
cit.inter$Autores <- ifelse(
  (0<nau) & (nau<5), "Entre 1-4 autores", ifelse(
    (4<nau) & (nau<11), "Entre 5-10 autores", ifelse(
      (nau>10), ">10 autores", NA)))

cit.inter$Autores <- factor(cit.inter$Autores, levels = c("Entre 1-4 autores", "Entre 5-10 autores", ">10 autores"))

# 10% más citado por disciplina

diezmascitado <- subset(
  cit.inter,
  citas> ave(
    citas, disc, FUN= function(x) quantile(x, 0.9)))

# 1% más citado por disciplina

unomascitado <- subset(
  cit.inter,
  citas > ave(
    citas, disc, FUN = function(x) quantile(x, 0.99)))


# Total de publicaciones
  # Colaboración
c1 <-  ggplot(cit.inter, aes(colab_inst_ext)) +
  geom_bar(aes(fill = Autores), position = "fill") +
  coord_flip() +
  scale_fill_brewer(palette = "Set1") +
  scale_x_discrete(breaks= c(TRUE, FALSE),
                   labels=c("Internacional", "Nacional")) +
  theme_bw() +
  labs(title = "A. Total producción", x = element_blank(), y = "% trabajos") +
  theme(legend.position="none")
# Financiación
f1 <-  ggplot(cit.inter, aes(EU_funded)) +
  geom_bar(aes(fill = Autores), position = "fill") +
  coord_flip() +
  scale_fill_brewer(palette = "Set1") +
  scale_x_discrete(breaks= c(TRUE, FALSE),
                   labels=c("Financiación", "Sin Financiación")) +
  theme_bw() +
  labs(title = "D. Total producción", x = element_blank(), y = "% trabajos") +
  theme(legend.position="none")

# 10% más citado
c2 <- ggplot(diezmascitado, aes(colab_inst_ext)) +
  geom_bar(aes(fill = Autores), position = "fill") +
  coord_flip() +
  scale_fill_brewer(palette = "Set1") +
  scale_x_discrete(breaks= c(TRUE, FALSE),
                   labels=c("Internacional", "Nacional")) +
  theme_bw() +
  labs(title = "B. 10% más citado", x = element_blank(), y = "% trabajos") +
  theme(legend.position="none")

f2 <-  ggplot(diezmascitado, aes(EU_funded)) +
  geom_bar(aes(fill = Autores), position = "fill") +
  coord_flip() +
  scale_fill_brewer(palette = "Set1") +
  scale_x_discrete(breaks= c(TRUE, FALSE),
                   labels=c("Financiación", "Sin Financiación")) +
  theme_bw() +
  labs(title = "E. 10% más citado", x = element_blank(), y = "% trabajos") +
  theme(legend.position="none")

# 1% más citado

c3 <- ggplot(unomascitado, aes(colab_inst_ext)) +
  geom_bar(aes(fill = Autores), position = "fill") +
  coord_flip() +
  scale_fill_brewer(palette = "Set1") +
  scale_x_discrete(breaks= c(TRUE, FALSE),
                   labels=c("Internacional", "Nacional")) +
  theme_bw() +
  labs(title = "C. 1% más citado", x = element_blank(), y = "% trabajos") +
  theme(legend.position="none")

f3 <-  ggplot(unomascitado, aes(EU_funded)) +
  geom_bar(aes(fill = Autores), position = "fill") +
  coord_flip() +
  scale_fill_brewer(palette = "Set1") +
  scale_x_discrete(breaks= c(TRUE, FALSE),
                   labels=c("Financiación", "Sin Financiación")) +
  theme_bw() +
  labs(title = "F. 1% más citado", x = element_blank(), y = "% trabajos") +
  theme(legend.position="none")

# Gráfico D. Producción

# pD <- total_prod <- cit.inter[,c(1,4)]
# total_prod$fund <- ifelse(cit.inter$EU_funded == TRUE,
#                           "Con financiación EU",
#                           "Sin financiación EU")
# diez_prod <- diezmascitado[c(1,4)]
# diez_prod$citgroup <- "10% más citado"
# uno_prod <- unomascitado[,c(1,4)]
# uno_prod$citgroup <- "1% más citado"
#
# disciplines <- rbind(total_prod,diez_prod,uno_prod)
#
# disciplines$disc <- factor(disciplines$disc,
#                            levels = c("Salud Publica",
#                                       "Geografia y Urbanismo",
#                                       "Educacion",
#                                       "Otras CC Sociales",
#                                       "CC Informacion",
#                                       "Historia",
#                                       "Sociologia",
#                                       "Antropologia",
#                                       "Ciencias Politicas"))
#
# colores <- c("#000000", "#999999", "#FFD14C")
#
# pD <- ggplot(disciplines, aes(disc)) +
#   geom_bar(aes(fill= factor(citgroup)), colour="black") +
#   theme_bw() +
#   scale_fill_manual(values = colores) +
#   labs(title = "A. Distribución por disciplinas",
#        x = element_blank(), y = element_blank()) +
#   theme(legend.title = element_blank(),legend.position = c(.85,.60))


#Leyenda
legend <- get_legend(c1 + theme(legend.position = "bottom"))

require(gridExtra)
plots <- grid.arrange(c1, c2, c3, f1, f2, f3, layout_matrix = rbind(c(1,2,3),
                                                            c(4,5,6)))

#Figura final
fig3 <- plot_grid(plots, legend, ncol = 1, rel_heights = c(1, .2))
