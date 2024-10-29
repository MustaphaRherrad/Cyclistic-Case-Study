#  S'assurer que les mois sont bien des entiers
merged_data_v1 <- merged_data_v1 %>%
  mutate(month = as.integer(month))

#  Définir la fonction de saison correctement
season <- function(month) {
  ifelse(month %in% c(12, 1, 2), "Hiver",
         ifelse(month %in% c(3, 4, 5), "Printemps",
                ifelse(month %in% c(6, 7, 8), "Eté", "Automne")))
}

#==================================================================

#  Créer la colonne `season` après vérification des mois
merged_data_v1 <- merged_data_v1 %>%
  filter(!is.na(month)) %>%  # Filtrer les valeurs `NA` pour les mois
  mutate(season = season(month))

#================================================================

merged_data_v1 %>%
  mutate(weekday = factor(weekday, levels = jours_semaine)) %>%
  group_by(season, weekday, member_casual) %>%
  summarise(
    rider_count = n(),
    avg_trip_duration_min = mean(trip_duration_sec, na.rm = TRUE) / 60  # Durée moyenne en minutes
  ) %>%
  ggplot() +
  geom_col(
    mapping = aes(x = weekday, y = rider_count, fill = member_casual),
    position = "dodge"
  ) +
  facet_wrap(~ season) +
  scale_y_continuous(
    name = "Nombre de trajets",
    breaks = seq(0, 800000, by = 50000)
  ) +
  labs(
    title = "Nombre des trajets par type d'utilisateur et par jour selon la saison",
    x = "Jour de la semaine",
    y = "Nombre de trajets"
  ) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

#=====================================================================

merged_data_v1 %>%
  mutate(weekday = factor(weekday, levels = jours_semaine)) %>%
  group_by(season, weekday, member_casual) %>%   
  summarise(rider_count = n(), 
            avg_trip_duration_min = mean(trip_duration_sec)/60) %>% 
  ggplot() + 
  geom_col(mapping = aes(x = weekday, y = avg_trip_duration_min, fill = member_casual), position = "dodge") + 
  facet_wrap(~season) + 
  scale_y_continuous(name = "Durée moyenne (minutes)", breaks = seq(0, 50, by = 10)) +
  labs(title = "Durée moyenne du trajet par type d'utilisateur et par jour selon la saison", 
       x = "jour de la semaine", y = "Durée moyenne (minutes)") +
  theme_minimal()+
  theme(axis.text.x = element_text(angle = 45, hjust = 1))