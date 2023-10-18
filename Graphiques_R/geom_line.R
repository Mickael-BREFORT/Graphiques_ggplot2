
# Formation à GIT - Test sur le sspcloud

# Test 2 mais avec un autre identifiant !!



#--------------------------------------#
# III - geom_line => Courbe            #
#--------------------------------------#  

library(tidyverse)
library(ggthemes)
library(viridis)


# Illustration 3 : Taux d'activité .... 

# Chargement des données de l'exemple
Donnees_ex3 <- readRDS("./Donnees_exemples/Donnees_ex3.RDS")


# Préalable : transformation des données
Donnees_ex3 <- Donnees_ex3 %>% 
  pivot_longer(
    cols = c(starts_with("Central"), Rattrap_2030),
    names_to = "Scenario",
    values_to = "Taux_act")



# Un tout premier graphique
ggplot(data = Donnees_ex3) + 
  
  geom_line(mapping = aes(x = TR_Age,
                          y = Taux_act
                          # ,
                          # group = Scenario
                          ),
  stat = "identity",
  size = 1
  ) 




#  linetype : à mettre dans l'AES si on veut modifier le type de ligne
# à l'aide de scale_linetype_manual
ggplot(data = Donnees_ex3) + 
  
  geom_line(mapping = aes(x = TR_Age,
                          y = Taux_act,
                          color = Scenario,
                          group = Scenario,
                          linetype = Scenario
                          ),
            stat = "identity",
            size = 1,
            #linetype = "solid"
  ) +
  
  
  scale_linetype_manual(values = c("solid", "dashed", "dotted")) +
  
  scale_y_continuous(
    breaks = seq(from = 0, to = 95, by = 10), limits = c(0, 95)) + 
  
  
  labs(title="Taux d'activité par tranche d'âge et selon différents scénarios....",
       x ="",
       y ="",
       caption = "Insee : Omphale") +
  
  
  theme_minimal()+
  theme(
    legend.position  = "bottom",
        legend.direction = "horizontal",
        legend.title = element_blank(), 
        legend.text  = element_text(size = 10, face = "bold"))
        


