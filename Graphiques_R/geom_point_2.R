

#---------------------------------------------#
# IV - geom_point => Bulle proportionnelle ####
#---------------------------------------------#


install.packages("ggrepel")
library(ggrepel) # mise en forme des étiquettes de texte qui se chevauchent !!

library(tidyverse)
library(ggthemes)
library(viridis)



# Chargement des données de l'exemple
Donnees_ex4 <- readRDS("./Donnees_exemples/Donnees_ex4.RDS")


# Syntaxe du graphqiue issu de l'addins ggplot Builder !!
ggplot(Donnees_ex4) +
  aes(
    x = Taux_retrait,
    y = evo_ann,
    colour = Familles,
    size = Volume_dep_2016_2030
  ) +
  geom_point(shape = "circle") +
  scale_color_hue(direction = 1) +
  labs(
    x = "Taux de cessation 2016-2030 en %",
    y = "Taux d'évolution annuel de l'emploi entre 2010 et 2015,
    en %",
    title = "Taux de cessation et évolution 2010-2015 de l'emploi parmi les métiers les plus employeurs des Hauts-de-France",
    caption = "Insee",
    color = "Domaines professionnels",
    size = "Nombre de départs en fin de carrière"
  ) +
  theme_minimal()




#-------------------------------------------------------------------------------#

# Quelques préalables
max_x <- round(max(Donnees_ex4$Taux_retrait),0) + 2
min_x <- round(min(Donnees_ex4$Taux_retrait),0) - 1.5 

max_y <- round(max(Donnees_ex4$evo_ann),0) + 1
min_y <- round(min(Donnees_ex4$evo_ann),0) - 1


# Un graphique finalisé !!
ggplot(Donnees_ex4) +
  aes(x = Taux_retrait,
      y = evo_ann,
      color = Familles,
      size  = Volume_dep_2016_2030,
      label = FAMPRO) +
  
  geom_point(shape = "circle") +

  #geom_text_repel(size = 2.5, color = "black") +

  geom_vline(xintercept = 38.5, linetype = "dotted", color="purple", size = 1) +
  geom_hline(yintercept = 0,    linetype = "dashed", color="black",  size = 0.2) +
  
  
  scale_size_area(max_size = 18, breaks = c(10000, 40000, 60000)) +
  
  scale_x_continuous(limits = c(min_x, max_x),
                     breaks = seq(min_x,max_x, 5)) +
  
  scale_y_continuous(limits = c(min_y,  max_y),
                     breaks = seq(min_y, max_y, 1)) +
  
  
  labs(
    x = "Taux de cessation 2016-2030 en %",
    y = "Taux d'évolution annuel de l'emploi entre 2010 et 2015,
    en %",
    title = "Taux de cessation et évolution 2010-2015 de l'emploi parmi les métiers les plus employeurs des Hauts-de-France",
    caption = "Insee",
    color = "Domaines professionnels",
    size = "Nombre de départs en fin de carrière"
  ) +

  theme_minimal() +
  
  # theme(legend.position = c(0.12, 0.25),
  #       legend.direction = "vertical",
  #       legend.title = element_text(color = "black", size = 8),
  #       legend.text  = element_text(color = "black", size = 8),
  #       legend.background = element_rect(fill = "transparent")) +
  
  
  annotate(geom = "text", 
           x = min_x + (38.5 - min_x)/2 ,
           y = max_y,
           label = "Taux de retrait modéré \net emploi en hausse", 
           color="#d18975", size=3) +
  
  annotate(geom="text", 
           x = 38.5 + (max_x- 38.5)/2,
           y = max_y,
           label = "Croissance de l'emploi \net fort taux de retrait",
           color="red", size=3) +
  
  annotate(geom="text",
           x = min_x + (38.5 - min_x)/2,
           y = min_y,
           label = "Retrait modéré \net emploi en baisse",  
           color="#758bd1", size=3) +
  
  annotate(geom="text", 
           x = 38.5 + (max_x- 38.5)/2,
           y = min_y,
           label = "Fort taux de retrait \net emploi en baisse", color="plum", size=3) +
  
  annotate(geom ="text",
           x = 38.5,
           y = min_y, 
           label = "Moyenne régionale : 38,5 %", 
           color="purple", size=4)





















