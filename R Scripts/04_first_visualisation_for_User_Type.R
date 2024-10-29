library(ggplot2)

# Calculer les pourcentages
counts <- table(merged_data$member_casual) 
percentages <- round(prop.table(counts) * 100, 1)

# Créer un dataframe pour ggplot et renommer les colonnes correctement
data_pie <- data.frame(
  member_casual = names(percentages),
  percentage = as.numeric(percentages)
)

# Créer le diagramme circulaire
ggplot(data = data_pie, aes(x = "", y = percentage, fill = member_casual)) +
  geom_bar(width = 1, stat = "identity") +
  coord_polar("y", start = 0) +
  labs(title = "Répartition des trajets par type d'utilisateur") +
  theme_void() +
  geom_text(aes(label = paste0(percentage, "%")), position = position_stack(vjust = 0.5), color = "white") +
  scale_fill_manual(values = c("blue", "red"))

