# 1. Télécharger le fichier ZIP
url <- "https://divvy-tripdata.s3.amazonaws.com/202310-divvy-tripdata.zip"
destfile <- "202310-divvy-tripdata.zip"
download.file(url, destfile)

# 2. Lister les fichiers présents dans l'archive ZIP
fichiers_dans_zip <- unzip(destfile, list = TRUE)$Name

# 3. Filtrer les fichiers à exclure (ceux dans _MACOSX)
fichiers_a_extraire <- fichiers_dans_zip[!grepl("^__MACOSX", fichiers_dans_zip)]

# 4. Extraire uniquement les fichiers filtrés
unzip(destfile, files = fichiers_a_extraire, exdir = "R_Projects/Cyclistic Case Study/Target")

# 5. Lister et charger le fichier CSV
data_a_inspecter <- read.csv("R_Projects/Cyclistic Case Study/Target/202310-divvy-tripdata.csv")

# 6. Lire les 10 premières lignes du dataframe
head(data_a_inspecter, 10)

# 7. Lister les colonnes du dataframe
colnames(data_a_inspecter)

#=================================================================================
#=================================================================================

# Afficher les valeurs uniques des colonnes "rideable_type" et "member_casual"
cat("Les valeurs uniques du type des vélos sont :", unique(data_a_inspecter$rideable_type), "\n")
cat("Les valeurs uniques des types d'utilisateurs sont :", unique(data_a_inspecter$member_casual), "\n")

# Obtenir et afficher le nombre de stations uniques
cat("Le nombre de stations de départ uniques est :", length(unique(data_a_inspecter$start_station_name)), "\n")
cat("Le nombre de stations d'arrivée uniques est :", length(unique(data_a_inspecter$end_station_name)), "\n")



