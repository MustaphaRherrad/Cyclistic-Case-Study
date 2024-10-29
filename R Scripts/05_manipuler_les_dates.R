merged_data$date <- as.Date(merged_data$started_at) #Le format par défaut est yyyy-mm-dd
merged_data$month <- format(as.Date(merged_data$date), "%m")
merged_data$day <- format(as.Date(merged_data$date), "%d")
merged_data$year <- format(as.Date(merged_data$date), "%Y")
merged_data$day_of_week <- format(as.Date(merged_data$date), "%u") #"%A" Si l'on veut le nom du jour de la semaine

merged_data$day_of_week_name <- format(as.Date(merged_data$date), "%A")

merged_data$ride_length <- difftime(merged_data$ended_at,merged_data$started_at)
merged_data$ride_length_m <- (difftime(merged_data$ended_at,merged_data$started_at))/60

head(merged_data)

# Convertir les colonnes "started_at" et "ended_at" en format date-heure
merged_data$started_at <- as.POSIXct(merged_data$started_at, format = "%Y-%m-%d %H:%M:%S")
merged_data$ended_at <- as.POSIXct(merged_data$ended_at, format = "%Y-%m-%d %H:%M:%S")

# Extraire uniquement les dates (sans les heures) pour les deux colonnes
merged_data$start_date <- as.Date(merged_data$started_at)
merged_data$end_date <- as.Date(merged_data$ended_at)

# Vérifier si les dates de début et de fin sont différentes
multiple_dates <- merged_data$start_date != merged_data$end_date

# Compter le nombre de trajets qui s'étendent sur plusieurs dates
trajets_multi_dates <- sum(multiple_dates)

# Afficher le nombre de trajets avec des dates différentes
cat("Nombre de trajets s'étendant sur plusieurs dates :", trajets_multi_dates, "\n")

# Optionnel : afficher les lignes concernées
data_multi_dates <- merged_data[multiple_dates, ]
head(data_multi_dates)


# Ajouter une colonne "multi_date_trip" pour indiquer si un trajet s'étend sur plusieurs dates
merged_data$multi_date_trip <- as.Date(merged_data$started_at) != as.Date(merged_data$ended_at)

# Calculer la durée de chaque trajet en secondes
merged_data$trip_duration_sec <- as.numeric(difftime(merged_data$ended_at, merged_data$started_at, units = "secs"))

# Convertir la durée en heures, minutes et secondes
merged_data$trip_duration_hms <- format(as.POSIXct(merged_data$trip_duration_sec, origin = "1970-01-01", tz = "UTC"), "%H:%M:%S")

# Afficher les premières lignes pour vérifier les nouvelles colonnes
head(merged_data[, c("started_at", "ended_at",  "trip_duration_sec", "trip_duration_hms")])

