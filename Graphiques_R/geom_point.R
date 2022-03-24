

#-------------------------------------#
# I - geom_point => Nuage de point ----
#-------------------------------------#


# install.packages("ggthemes")
# install.packages("viridis")

library(tidyverse)
library(ggthemes)  # Themes
library(viridis)   # Couleurs



# Illustration 1 : Insee Première N°1752, avril 2018

# Chargement des données de l'exemple
Donnees_ex1 <- readRDS("./Graphiques_R/Donnees_exemples/Donnees_ex1.RDS")


# Construction du graphique


# Un tout premier graphique
ggplot(data = Donnees_ex1) +
  
    geom_point(mapping = aes(x = TCAM_Pop, 
                             y = TCAM_Emploi)
               ) 


# Une couleur pour chaque profil !
ggplot(data = Donnees_ex1) + 
  
  geom_point(mapping = aes(x = TCAM_Pop, 
                           y = TCAM_Emploi,
                           color = Profil)
             ) 


# à ne pas confondre avec...
ggplot(data = Donnees_ex1) + 
  geom_point(mapping = aes(x     = TCAM_Pop, 
                           y     = TCAM_Emploi),
             color = "blue"
  )


# Une 4ème variable ?
ggplot(data = Donnees_ex1) + 
  
    geom_point(mapping = aes(x = TCAM_Pop, 
                             y = TCAM_Emploi,
                             color = Profil,
                             size = Population)
               ) 


# à ne pas confondre avec...
ggplot(data = Donnees_ex1) + 
  geom_point(mapping = aes(x     = TCAM_Pop, 
                           y     = TCAM_Emploi),
             color = "blue",
             size = 3
            ) 



# Autres paramètre : exemple avec le shape (forme du point)
# => pour en savoir plus, taper aes() dans l'aide
ggplot(data = Donnees_ex1) + 
  
  geom_point(mapping = aes(x = TCAM_Pop, 
                           y = TCAM_Emploi,
                           color = Profil), 
             size = 2, 
             shape = 15
            ) 



# Il est possible de modifier différents éléments du graphique 
# (limites des axes, échelles, thèmes...
# graph <-

ggplot(data = Donnees_ex1) + 
  
  geom_point(mapping = aes(x = TCAM_Pop, 
                           y = TCAM_Emploi,
                           color = Profil), 
             size = 2, 
             shape = 15) +   

  geom_vline(xintercept = 0) +
  geom_hline(yintercept = 0) +
  #geom_hline(yintercept = 0, color = "red", size = 1, linetype = "dotted" ) +
  
  
  scale_x_continuous(
    breaks = seq(from = -1.5, to = 2.5, by = 0.5), limits = c(-1.5, 2.5)
                    ) + 
  
  scale_y_continuous(
      breaks = seq(from = -2.5, to = 2, by= 0.5), limits = c(-2.5, 2)) + 

  

  # Taper RColorBrewer::display.brewer.all() dans la console
  # scale_color_brewer(palette = "Spectral") +
  # 
  # scale_color_calc() +
  
  scale_color_viridis(option = "viridis", discrete = TRUE) +
  
  
  # scale_color_manual(
  #     values = c("#b83e40", "#ecc4af", "#bbda73", "#808080", "#7277d9")) +
    



  labs(x = "Evolution de la population (%)",
       y = "Evolution de l'emploi (%)",
       color = "Profils types de zones d'emplois",
         
       title = "Taux de croissance annuel moyen de la population et de l'emploi\nentre 2010 et 2015 selon le profil de la zone d'emploi",
         
       subtitle = "",
       caption = "Champ : France métropolitaine\nSource : Insee, recensement de la population 2010 et 2015") + 
  
  
  
  theme_economist() +
  #theme_calc() +
  #theme_minimal() +
  
  theme(legend.position  = "bottom",
        legend.direction = "horizontal",
        legend.title = element_blank(), 
        legend.text  = element_text(size = 10, face = "bold"),
        
        axis.ticks.x = element_blank(),
        axis.line.x  = element_blank(),
        axis.text.x  = element_blank(),
  
        plot.title   = element_text(hjust = 0.5),
        plot.caption = element_text(hjust = 0,
                                    margin = margin(t = 15, r = 0, b = 0, l = 0, unit = "pt")),
  
        axis.title.x = element_text(hjust = 1, 
                                    margin = margin(t = 15, r = 0, b = 0, l = 0, unit = "pt"),
                                    face = "bold"),
  
        axis.title.y = element_text(hjust = 1,
                                    margin = margin(t = 0, r = 15, b = 0, l = 0, unit = "pt"),
                                    face = "bold")) +
    
  

    # BONUS !!
    annotate("segment", x = -1.5, xend = -1.5, y = -0.05, yend = 0,
               colour = "black", size = 1) +
    
    annotate("segment", x = -1, xend = -1, y = -0.05, yend = 0,
               colour = "black", size = 1) +
    
    annotate("segment", x = -0.5, xend = -0.5, y = -0.05, yend = 0,
               colour = "black", size = 1) +
    
    annotate("segment", x = 0.5 , xend = 0.5, y = -0.05, yend = 0,
               colour = "black", size = 1) +
    
    annotate("segment", x = 1 , xend = 1, y = -0.05, yend = 0,
               colour = "black", size = 1) +
    
    annotate("segment", x = 1.5 , xend = 1.5, y = -0.05, yend = 0,
               colour = "black", size = 1) +
    
    annotate("segment", x = 2 , xend = 2, y = -0.05, yend = 0,
               colour = "black", size = 1) +
    
    annotate("segment", x = 2.5 , xend = 2.5, y = -0.05, yend = 0,
               colour = "black", size = 1) +
      
    annotate('text', x = seq(-1.5, 2.5, 0.5), y = -0.2,
                 label = seq(-1.5, 2.5, 0.5), size = 4)



# Sauvegarde du graphique
ggsave("./Sortie/graphique_1.png", graph, height = 8, width = 12)

