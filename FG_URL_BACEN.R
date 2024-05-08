# ======================================== #
# === FUNCAO GERADORA DE URL's - BACEN === #
# ======================================== #

# --- Script por Paulo Icaro ---#



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

