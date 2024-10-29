merged_data_v1 %>%
  group_by(member_casual) %>%
  summarise(max_trip_duration = max(trip_duration_sec, na.rm = TRUE), 
            min_trip_duration = min(trip_duration_sec, na.rm = TRUE), 
            avg_trip_duration = mean(trip_duration_sec, na.rm = TRUE)) %>% 
  mutate(avg_trip_duration_min = avg_trip_duration / 60) %>%  # Conversion en minutes
  ggplot(aes(x = member_casual, y = avg_trip_duration_min, fill = member_casual)) +
  geom_col(show.legend = FALSE) +
  scale_y_continuous(name = "Durée moyenne (minutes)", breaks = seq(0, 40, by = 5)) +  # Ajustement des graduations
  labs(title = "Durée moyenne des trajets par type d'utilisateur", 
       x = "Type d'utilisateur") +
  theme_minimal() +
  geom_text(aes(label = round(avg_trip_duration_min, 1)), vjust = -0.5, size = 3.5)  # Affichage de la durée moyenne sur les barres

#=======================================================================

merged_data_v1 %>%
  group_by(member_casual) %>%
  summarise(rider_count = n()) %>% 
  ggplot(aes(x = member_casual, y = rider_count,fill=member_casual )) +
  geom_col()+
  labs(title = "Nombre des trajets par type d'utilisateur", 
       x = "Type d'utilisateur") +
  theme_minimal() +
  geom_text(aes(label = rider_count), vjust = -0.5, size = 3)  # Affichage du nombre des trajets sur les barres