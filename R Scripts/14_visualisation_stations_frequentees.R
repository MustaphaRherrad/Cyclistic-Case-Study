# définir un miroir
options(repos = c(CRAN = "https://cloud.r-project.org/"))

# Installer les bibliothèques nécessaires
install.packages("leaflet")

# Charger les bibliothèques
library(leaflet)
library(dplyr)  # Pour la manipulation de données

#=====================================================

# Convertir 'weekday' en facteur avec les jours dans le bon ordre
merged_data_v1 <- merged_data_v1 %>%
  mutate(weekday = factor(weekday, 
                          levels = c("dimanche", "lundi", "mardi", "mercredi", "jeudi", "vendredi", "samedi")))





# Calculer le nombre de trajets par station d'arrivée pour le lundi
top_monday_stations <- merged_data_v1 %>%
  filter(weekday == "lundi", !is.na(end_station_name), !is.na(end_lat), !is.na(end_lng)) %>%
  group_by(end_station_name, end_lat, end_lng) %>%
  summarise(traffic_count = n(), .groups = "drop") %>%
  arrange(desc(traffic_count)) %>%
  slice_max(order_by = traffic_count, n = 5)


# Calculer le nombre de trajets par station d'arrivée pour le samedi
top_saturday_stations <- merged_data_v1 %>%
  filter(weekday == "samedi", !is.na(end_station_name), !is.na(end_lat), !is.na(end_lng)) %>%
  group_by(end_station_name, end_lat, end_lng) %>%
  summarise(traffic_count = n(), .groups = "drop") %>%
  arrange(desc(traffic_count)) %>%
  slice_max(order_by = traffic_count, n = 5)

nrow(top_saturday_stations)

leaflet() %>%
  # Ajouter les stations du lundi en rouge
  addTiles() %>%
  addCircleMarkers(data = top_monday_stations,
                   lat = ~end_lat,
                   lng = ~end_lng,
                   color = "red",
                   fillOpacity = 0.8,
                   radius = 8,
                   label = ~paste(end_station_name, "<br>", "Trafic :", traffic_count),
                   popup = ~paste("<strong>Station :</strong> ", end_station_name, 
                                  "<br><strong>Trafic le lundi :</strong> ", traffic_count)) %>%
  # Ajouter les stations du samedi en bleu
  addCircleMarkers(data = top_saturday_stations,
                   lat = ~end_lat,
                   lng = ~end_lng,
                   color = "blue",
                   fillOpacity = 0.8,
                   radius = 8,
                   label = ~paste(end_station_name, "<br>", "Trafic :", traffic_count),
                   popup = ~paste("<strong>Station :</strong> ", end_station_name, 
                                  "<br><strong>Trafic le samedi :</strong> ", traffic_count)) %>%
  # Ajouter une légende
  addLegend(position = "bottomright",
            colors = c("red", "blue"),
            labels = c("Top 5 lundi", "Top 5 samedi"),
            title = "Stations avec le plus de trafic")
