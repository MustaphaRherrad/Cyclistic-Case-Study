library(readr)


#=====================
# STEP 1: COLLECT DATA
#=====================
# Upload Divvy datasets (csv files) here
nov<-read_csv("R_Projects/Cyclistic Case Study/Data/202311-divvy-tripdata.csv")
oct<-read_csv("R_Projects/Cyclistic Case Study/Data/202310-divvy-tripdata.csv")
sep<-read_csv("R_Projects/Cyclistic Case Study/Data/202409-divvy-tripdata.csv")
aug<-read_csv("R_Projects/Cyclistic Case Study/Data/202408-divvy-tripdata.csv")
jul<-read_csv("R_Projects/Cyclistic Case Study/Data/202407-divvy-tripdata.csv")
jun<-read_csv("R_Projects/Cyclistic Case Study/Data/202406-divvy-tripdata.csv")
may<-read_csv("R_Projects/Cyclistic Case Study/Data/202405-divvy-tripdata.csv")
apr<-read_csv("R_Projects/Cyclistic Case Study/Data/202404-divvy-tripdata.csv")
mar<-read_csv("R_Projects/Cyclistic Case Study/Data/202403-divvy-tripdata.csv")
feb<-read_csv("R_Projects/Cyclistic Case Study/Data/202402-divvy-tripdata.csv")
jan<-read_csv("R_Projects/Cyclistic Case Study/Data/202401-divvy-tripdata.csv")
dec<-read_csv("R_Projects/Cyclistic Case Study/Data/202312-divvy-tripdata.csv")

#============================================================================

# Stack all data frames into one big data frame
merged_data <- bind_rows(nov, oct, sep, aug, jul, jun, may, apr, mar, feb, jan, dec)