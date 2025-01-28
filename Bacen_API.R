# ========================================= #
# === DATA COLLECT FUNCTION - BACEN API === #
# ========================================= #

# --- Script by Paulo Icaro ---#



# ---------------------------- #
# --- Packages e Libraries --- #
# ---------------------------- #
#install.packages(c('httr', 'httr2', 'jsonlite'))
library(httr)                               # API Connection (Base Version): https://httr.r-lib.org/
library(httr2)                              # API Connection (Modern Version): https://httr2.r-lib.org/
library(jsonlite)                           # Convert Json data to an objetc
library(dplyr)                              # Library for data manipulation
library(svDialogs)                          # Library for displaying message boxes



# -------------------------------- #
# --- API - Gathering Function --- #
# -------------------------------- #

bacen_api = function(url, httr = TRUE){
  message('Iniciando a conexao com a API do Bacen\n')
  flag = 0
  
  # --- API Connection - Using httr --- #
  if(httr == TRUE){
    
    # -- API Connection -- # 
    api_connection = GET(url = url)  
    
    
    # --- Connection Flag --- #
    if(api_connection$status_code == 200){
      dlg_message(message = 'Conexao bem sucedida ! \nDados sendo coletados ...\n', type = 'ok')
    } 
    else if(api_connection$status_code != 200){
      while(api_connection$status_code != 200 & flag <= 3){
        flag = flag + 1
        
        if(flag == 1){
          Sys.sleep(2)
          message('Problemas na conexao. \nTentando acessar a API novamente ...\n')}
        if(flag == 2){
          Sys.sleep(5)
          message('Problemas na conexao. \nTentando acessar a API novamente ...\n')}
        if(flag == 3){
          Sys.sleep(10)
          message('Problemas na conexao. \nTentando acessar a API uma última vez ...\n')}
        
        api_connection = GET(url = url)        
      }
      
      ifelse(api_connection$status_code == 200,
             dlg_message(message = 'Conexao bem sucedida ! \nDados sendo coletados ...\n', type = 'ok'),
             dlg_message(message = 'Falha na conexao ! \nTente conectar com a API mais tarde.', type = 'ok')
      )
    }
    
    
    # --- Converting Data to a Readable Format --- #
    api_connection = rawToChar(api_connection$content)              # Raw to Json
    api_connection = fromJSON(api_connection, flatten = TRUE)       # Json to Data Frame
  }
  
  
  
  # --- API Connection - Using httr2 --- #
  else{
    
    # -- API Connection -- # 
    api_connection = request(base_url = url) %>% req_perform()
    
    
    # --- Connection Flag --- #
    if(api_connection$status_code == 200){
      dlg_message(message = 'Conexao bem sucedida ! \nDados sendo coletados ...\n', type  = 'ok')
    } 
    else if(api_connection$status_code != 200){
      while(api_connection$status_code != 200 & flag <= 3){
        flag = flag + 1
        
        if(flag == 1){
          Sys.sleep(2)
          message('Problemas na conexao. \nTentando acessar a API novamente ...\n')}
        if(flag == 2){
          Sys.sleep(5)
          message('Problemas na conexao. \nTentando acessar a API novamente ...\n')}
        if(flag == 3){
          Sys.sleep(10)
          message('Problemas na conexao. ! \nTentando acessar a API uma última vez ...\n')}
        
        api_connection = request(base_url = url) %>% req_perform()
      }
      
      ifelse(api_connection$status_code == 200,
             dlg_message(message = 'Conexao bem sucedida ! \nDados sendo coletados ...\n', type = 'ok'),
             dlg_message(message = 'Falha na conexao ! \nTente conectar com a API mais tarde.', type = 'ok')
      )
    }

    
    # --- Converting Data to a Readable Format --- #
    api_connection = rawToChar(api_connection$body)                 # Raw to JSon
    api_connection = fromJSON(api_connection, flatten = TRUE)       # Json to Data Frame
  }
  
  
  
  # --- Output --- #
  return(api_connection)
}