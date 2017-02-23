# Distribution by discipline #
#-----------

require(ggplot2)

# Select variables
disc.distro <- data.css.edu[,c(1, 5, 12)]
disc.distro <- unique(disc.distro)

# Edit order of disciplines
disc.distro$wc <- factor(disc.distro$wc,
       levels = c("Ethnic Studies",
                  "Area Studies",
                  "Social Work",
                  "Education, Special",
                  "Family Studies",
                  "Social Issues",
                  "Industrial Relations & Labor",
                  "International Relations",
                  "Ergonomics",
                  "Hospitality, Leisure, Sport & Tourism",
                  "Political Science",
                  "Communication",
                  "Social Sciences, Interdisciplinary",
                  "Sociology",
                  "Social Sciences, Mathematical Methods",
                  "Linguistics",
                  "Anthropology",
                  "Education, Scientific Disciplines",
                  "Information Science & Library Science",
                  "Education & Educational Research"
                  ))

colores <- c("#999999", "#FFD14C")

# plot
d1 <- ggplot(disc.distro, aes(wc)) +
  geom_bar(aes(fill= factor(colab_inst_ext)), colour="black") +
  theme_bw() + coord_flip() +
  scale_fill_manual(values = colores,
                    name = element_blank(),
                    breaks = c(TRUE, FALSE),
                    labels = c("Sí", "No")) +
  labs(title = "A. Colaboración internacional", x = "", y = element_blank()) +
  theme(legend.background = element_blank(), legend.position = c(0.9,0.25))

# EU Funding

fund.distro <- data.css.edu[,c(1, 12, 17)]
fund.distro <- unique(fund.distro)

  # Select only funded papers
  fund.distro.y <- subset(fund.distro, subset = EU_funded==1)

fund.distro.y$wc <- factor(fund.distro.y$wc,
                           levels = c("Ethnic Studies",
                                      "Area Studies",
                                      "Education, Special",
                                      "Family Studies",
                                      "Industrial Relations & Labor",
                                      "Social Work",
                                      "Ergonomics",
                                      "Social Issues",
                                      "Hospitality, Leisure, Sport & Tourism",
                                      "Communication",
                                      "International Relations",
                                      "Social Sciences, Interdisciplinary",
                                      "Linguistics",
                                      "Anthropology",
                                      "Sociology",
                                      "Political Science",
                                      "Social Sciences, Mathematical Methods",
                                      "Information Science & Library Science",
                                      "Education, Scientific Disciplines",
                                      "Education & Educational Research"
                                      ))

# plot
d2 <- ggplot(fund.distro.y, aes(wc)) +
  geom_bar(fill = "DarkGrey", colour="black") +
  theme_bw() + coord_flip() +
  labs(title = "B. Financiación Europea", x = "", y = element_blank())

# Merge plots
require(gridExtra)

grid.arrange(d1,d2, layout_matrix = rbind(c(1), (2)))
