# ================================== #
# === QUERY FUNCTION - BACEN API === #
# ================================== #

# --- Script by Paulo Icaro ---#


# ============= #
# === Query === #
# ============= #

bacen_query = function(bacen_series_code, bacen_series_name, start_date, end_date){
  
  # ----------------- #
  # --- Libraries --- #
  # ----------------- #
  source('https://raw.githubusercontent.com/paulo-icaro/Bacen_API/main/Bacen_API.R')
  source('https://raw.githubusercontent.com/paulo-icaro/Bacen_API/main/Bacen_URL.R')
  
  
  # ----------------------- #
  # --- Data Extraction --- #
  # ----------------------- #
  for(i in 1:length(cod_bacen_series)){
  
    # --- Extraction --- #
    bacen_dataset_raw = bacen_api(url = bacen_url(serie = cod_bacen_series[i], '01/01/2015', '31/08/2025'))
  
    # --- Grouping Columns --- #
    if(i == 1){bacen_dataset = bacen_dataset_raw}
    else{bacen_dataset = cbind(bacen_dataset, bacen_dataset_raw[,2])}
  
    # --- Naming Headers --- #
    if(i == length(cod_bacen_series)){
      colnames(bacen_dataset) = c('data', name_bacen_series)
      rm(bacen_dataset_raw, cod_bacen_series, name_bacen_series)
    }
  }
  
  
  # -------------------------- #
  # --- Return Data Output --- #
  # -------------------------- #
  return(bacen_dataset)
}