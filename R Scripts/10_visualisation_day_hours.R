# Calculer le pourcentage d'utilisation par type d'utilisateur pour chaque heure de la journée
data_summary_hour <- merged_data_v1 %>%
  group_by(hour, member_casual) %>%
  summarise(count = n()) %>%
  mutate(percentage = (count / sum(count)) * 100)

# Créer un graphique avec ggplot2
ggplot(data_summary_hour, aes(x = hour, y = percentage, fill = member_casual)) +
  geom_bar(stat = "identity", position = "fill") +
  scale_y_continuous(labels = scales::percent_format()) +
  labs(title = "Pourcentage Trajets par type d'utilisateur selon l'heure de la journée",
       x = "Heure de la journée", y = "Pourcentage", fill = "Type d'utilisateur") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
