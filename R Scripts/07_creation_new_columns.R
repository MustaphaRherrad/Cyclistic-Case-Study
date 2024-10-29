# Créer une nouvelle colonne "year" pour l'année
merged_data_v1$year <- format(merged_data_v1$started_at, "%Y")

# Créer une nouvelle colonne "month" pour le mois
merged_data_v1$month <- format(merged_data_v1$started_at, "%m")

# Créer une nouvelle colonne "day" pour le jour du mois
merged_data_v1$day <- format(merged_data_v1$started_at, "%d")

# Créer une nouvelle colonne "weekday" pour le jour de la semaine (lundi, mardi, etc.)
# La fonction "weekdays" retourne le jour de la semaine complet
merged_data_v1$weekday <- weekdays(merged_data_v1$started_at)

# Créer une nouvelle colonne "week" pour le numéro de la semaine dans l'année
merged_data_v1$week <- format(merged_data_v1$started_at, "%U")

# Créer une nouvelle colonne "hour" pour l'heure du début du trajet
merged_data_v1$hour <- format(merged_data_v1$started_at, "%H")

# Vérifier les nouvelles colonnes
head(merged_data_v1[, c("started_at", "year", "month", "day", "weekday", "week", "hour")])