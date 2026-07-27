# Acessando dados do Banco Central do Brasil (BACEN) via API

2024-08-05

<!------------->

<!-- PARTE 1 -->

<!------------->

## Guia rápido

<p>

      Esta biblioteca fornece uma interface simples para acesso ao dados
do Banco Central do Brasil (BACEN) por meio de sua API. Em essência, ela
é composta por três scripts em R que trabalham de forma integrada:
[**bacen_url**]('https://raw.githubusercontent.com/paulo-icaro/Bacen_API/main/bacen_url.R'),
[**bacen_api**]('https://raw.githubusercontent.com/paulo-icaro/Bacen_API/main/bacen_api.R')
e
[**bacen_query**]('https://raw.githubusercontent.com/paulo-icaro/Bacen_API/main/bacen_query.R').  
  
      A função
[**bacen_url**]('https://raw.githubusercontent.com/paulo-icaro/Bacen_API/main/bacen_url.R')
é responsável por gerar a URL utilizada para consultar os dados
desejados. Em seguida,
[**bacen_api**]('https://raw.githubusercontent.com/paulo-icaro/Bacen_API/main/bacen_api.R')
estabelece a conexão com a API, realiza a extração das informações
solicitadas e as converte para um formato apropriado para análise.  
  
Além disso, a biblioteca disponibiliza a função
[**bacen_query**]('https://raw.githubusercontent.com/paulo-icaro/Bacen_API/main/bacen_query.R'),
que reúne as funcionalidades das duas funções anteriores em uma única
interface, simplificando todo o processo de obtenção dos dados.  
  
As próximas seções apresentam o funcionamento de cada uma dessas
funções.

</p>

<!------------->

<!-- PARTE 2 -->

<!------------->

## Bacen_URL

<!------------------------------------------->

<!--- Detalhamento Função Github Document --->

<!------------------------------------------->

``` r
bacen_url (series_code, start_date, end_date)
```

<!------------------------------->

<!--- Detalhamento Função PDF --->

<!------------------------------->

<!-------------------------------->

<!--- Detalhamento Função HTML --->

<!-------------------------------->

<p>

O funcionamento é bastante simples. O usuário precisa informar apenas
três argumentos: **series_code**, **start_date** e **end_date**. Esses
argumentos correspondem, respectivamente, ao código da série temporal, à
data inicial e à data final da consulta. Após especificá-los, a URL
necessária para acessar a API é gerada automaticamente.  
  
No exemplo abaixo, utilizamos a série do Índice Nacional de Preços ao
Consumidor Amplo (IPCA), cujo código é **433**, para o período de **2010
a 2023**. Após carregar a função, basta fornecer os parâmetros desejados
e a URL será criada.  
  
**Atenção!**  
  
- Lembre-se de que o padrão de datas adotado é o brasileiro
(**dd/mm/aaaa**);  
- Não se esqueça de informar as datas no formato **character** (entre
aspas).

</p>

``` r
# --------------------------------- #
# --- Examplo - Geração da URL  --- #
# --------------------------------- #

# --- Função Bacen_URL --- #
source('https://raw.githubusercontent.com/paulo-icaro/Bacen_API/main/bacen_url.R')    

# --- Criar URL --- #
ipca_br_url = bacen_url(433, '01/01/2010', '31/12/2023')    # Generating the URL
ipca_br_url
```

    [1] "https://api.bcb.gov.br/dados/serie/bcdata.sgs.433/dados?formato=json&dataInicial=01/01/2010&dataFinal=31/12/2023"

<!-------------->

<!-- PARTE 3 -->

<!-------------->

## Bacen_API

<!------------------------------------------->

<!--- Detalhamento Função Github Document --->

<!------------------------------------------->

``` r
bacen_api (series_code, start_date, end_date)
```

<!------------------------------->

<!--- Detalhamento Função PDF --->

<!------------------------------->

<!-------------------------------->

<!--- Detalhamento Função HTML --->

<!-------------------------------->

<p>

Esta função estabelece conexão com a API do BACEN utilizando os pacotes
[*httr*](https://httr.r-lib.org/) ou
[*httr2*](https://httr2.r-lib.org/). Em ambos os casos, a função
[**bacen_api**](https://raw.githubusercontent.com/paulo-icaro/Bacen_API/main/bacen_api.R)
verifica internamente o código de status HTTP da requisição.  
Em outras palavras, ela identifica se a conexão foi realizada com
sucesso (**código 200**) ou se ocorreu algum erro, como **400** ou
**404**. Caso a primeira tentativa falhe, a função realiza até três
novas tentativas para estabelecer uma conexão válida. Durante esse
processo, algumas mensagens informativas são exibidas ao usuário.  
Os argumentos da função são a **url** e uma variável lógica denominada
**httr**, que indica se a conexão deve ser realizada utilizando o pacote
*httr* ou *httr2*. O exemplo a seguir ilustra sua utilização.

</p>

``` r
# --------------------------------- #
# --- Examplo - Conexão com API --- #
# --------------------------------- #

# --- Função Bacen_API --- #
source('https://raw.githubusercontent.com/paulo-icaro/Bacen_API/main/bacen_api.R')

# --- URL --- #
ipca_br_url = 'https://api.bcb.gov.br/dados/serie/bcdata.sgs.433/dados?formato=json&dataInicial=01/01/2003&dataFinal=31/12/2023'

# --- Obtendo dados da API --- #
data = bacen_api(url = ipca_br_url, httr = TRUE)
tail(data, n = 10)
```

              data valor
    243 01/03/2023  0.71
    244 01/04/2023  0.61
    245 01/05/2023  0.23
    246 01/06/2023 -0.08
    247 01/07/2023  0.12
    248 01/08/2023  0.23
    249 01/09/2023  0.26
    250 01/10/2023  0.24
    251 01/11/2023  0.28
    252 01/12/2023  0.56

<!-------------->

<!-- PARTE 4 -->

<!-------------->

## Bacen_Query

<!------------------------------------------->

<!--- Detalhamento Função Github Document --->

<!------------------------------------------->

``` r
bacen_query (bacen_series_code, bacen_series_name, start_date, end_date, source_github = TRUE)
```

<!------------------------------->

<!--- Detalhamento Função PDF --->

<!------------------------------->

<!-------------------------------->

<!--- Detalhamento Função HTML --->

<!-------------------------------->

<p>

Esta função reúne as funcionalidades das duas funções anteriores em uma
única rotina. Além dos argumentos já conhecidos da função
[**bacen_api**](https://raw.githubusercontent.com/paulo-icaro/Bacen_API/main/bacen_api.R),
o pesquisador precisa informar apenas mais dois elementos para realizar
a extração dos dados.  
O primeiro é **series_name**, utilizado para definir o nome que será
atribuído à série no conjunto de dados resultante. O segundo consiste em
indicar se as funções
[**bacen_url**]('https://raw.githubusercontent.com/paulo-icaro/Bacen_API/main/bacen_url.R')
e
[**bacen_api**]('https://raw.githubusercontent.com/paulo-icaro/Bacen_API/main/bacen_api.R')
devem ser carregadas diretamente deste repositório GitHub ou a partir de
uma pasta local.  
Vamos agora realizar uma extração de dados utilizando essa função.

</p>

``` r
# ------------------------- #
# --- Extração de Dados --- #
# ------------------------- #

# --- Função Bacen API --- #
source('https://raw.githubusercontent.com/paulo-icaro/Bacen_API/main/bacen_query.R')

# --- Informações Prévias --- #
cod_bacen_series = c('25390', '4189', '3697', '433')
name_bacen_series = c('ibcrce', 'selic_acum_anual', 'tx_cambio_mp', 'inflação_ipca')
start_date = '01/01/2015'
end_date = '31/12/2025'

# --- Extração --- #
bacen_dataset = bacen_query(cod_bacen_series, name_bacen_series, start_date, end_date)
tail(bacen_dataset)
```

              data ibcrce selic_acum_anual tx_cambio_mp inflação_ipca
    127 01/07/2025 114.73            14.90       5.5279          0.26
    128 01/08/2025 115.55            14.90       5.4463         -0.11
    129 01/09/2025 114.29            14.90       5.3668          0.48
    130 01/10/2025 112.62            14.90       5.3849          0.09
    131 01/11/2025 107.25            14.90       5.3403          0.18
    132 01/12/2025 106.77            14.90       5.4525          0.33
