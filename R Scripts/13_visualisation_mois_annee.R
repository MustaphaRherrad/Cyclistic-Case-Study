merged_data_v1 %>%
  mutate(month = as.numeric(month)) %>%  # Convertir les mois en nombres
  group_by(month, member_casual) %>%
  summarise(
    rider_count = n(), 
    avg_trip_duration_min = mean(trip_duration_sec, na.rm = TRUE) / 60  # Moyenne des durées de trajet en minutes
  ) %>%
  ggplot(aes(x = month, y = rider_count, color = member_casual)) +
  geom_line() +
  scale_x_continuous(breaks = seq(1, 12, by = 1)) +  # Afficher les mois de 1 à 12
  labs(
    title = "Nombre de trajets mensuels par type d'utilisateur",
    x = "Mois",
    y = "Nombre de trajets"
  )
#===================================

merged_data_v1 %>%
  group_by(month, member_casual) %>%
  summarise(
    rider_count = n(), 
    avg_trip_duration_min = mean(trip_duration_sec, na.rm = TRUE) / 60  # Moyenne des durées de trajet en minutes
  ) %>%
  ggplot(aes(x = month, y = avg_trip_duration_min, color = member_casual)) +
  geom_line() +
  scale_x_continuous(breaks = seq(1, 12, by = 1)) +  # Afficher les mois de 1 à 12
  labs(
    title = "Durée de trajets par mois et par type d'utilisateur",
    x = "Mois",
    y = "Durée de trajets en minutes"
  )