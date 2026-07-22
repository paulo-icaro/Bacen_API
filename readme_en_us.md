# Acessing Brazil Central Bank data via API

2024-08-05

<!------------>

<!-- PART 1 -->

<!------------>

## Brief guidethrough

<p>

      This simple library allows the users to acess Brazil Central Bank
(BACEN) data by acessing its API. In short, there are two R scripts
which work jointly:
[**bacen_url**]('https://raw.githubusercontent.com/paulo-icaro/Bacen_API/main/bacen_url.R')
e
[**bacen_api**]('https://raw.githubusercontent.com/paulo-icaro/Bacen_API/main/bacen_api.R').
The script
[**bacen_url**]('https://raw.githubusercontent.com/paulo-icaro/Bacen_API/main/bacen_url.R')
is responsible for creating the URL where the data is available. The
[**bacen_api**]('https://raw.githubusercontent.com/paulo-icaro/Bacen_API/main/bacen_api.R')
connects with the API, extracts the info required and converts it to a
readable format.  
      Additionally, the library provides the
[**bacen_query**]('https://raw.githubusercontent.com/paulo-icaro/Bacen_API/main/bacen_query.R')
function, which combines the functionality of both previous functions
into a single interface, simplifying the data retrieval process.  
      The following sections describe how each function works.

</p>

<!------------>

<!-- PART 2 -->

<!------------>

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

      The mechanism is very simple. The user just have to specify three
arguments, which are: **series_code**, **start_date**, **end_date**.
These arguments correspond, respectively to the series code, the start
and the end date. By specifying these arguments the url’s is
generated.  
      In the example bellow, we are considering the Brazilian price
index time series (IPCA), whose code is 433, in the 2010/23 interval.
Once you called the function, just write the parameters and the job is
done.

**Attention !**

- Have in mind that the date pattern is the brazilian one
  (*dd/mm/yyyy*);
- Dot not forget to write the dates in string/character format;

</p>

``` r
# -------------------------------- #
# --- Example - URL Generation --- #
# -------------------------------- #

# --- Bacen_URL Function --- #
source('https://raw.githubusercontent.com/paulo-icaro/Bacen_API/main/bacen_url.R')    

# --- Create URL --- #
ipca_br_url = bacen_url(433, '01/01/2010', '31/12/2023')    # Generating the URL
ipca_br_url
```

    [1] "https://api.bcb.gov.br/dados/serie/bcdata.sgs.433/dados?formato=json&dataInicial=01/01/2010&dataFinal=31/12/2023"

<!-------------->

<!--- PART 3 --->

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

      This function connects with Bacen API by using the
[*httr*](https://httr.r-lib.org/) or [*httr2*](https://httr2.r-lib.org/)
functions. In both cases, the
[**Bacen_API**](https://raw.githubusercontent.com/paulo-icaro/Bacen_API/main/bacen_api.R)
function internally checks the HTTP status code. Put in to other words,
it verifies whether we get a successful connection (code 200) or a bad
connection (code 400 or 404). In case the initial try fails, there are
three remaining chances to achieve a valid connection. Some messages are
displayed during the download of the data.  
      The arguments of the function are the ***url*** and a logical
variable named ***httr*** indicating whether the user wants do use
[*httr*](https://httr.r-lib.org/) or
[*httr2*](https://httr2.r-lib.org/). The next example shows how to use
the function.

</p>

``` r
# -------------------------------- #
# --- Example - API Connection --- #
# -------------------------------- #

# --- Bacen_API Function --- #
source('https://raw.githubusercontent.com/paulo-icaro/Bacen_API/main/bacen_api.R')

# --- URL --- #
ipca_br_url = 'https://api.bcb.gov.br/dados/serie/bcdata.sgs.433/dados?formato=json&dataInicial=01/01/2003&dataFinal=31/12/2023'

# --- Acessing API Data --- #
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

<!--- PART 4 --->

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

      This script concatenates both former functions. The researcher
only has to inform a few argument the
[**bacen_query**]('https://raw.githubusercontent.com/paulo-icaro/Bacen_API/main/bacen_query.R')
function in order to proceed with the data extraction. Besides the
already known arguments from
[**bacen_api**]('https://raw.githubusercontent.com/paulo-icaro/Bacen_API/main/bacen_api.R')
function, the user has to provide two more items. First, one needs to
inform the ***series_name*** and also decide whether sourcing the
**bacen_url** and **bacen_api** functions from this library.  
      Let’s practice the data extraction:

</p>

``` r
# ----------------------- #
# --- Data Extraction --- #
# ----------------------- #

# --- Bacen API Function --- #
source('https://raw.githubusercontent.com/paulo-icaro/Bacen_API/main/bacen_query.R')

# --- Previous Info --- #
cod_bacen_series = c('25390', '4189', '3697', '433')
name_bacen_series = c('ibcrce', 'selic_acum_anual', 'tx_cambio_mp', 'inflação_ipca')
start_date = '01/01/2015'
end_date = '31/12/2025'

# --- Extraction --- #
bacen_dataset = bacen_query(cod_bacen_series, name_bacen_series, start_date, end_date)
tail(bacen_dataset)
```

              data ibcrce selic_acum_anual tx_cambio_mp inflação_ipca
    127 01/07/2025 114.86            14.90       5.5279          0.26
    128 01/08/2025 115.68            14.90       5.4463         -0.11
    129 01/09/2025 114.42            14.90       5.3668          0.48
    130 01/10/2025 112.74            14.90       5.3849          0.09
    131 01/11/2025 107.38            14.90       5.3403          0.18
    132 01/12/2025 106.83            14.90       5.4525          0.33
