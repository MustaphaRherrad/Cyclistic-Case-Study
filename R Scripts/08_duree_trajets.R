merged_data_v1 %>%
  summarise(max(trip_duration_sec),min(trip_duration_sec),mean(trip_duration_sec)) 

# Compter le nombre de trajets avec une durée nulle
count_null_duration <- merged_data_v1 %>%
  filter(trip_duration_sec == 0) %>%
  summarise(count = n())

print(count_null_duration)

# Supprimer les trajets avec une durée nulle
merged_data_v1 <- merged_data_v1 %>%
  filter(trip_duration_sec > 0)


# Filtrer les trajets dépassant 12 heures (12 * 3600 = 43200 secondes)
long_trips <- merged_data_v1 %>%
  filter(trip_duration_sec > 43200)

# Afficher les premiers trajets qui dépassent 12 heures pour vérifier
head(long_trips)


# Calculer les pourcentages pour les longs trajets
counts_lt <- table(long_trips$member_casual)  
percentages_lt <- round(prop.table(counts) * 100, 1)

# Créer un dataframe pour ggplot et renommer les colonnes correctement
data_pie_lt <- data.frame(
  member_casual = names(percentages_lt),
  percentage_lt = as.numeric(percentages_lt)
)

# Créer le diagramme circulaire
ggplot(data = data_pie_lt, aes(x = "", y = percentage_lt, fill = member_casual)) +
  geom_bar(width = 1, stat = "identity") +
  coord_polar("y", start = 0) +
  labs(title = "Longs Trajets effectués par type d'utilisateur") +
  theme_void() +
  geom_text(aes(label = paste0(percentage_lt, "%")), position = position_stack(vjust = 0.5), color = "white") +
  scale_fill_manual(values = c("blue", "red"))