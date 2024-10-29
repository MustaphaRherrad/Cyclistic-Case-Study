# Supprimer les datframes provisoire sde l'nevironnement pour l'alléger
rm(nov, oct, sep, aug, jul, jun, may, apr, mar, feb, jan, dec)

# Supprimer les colonnes "ride_id", "start_station_id" et "end_station_id"
merged_data <- merged_data[ , !(names(merged_data) %in% c("ride_id", "start_station_id", "end_station_id"))]
head(merged_data)
# Voir la structure du dataframe final
str(merged_data)

# Calcul du nombre d'observations avant la suppression des valeurs nulles
nombre_observations <- nrow(merged_data)
print(nombre_observations)

# Compter les valeurs nulles pour chaque colonne du dataframe
na_counts <- merged_data %>%
  summarise_all(~sum(is.na(.)))

print(na_counts)

# Supprimer les lignes avec des NA dans end_lat ou end_lng
merged_data <- merged_data %>%
  filter(!is.na(end_lat) & !is.na(end_lng))

# Calcul du nombre d'observations
nombre_observations <- nrow(merged_data)
print(nombre_observations)