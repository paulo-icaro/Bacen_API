# ====================================================== #
# === FORMULARIO PARA EXTRACAO DOS DADOS - API BACEN === #
# ====================================================== #

# --- Script by Paulo Icaro ---#



# ----------------------------------------------------- #
# --- User Form for Specifying Series to be Acessed --- #
# ----------------------------------------------------- #

# Pre-settings #
cod_bacen_seriess = name_bacen_series = NULL
per_init_bacen_series = per_end_bacen_series = 0


# Form for code series insertion #
flag = 'yes' 
while(flag == 'yes'){
  single_cod_bacen_series = readline(prompt = 'Informe o código da série a ser acessada: ')
  single_name_bacen_series = readline(prompt = 'Informe como deseja chamar essa série: ')
  cod_bacen_series = cbind(cod_bacen_series, single_cod_bacen_series)
  name_bacen_series = cbind(name_bacen_series, single_name_bacen_series)
  flag_question = dlg_message(message = 'Deseja informar mais alguma série ?', type = 'yesno')
  flag = flag_question$res
}


# Form for interval insertion #
flag = 0
if (nchar(per_init_bacen_series) != 10 | nchar(per_init_bacen_series) != 10){

  # Initial message #
  flag = flag + 1
  if(flag == 1){
    msg_box(message = 'Agora informe o período inicial. Padrão: dd/mm/aaaa')
    per_init_bacen_series = readline(prompt = 'Informe o período inicial: ')  
    per_end_bacen_series = readline(prompt = 'Informe o período final: ')
  }
  
  # If initial date is incorrect
  while(nchar(per_init_bacen_series) != 10){
    msg_box(message = 'Data de inicio invalida. Informe novamente.')
    per_init_bacen_series = readline(prompt = 'Informe o período inicial: ')
  }
  
  # If end date is incorrect
  while(nchar(per_end_bacen_series) != 10){
    msg_box(message = 'Data de encerramento invalida. Informe novamente.')
    per_end_bacen_series = readline(prompt = 'Informe o período final: ')
  }
}