


#------------------------------------------#
# V - geom_boxplot => boîte à moustache ####
#----------------------------------------- #

# Voir R graph gallery !!!!
# https://www.r-graph-gallery.com/

library(tidyverse)
library(ggthemes)
library(viridis)


# Chargement des données de l'exemple
Donnees_ex5 <- readRDS("./Donnees_exemples/Donnees_ex5.RDS")


# Un tout premier graphique
ggplot(data = Donnees_ex5) +
  
  geom_boxplot(mapping = aes(x = name, 
                             y = value, 
                             fill = name)
              ) 


# ajout de geom_jitter !
ggplot(data = Donnees_ex5) +
  
  geom_boxplot(mapping = aes(x = name, 
                             y = value, 
                             fill = name)
              ) +
  

  geom_jitter(mapping = aes(x = name, 
                            y = value, 
                            fill = name),
    
              color = "black", 
              size  = 0.4, 
              alpha = 0.9) +
  
  
  scale_fill_viridis(discrete = TRUE, alpha=0.6) +
  
  labs(title = "A boxplot with jitter",
       x = "",
       y = "") +
  
  theme(
    legend.position = "none",
    plot.title = element_text(size = 11)) 





# AES dans la fonction ggplot !!
ggplot(data = Donnees_ex5,
       mapping = aes(x = name, 
                     y = value, 
                     fill = name)) +
  
  geom_boxplot() +
  
  geom_jitter(color = "black", 
              size  = 0.4, 
              alpha = 0.9) +
  
  #scale_fill_viridis(discrete = TRUE, alpha=0.6) +
  
  labs(title = "A boxplot with jitter",
       x = "",
       y = "") +
  
  theme(
    legend.position = "none",
    plot.title = element_text(size = 11)) 


