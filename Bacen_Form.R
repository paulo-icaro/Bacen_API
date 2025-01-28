# ======================================== #
# === DATA EXTRACTION FORM - API BACEN === #
# ======================================== #

# --- Script by Paulo Icaro ---#



# ----------------------------------------------------- #
# --- User Form for Specifying Series to be Acessed --- #
# ----------------------------------------------------- #

# Pre-settings #
cod_bacen_series = name_bacen_series = NULL
per_init_bacen_series = per_end_bacen_series = 0

# Info Box # 
msg_box(message = 'Caro usuario, a partir de agora voce ira inserir as informacoes necessarias para que sejam coletadas informacoes da API do Banco Central. Preencha as informacoes solicitadas de acordo.')


# Form for code series insertion #
flag = 'yes' 
while(flag == 'yes'){
  single_cod_bacen_series = readline(prompt = 'Informe o codigo da série a ser acessada: ')
  single_name_bacen_series = readline(prompt = 'Informe como deseja chamar essa serie: ')
  cod_bacen_series = cbind(cod_bacen_series, single_cod_bacen_series)
  name_bacen_series = cbind(name_bacen_series, single_name_bacen_series)
  flag_question = dlg_message(message = 'Deseja informar mais alguma serie ?', type = 'yesno')
  flag = flag_question$res
}


# Form for interval insertion #
flag = 0
if (nchar(per_init_bacen_series) != 10 | nchar(per_init_bacen_series) != 10){

  # Initial message #
  flag = flag + 1
  if(flag == 1){
    msg_box(message = 'Agora informe o periodo inicial. Padrão: dd/mm/aaaa')
    per_init_bacen_series = readline(prompt = 'Informe o periodo inicial: ')  
    per_end_bacen_series = readline(prompt = 'Informe o periodo final: ')
  }
  
  # If initial date is incorrect
  while(nchar(per_init_bacen_series) != 10){
    msg_box(message = 'Data de inicio invalida. Informe novamente.')
    per_init_bacen_series = readline(prompt = 'Informe o periodo inicial: ')
  }
  
  # If end date is incorrect
  while(nchar(per_end_bacen_series) != 10){
    msg_box(message = 'Data de encerramento invalida. Informe novamente.')
    per_end_bacen_series = readline(prompt = 'Informe o periodo final: ')
  }
}

rm(single_cod_bacen_series, single_name_bacen_series, flag, flag_question)