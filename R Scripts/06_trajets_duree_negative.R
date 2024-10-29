# Vérifier s'il existe des trajets avec une durée négative
negative_duration_trips <- merged_data[merged_data$trip_duration_sec < 0, ]

# Afficher un aperçu des trajets ayant une durée négative, s'il y en a
if (nrow(negative_duration_trips) > 0) {
  cat("Nombre de trajets avec une durée négative :", nrow(negative_duration_trips), "\n")
  print(head(negative_duration_trips))
  
  # Créer un nouveau dataframe sans trajets à durée négative
  merged_data_v1 <- merged_data[merged_data$trip_duration_sec >= 0, ]
  cat("Nouveau dataframe créé : merged_data_v1 avec des trajets à durée valide.\n")
} else {
  cat("Aucun trajet avec une durée négative détecté. Le dataframe merged_data_v1 ne sera pas créé.\n")
}