# ================================================= #
# === FUNCAO DE COLETA DE DADOS DA API DO BACEN === #
# ================================================= #

# --- Script por Paulo Icaro ---#



# ------------------------- #
# --- Links Importantes --- #
# ------------------------- #
# https://statplace.com.br/blog/trabalhando-com-api-no-r/
# https://technologyadvice.com/blog/information-technology/how-to-use-an-api/
# https://dadosabertos.bcb.gov.br/dataset/10844-indice-de-precos-ao-consumidor-amplo-ipca---servicos/resource/c0980df7-ad92-47af-b71c-790825f4710a


# -------------------- #
# --- URL's Modelo --- #
# -------------------- #
# url_ipca_br = 'https://api.bcb.gov.br/dados/serie/bcdata.sgs.433/dados?formato=json&dataInicial=01/01/2003&dataFinal=01/12/2023'
# url_ipca_ne = 'https://api.bcb.gov.br/dados/serie/bcdata.sgs.13921/dados?formato=json&dataInicial=01/01/2003&dataFinal=01/12/2023'
# url_ipca_for = 'https://api.bcb.gov.br/dados/serie/bcdata.sgs.13006/dados?formato=json&dataInicial=01/01/2003&dataFinal=01/12/2023'



# ---------------------------- #
# --- Packages e Libraries --- #
# ---------------------------- #
#install.packages(c('httr', 'httr2', 'jsonlite'))
library(httr)                               # Conectar com a API (Versao Base): https://httr.r-lib.org/
library(httr2)                              # Conectar com a API (Versao Moderna): https://httr2.r-lib.org/
library(jsonlite)                           # Converter dados Json para um Objeto
library(dplyr)                              # Biblioteca para manipulacao de dados





# ------------------------------ #
# --- API - Funcao de Coleta --- #
# ------------------------------ #

bacen_api = function(url, httr = TRUE){
  message('Iniciando a conexao com a API')
  
  # --- Conexao API - Utilizando httr --- #
  if(httr == TRUE){
    
    # -- Conexao com API -- # 
    api_connection = GET(url = url)  
    
    
    # --- Flag de Conexao --- #
    if(api_connection$status_code == 200){
      message('Conexao bem sucedida ! \nDados sendo coletados ...\n')
    }
    if(api_connection$status_code != 200){
      message('Problemas na conexao \nTentando acessar a API novamente ...\n')
      Sys.sleep(2)
      api_connection = GET(url = url)
    }
    if(api_connection$status_code != 200){
      message('Problemas na conexao \nTentando acessar a API novamente ...\n')
      Sys.sleep(5)
      api_connection = GET(url = url)
    }
    if(api_connection$status_code != 200){
      message('Problemas na conexao \nTentando acessar a API uma última vez ...\n')
      Sys.sleep(10)
      api_connection = GET(url = url)
    }
    else{'Falha na conexao :(\nTente conectar com a API mais tarde'}
    
    
    # --- Conversao dos Dados para Formato Legivel --- #
    api_connection = rawToChar(api_connection$content)              # Conversao dos dados brutos (Raw) para formato de lista (JSon)
    api_connection = fromJSON(api_connection, flatten = TRUE)       # Conversao dos dados em formato de lista (Json) para formato de tabela (Data Frame)
  }
  
  
  
  # --- Conexao API - Utilizando httr2 --- #
  else{
    
    # -- Conexao com API -- # 
    api_connection =
      request(base_url = url) %>%
      req_perform()
    
    
    # -- Flag de conexao -- #
    if(api_connection$status_code == 200){
      message('Conexao bem sucedida ! \nDados sendo coletados ...\n')
    }
    if(api_connection$status_code != 200){
      message('Problemas na conexao \nTentando acessar a API novamente ...\n')
      Sys.sleep(2)
      api_connection = request(base_url = url) %>% req_perform()
    }
    if(api_connection$status_code != 200){
      message('Problemas na conexao \nTentando acessar a API novamente ...\n')
      Sys.sleep(5)
      api_connection = request(base_url = url) %>% req_perform()
    }
    if(api_connection$status_code != 200){
      message('Problemas na conexao \nTentando acessar a API uma última vez ...\n')
      Sys.sleep(10)
      api_connection = request(base_url = url) %>% req_perform()
    }
    else{'Falha na conexao :(\nTente conectar com a API mais tarde'}    
  
      
    # -- Conversao dos Dados para Formato Legivel  -- #
    api_connection = rawToChar(api_connection$body)                 # Conversao dos dados brutos (Raw) para formato de lista (JSon)
    api_connection = fromJSON(api_connection, flatten = TRUE)       # Conversao dos dados em formato de lista (Json) para formato de tabela (Data Frame)
  }
  
  
  
  # --- Output --- #
  return(api_connection)
}
