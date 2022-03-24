# Test #

#----------------------------------------------------------#
# II - geom_bar => diagramme en barres, barres empilées ####
#--------------------------------------------------------- #

library(tidyverse)
library(ggthemes)
library(viridis)


# Illustration 2 : IA Auvergne Rhône-Alpes N°70, novembre 2018

# Chargement des données de l'exemple
Donnees_ex2 <- readRDS("./Donnees_exemples/Donnees_ex2.RDS")

# Préalable : transformation des données
# IMPORTANT : Travailler au maximum sur des données en format "long" et non pas "wide"

Donnees_ex2 <- Donnees_ex2 %>% 
  pivot_longer(
    cols = c(Evol_Pop_act, starts_with("Effet")),
    names_to = "Effets",
    values_to = "valeur")


Donnees_ex2$Effets <- Donnees_ex2$Effets %>% 
  fct_recode(
    "Evolution de la population active"   = "Evol_Pop_act",
    "Effet démographique"                 = "Effet_demo",
    "Effet Taux d'activité"               = "Effet_taux",
    "Effet des migrations résidentielles" = "Effet_migrations")



# Construction du graphique

# Un tout premier graphique
ggplot(data = Donnees_ex2 %>% 
                  filter(Effets == "Evolution de la population active")) +
  
  geom_bar(mapping = aes(x = libelle, 
                         y = valeur), 
           
           stat = "identity"
           ) 
  


# reorder et coord_flip
ggplot(data = Donnees_ex2 %>% 
           filter(Effets == "Evolution de la population active")) +
  
  geom_bar(mapping = aes(x = reorder(libelle, valeur) , 
                         y = valeur
                         ), 
           stat  = "identity",
           fill  = "blue",
           width = 0.8) + 
  
  geom_hline(yintercept = 0) +
  
  coord_flip() +
  
  scale_y_continuous(
    breaks = seq(from = 0, to = 150, by = 20), limits = c(0, 150)) +  
  
  scale_fill_viridis(option = "viridis", discrete = TRUE) 



# Barre empilées pour faire apparaître les effets démo, taux, et Mig Résid
# fill = utile pour les diagrammes en barres empilées
# Width : permet de contrôler la largeur de la barre !!

# Par défaut, les couleurs des barres s’alignent avec la légende. 
# On peut modifier ce comportement en utilisant 
# position = position_stack(reverse = TRUE).

ggplot(data = Donnees_ex2 %>% 
         filter(Effets != "Evolution de la population active")) +
  
  geom_bar(mapping = aes(x = reorder(libelle, valeur), 
                         y = valeur,
                         fill = Effets), 
           
           stat = "identity",
           width = 0.8,
           position = position_stack(reverse = TRUE)
           ) + 
  
  geom_hline(yintercept = 0) +
  
  coord_flip() +
  
  scale_y_continuous(
    breaks = seq(from = -30, to = 150, by = 20), limits = c(-25, 150)) +  
  
  scale_fill_viridis(option = "viridis", discrete = TRUE) +
  #scale_fill_manual(values = c("#2C75FF", "#FF7F00", "#149414")) +
  

  
  
  labs(x = "", 
       y = "",
       title = " Décomposition de l'évolution de la population active selon l'approche sociodémographique \n entre 2006 et 2013, par région (pour 1000 actifs en 2006)",
       subtitle = "",
       caption = "Source : Recensement de la population 2010 et 2013") +
  
  
  theme_minimal() +
  theme(legend.position  = "bottom",
        legend.direction = "horizontal",
        legend.title = element_blank())




#---------------------------------#
# un exemple de pyramide des âges #
#---------------------------------#  


# Chargement des données de l'exemple
Donnees_ex2b <- readRDS("./Donnees_exemples/Donnees_ex2_Pyr_Age.RDS")

# Préalable : transformation des données
# => on donne une valeur négative aux hommes
Donnees_ex2b <- Donnees_ex2b %>% 
  mutate(nb = if_else(sexe == "Hommes", -nb  , nb),
         age = as.numeric(age))


Donnees_ex2b$sexe <- Donnees_ex2b$sexe %>% 
  fct_relevel("Hommes", "Femmes") 




# Préalable 2 : Création d'une fonction de séparateur de milliers dans les graphiques----
space <- function(x, ...){format(x, ..., big.mark = " ", scientific = FALSE, trim = TRUE) }



# Un tout premier graphique

ggplot(data = Donnees_ex2b) +
  
  geom_bar(mapping = aes(x = age,
                         y = nb,
                         fill = sexe),
           stat="identity"
           ,
           width = 1 # Largeur de barre. Par défaut, réglé à 90 % de la résolution des données
  ) 




# Construction du graphique
ggplot(data = Donnees_ex2b) +
  
  geom_bar(mapping = aes(x = age,
                         y = nb,
                         fill = sexe,),
           stat="identity",
           width = 1
           ) +
  
  coord_flip() +  
  
  scale_fill_viridis(option = "viridis", discrete = TRUE) +
  
  scale_y_continuous(
    breaks = seq(from = -500000, to = 500000, by = 200000), 
    limits = c(-500000, 500000),
    labels = space(abs(seq(-500000, 500000, 200000)))) +

  
  labs(x = "",
       y = "",
       title="Pyramide des âges 2018",
       caption="Source : Insee - Bilan démographique 2017") +
  
  theme_minimal() +
  theme(legend.position  = "bottom",
        legend.direction = "horizontal",
        legend.title = element_blank(),
        plot.caption = element_text(hjust = 0))


  












