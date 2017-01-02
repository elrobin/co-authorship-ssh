# Promedio de autores en función del tipo de colaboración institucional

  # Select variables
  tb2 <- data.css.edu[,c(1, 2, 9, 16)]
  # Remove duplicates
  tb2 <- unique(tb2)

# Summarize table
nau.resumen2 <- summarySE(tb2,
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

# Edición de leyenda
fig2 <- fig2 +  scale_colour_hue(name="Tipo de colaboración institucional",
                                 breaks= c("Inst_internacionales",
                                           "Inst_nacionales",
                                           "Una_inst"),
                                 labels= c("Internacional",
                                           "Nacional",
                                           "Sin colaboración"),
                                 l=40,
                                 c=30) +
  theme_bw() +
  theme(legend.position = "top") +
  labs(x = "Año de publicación", y = "Promedio de autores") +
  scale_x_continuous(breaks = seq(2000, 2013, 1)) +
  scale_y_continuous(breaks = seq(0, 8, 1)) +
  ylim(0,7)
