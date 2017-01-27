# Distribution by discipline #
#-----------

require(ggplot2)

# Select variables
disc.distro <- data.css.edu[,c(1, 5, 12)]
disc.distro <- unique(disc.distro)

# Edit order of disciplines
disc.distro$disc <- factor(disc.distro$disc,
       levels = c("Education & Educational Research",
                  "Information Science & Library Science",
                  "Education, Scientific Disciplines",
                  "Anthropology",
                  "Linguistics",
                  "Social Sciences, Mathematical Methods",
                  "Sociology",
                  "Social Sciences, Interdisciplinary",
                  "Communication",
                  "Political Science",
                  "Hospitality, Leisure, Sport & Tourism",
                  "Ergonomics",
                  "International Relations",
                  "Industrial Relations & Labor",
                  "Social Issues",
                  "Family Studies",
                  "Education, Special",
                  "Social Work",
                  "Area Studies",
                  "Ethnic Studies"))

colores <- c("#999999", "#FFD14C")

# plot
d1 <- ggplot(disc.distro, aes(disc)) +
  geom_bar(aes(fill= factor(colab_inst_ext)), colour="black") +
  theme_bw() + coord_flip() +
  scale_fill_manual(values = colores,
                    name = element_blank(),
                    breaks = c(TRUE, FALSE),
                    labels = c("Sí", "No")) +
  labs(title = "A. Colaboración internacional", x = "", y = element_blank()) +
  theme(legend.background = element_blank(), legend.position = c(0.9,0.25))

# EU Funding

fund.distro <- data.css.edu[,c(1, 13, 17)]
fund.distro <- unique(fund.distro)

  # Select only funded papers
  fund.distro.y <- subset(fund.distro, subset = EU_funded==1)

fund.distro.y$disc <- factor(fund.distro.y$disc,
                           levels = c(	"Education & Educational Research",
                                       "Information Science & Library Science",
                                       "Education, Scientific Disciplines",
                                       "Anthropology",
                                       "Linguistics",
                                       "Social Sciences, Mathematical Methods",
                                       "Sociology",
                                       "Social Sciences, Interdisciplinary",
                                       "Communication",
                                       "Political Science",
                                       "Hospitality, Leisure, Sport & Tourism",
                                       "Ergonomics",
                                       "International Relations",
                                       "Industrial Relations & Labor",
                                       "Social Issues",
                                       "Family Studies",
                                       "Education, Special",
                                       "Social Work",
                                       "Area Studies",
                                       "Ethnic Studies"))

# plot
d2 <- ggplot(fund.distro.y, aes(disc)) +
  geom_bar(fill = "DarkGrey", colour="black") +
  theme_bw() + coord_flip() +
  labs(title = "B. Financiación Europea", x = "", y = element_blank())

# Merge plots
require(gridExtra)

grid.arrange(d1,d2, layout_matrix = rbind(c(1), (2)))
