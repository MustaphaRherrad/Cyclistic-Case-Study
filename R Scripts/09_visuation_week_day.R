library(dplyr)
library(lubridate)
library(ggplot2)



# Compter le nombre de trajets par jour de la semaine
day_counts <- merged_data_v1 %>%
  group_by(weekday) %>%
  summarise(total_rides = n()) %>%
  arrange(desc(total_rides))

# Afficher le jour avec le maximum de trajets
cat("Le jour de la semaine avec le plus de locations est :", day_counts$weekday[1], 
    "avec", day_counts$total_rides[1], "trajets.\n")

# Calculer les pourcentages
day_counts$percent <- prop.table(day_counts$total_rides) * 100

# Créer le graphique
ggplot(day_counts, aes(x = weekday, y = total_rides)) +
  geom_col() +
  geom_text(aes(label = paste0(round(percent,2), "%")), vjust = -0.3) +
  labs(title = "Total trajets par jour de la semaine",x = "Jour de la semaine", y = "Total des trajets")


# Ordre souhaité des jours de la semaine
jours_semaine <- c("dimanche", "lundi", "mardi", "mercredi", "jeudi", "vendredi", "samedi")

# Compter le nombre de trajets par jour de la semaine et ordonner
day_counts <- merged_data_v1 %>%
  mutate(weekday = factor(weekday, levels = jours_semaine)) %>%  # Ordonner les niveaux du facteur
  group_by(weekday) %>%
  summarise(total_rides = n()) %>%
  arrange(weekday)  # Trier par ordre croissant des niveaux du facteur

# Calculer les pourcentages
day_counts$percent <- prop.table(day_counts$total_rides) * 100

# Créer le graphique
ggplot(day_counts, aes(x = weekday, y = total_rides)) +
  geom_col() +
  geom_text(aes(label = paste0(round(percent,2), "%")), vjust = -0.3) +
  labs(title = "Total trajets par jour de la semaine",
       x = "Jour de la semaine",
       y = "Total des trajets")

#===================================================================
# Ordre souhaité des jours de la semaine
jours_semaine <- c("dimanche", "lundi", "mardi", "mercredi", "jeudi", "vendredi", "samedi")

#  Calculer le pourcentage d'utilisation par type d'utilisateur pour chaque jour de la semaine
data_summary <- merged_data_v1 %>%
  mutate(weekday = factor(weekday, levels = jours_semaine)) %>%
  group_by(weekday, member_casual) %>%
  summarise(count = n()) %>%
  mutate(percentage = (count / sum(count)) * 100)

# Créer les graphiques pour chaque jour de la semaine
ggplot(data_summary, aes(x = weekday, y = percentage, fill = member_casual)) +
  geom_bar(stat = "identity", position = "fill") +
  scale_y_continuous(labels = scales::percent) +
  labs(title = "Pourcentage trajets par type\n d'utilisateur pour chaque jour de la semaine",
       x = "Jour de la semaine", y = "Pourcentage", fill = "Type d'utilisateur") +
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1, size = 10),  # Taille plus grande pour les labels des axes
    plot.title = element_text(size = 14, face = "bold", hjust = 0.5),  # Taille du titre augmentée
    legend.title = element_text(size = 9),
    legend.text = element_text(size = 8),
    plot.margin = margin(1, 1, 1, 1, "cm")  # Marges plus homogènes
  ) 

#========================================================================

# Calculer la durée moyenne des trajets par jour de la semaine et par type d'utilisateur
avg_duration_per_day <- merged_data_v1 %>%
  mutate(weekday = factor(weekday, levels = jours_semaine)) %>%
  group_by(weekday, member_casual) %>%
  summarise(average_duration = mean(trip_duration_sec, na.rm = TRUE)) %>%
  ungroup()

# Créer le graphique
ggplot(avg_duration_per_day, aes(x = weekday, y = average_duration, fill = member_casual)) +
  geom_col(position = "dodge") +
  labs(title = "Durée moyenne des trajets par type d'utilisateur et par jour de la semaine",
       x = "Jour de la semaine",
       y = "Durée moyenne (secondes)",
       fill = "Type d'utilisateur") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

#========================================================================

merged_data_v1 %>%
  mutate(weekday = factor(weekday, levels = jours_semaine)) %>%
  group_by(member_casual, weekday) %>% 
  summarise(total_rides = n()
            ,average_duration = mean(trip_duration_sec)) %>% 
  arrange(member_casual, weekday)  %>% 
  ggplot(aes(x = weekday, y = total_rides, fill = member_casual)) +
  geom_col(position = "dodge")+
  labs(title = "Total des trajets par type d'utilisateur et par jour de la semaine",
       x = "Jour de la semaine",
       y = "Total des trajets",
       fill = "Type d'utilisateur") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))