# ============================================ #
# === FUNCAO GERADORA DE URL's - API BACEN === #
# ============================================ #

# --- Script by Paulo Icaro ---#



# -------------------- #
# --- URL's Modelo --- #
# -------------------- #
# url_ipca_br = 'https://api.bcb.gov.br/dados/serie/bcdata.sgs.433/dados?formato=json&dataInicial=01/01/2003&dataFinal=01/12/2023'
# url_ipca_ne = 'https://api.bcb.gov.br/dados/serie/bcdata.sgs.13921/dados?formato=json&dataInicial=01/01/2003&dataFinal=01/12/2023'
# url_ipca_for = 'https://api.bcb.gov.br/dados/serie/bcdata.sgs.13006/dados?formato=json&dataInicial=01/01/2003&dataFinal=01/12/2023'




# ------------------------------ #
# --- Funcao Geradora de URL --- #
# ------------------------------ #
bacen_url = function(serie, data_inicio, data_termino){
  url = 'https://api.bcb.gov.br/dados/serie/bcdata.sgs.'

  for(i in serie){
    bacen_url = paste0(url, serie, '/dados?formato=json&dataInicial=', data_inicio, '&dataFinal=', data_termino)
  }
  
  return(bacen_url)
}

