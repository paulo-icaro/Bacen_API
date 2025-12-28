# =========================================== #
# === URL GENERATION FUNCTION - API BACEN === #
# =========================================== #

# --- Script by Paulo Icaro --- #



# ------------------ #
# --- URL Models --- #
# ------------------ #
# url_ipca_br = 'https://api.bcb.gov.br/dados/serie/bcdata.sgs.433/dados?formato=json&dataInicial=01/01/2003&dataFinal=01/12/2023'
# url_ipca_ne = 'https://api.bcb.gov.br/dados/serie/bcdata.sgs.13921/dados?formato=json&dataInicial=01/01/2003&dataFinal=01/12/2023'
# url_ipca_for = 'https://api.bcb.gov.br/dados/serie/bcdata.sgs.13006/dados?formato=json&dataInicial=01/01/2003&dataFinal=01/12/2023'




# --------------------------------- #
# --- URL's Generation Function --- #
# --------------------------------- #
bacen_url = function(series_name, start_date, end_date){
  url = 'https://api.bcb.gov.br/dados/serie/bcdata.sgs.'

  for(i in seq_along(series_name)){
    bacen_url = paste0(url, series_name, '/dados?formato=json&dataInicial=', start_date, '&dataFinal=', end_date)
  }
  
  return(bacen_url)
}