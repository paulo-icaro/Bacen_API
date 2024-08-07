Acessing Brazil Central Bank data via API
================
Paulo Icaro
2024-08-05

<!------------>
<!-- PART 1 -->
<!------------>

## Brief guidethrough

<p>

      This simple library allows the users to acess Brazil Central Bank
(BACEN) data by acessing its API. In short, there are three R scripts
which work jointly: ***Bacen_URL***, ***Bacen_API*** and
***Bacen_Form***.  
      The script ***Bacen_URL*** is responsible for creating the URL
where the data is available. The ***Bacen_API***, as the name says,
connects with the BACEN API, extracts the info required and converts it
to a readable format. At last, the ***Bacen_Form*** script is a short
form which interacts with the user in order to gather some information
necessary to extract the data.  
      Let’s see how each function works.

</p>
<!------------>
<!-- PART 2 -->
<!------------>

## Bacen_URL

<p>

      The mechanism is very simple. The user just have to specify three
arguments, which are: **serie**, **data_inicio**, **data_termino**.
These arguments correspond, respectively to the series code, the start
and the end date. By specifying these arguments the url’s is
generated.  
      In the example bellow, we are considering the Brazilian price
index time series (IPCA), whose code is 433, in the 2010/20 interval.
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

# --- Libraries --- #
library(devtools)                                           # Package for importing github scripts

# --- Function --- #
# Source the function from a github directory
source('https://raw.githubusercontent.com/paulo-icaro/Bacen_API/main/Bacen_URL.R')    

# --- Create URL --- #
ipca_br_url = bacen_url(433, '01/01/2003', '31/12/2023')    # Generating the URL
```

<p>
The resulting url is
</p>

    [1] "https://api.bcb.gov.br/dados/serie/bcdata.sgs.433/dados?formato=json&dataInicial=01/01/2003&dataFinal=31/12/2023"

<!-------------->
<!--- PART 3 --->
<!-------------->

## Bacen_API

<p>

      This function connects with Bacen API by using the
[*httr*](https://httr.r-lib.org/) or [*httr2*](https://httr2.r-lib.org/)
functions. In both cases, the **Bacen_API** function internally checks
the HTTP status code. Put in to other words, it verifies whether we get
a successful connection (code 200) or a bad connection (code 400 or
404). In case the initial try fails, there are three remaining chances
to achieve a valid connection. Some messages are displayed during the
download of the data.  
      The arguments of the function are the ***url*** and a logical
variable named ***httr*** indicating whether the user wants do use
*httr* or *httr2*.  
      The next example shows how to use the function.

</p>

``` r
# -------------------------------- #
# --- Example - API Connection --- #
# -------------------------------- #

# --- Libraries --- #
library(devtools)

# --- Function --- #
# Source the function from a github directory
source('https://raw.githubusercontent.com/paulo-icaro/Bacen_API/main/Bacen_API.R')

# --- URL --- #
ipca_br_url = 'https://api.bcb.gov.br/dados/serie/bcdata.sgs.433/dados?formato=json&dataInicial=01/01/2003&dataFinal=31/12/2023'

# --- Acessing API Data --- #
data = bacen_api(url = ipca_br_url, httr = TRUE)
```

<p>
Let’s see the results:
</p>

             data valor
    1  01/01/2003  2.25
    2  01/02/2003  1.57
    3  01/03/2003  1.23
    4  01/04/2003  0.97
    5  01/05/2003  0.61
    6  01/06/2003 -0.15
    7  01/07/2003  0.20
    8  01/08/2003  0.34
    9  01/09/2003  0.78
    10 01/10/2003  0.29

<!-------------->
<!--- PART 4 --->
<!-------------->

## Bacen_Form

<p>

      In this function the script asks the user some questions related
with the data to be downloaded. Precisely, in the first step the user
has to inform the series code and a short name for the series. Next, the
user is asked whether it wants to inform another series. If yes the
procedure repeats, otherwise then the second step is on. The console now
asks the user the start and end date. These info are stored in four
variables representing series code, series name, initial and final
period. Combining this function with ***Bacen_URL*** yields the correct
url for the data extraction process.

</p>
<!-------------->
<!--- PART 5 --->
<!-------------->

## Combining all functions for data extraction

<p>

      Finally, let’s see the integration between the three functions in
order to extract the data. For this example we are going to consider a
group of four variables, which are the **Price Index** and the
**Economic Activity Index** for, respectively, Brazil and the State of
Ceará. The codes are, in this order, **433**, **24364**, **13005** and
**25391**, and consider the following names, **ipca_br**, **ibc_br**,
**ipca_for[^1]** and **ibc_ce**. The interval considered is (remember
the Brazilian date format) 01/01/2003 to 31/12/2023.  
      In the script bellow, the loop is according to the amount of
variables specified by the users. Basically, it gathers each series data
and then store them along with the others downloaded series. Have in
mind that for generating this tutorial I needed to create the variables
containing the codes, names e intervals, once there is no way to exhibit
the questions that appears in the console. However, while reproducing
this code in your machine, consider using the function ***Bacen_Form***
as indicated in the script. Let’s get to work.

</p>

``` r
# ---------------------------------------------------- #
# --- Example - Data Extraction (Scripts Combined) --- #
# ---------------------------------------------------- #

# --- Libraries --- #
library(devtools)


# --- Function --- #
# Sourcing functions from a github directory
source('https://raw.githubusercontent.com/paulo-icaro/Bacen_API/main/Bacen_URL.R')
source('https://raw.githubusercontent.com/paulo-icaro/Bacen_API/main/Bacen_API.R')


# Attention ! #

  # Run 
  # Run the commented line bellow. Remember to correctly specify the series codes and the date interval.
  # source('https://raw.githubusercontent.com/paulo-icaro/Bacen_API/main/Bacen_Form.R')    # Insert previous info for data extraction

  # Not Run
  # Info inserted only to execute and render the script in this tutorial. Don't need to execute this in your R console.
  cod_bacen_series = c('433', '13005', '24364', '25391')
  name_bacen_series = c('ipca_br', 'ipca_for', 'ibc_br', 'ibcr_ce')
  per_init_bacen_series = '01/01/2003'
  per_end_bacen_series = '01/12/2023'



# --- Data Extraction --- #
bacen_series = NULL                       # Variable for storing the downloaded data
for(i in 1:length(cod_bacen_series)){
  bacen_series_raw = bacen_api(url = bacen_url(cod_bacen_series[i], per_init_bacen_series, per_end_bacen_series))

  if(i == 1){bacen_series = bacen_series_raw}
  else{bacen_series = cbind(bacen_series, bacen_series_raw[,2])}

  if(i == length(cod_bacen_series)){
    colnames(bacen_series) = c('data', name_bacen_series)
    rm(bacen_series_raw, cod_bacen_series, name_bacen_series, per_init_bacen_series, per_end_bacen_series)
  }
}
```

The output is presented bellow:

             data ipca_br ipca_for ibc_br ibcr_ce
    1  01/01/2003    2.25     2.04 100.46  101.28
    2  01/02/2003    1.57     2.04 102.12  100.92
    3  01/03/2003    1.23     0.66 101.72  100.19
    4  01/04/2003    0.97     1.59 101.08  100.41
    5  01/05/2003    0.61     1.17  99.97  100.25
    6  01/06/2003   -0.15    -0.22 100.14  101.38
    7  01/07/2003    0.20    -0.05  98.92   99.22
    8  01/08/2003    0.34     0.03  99.76   99.47
    9  01/09/2003    0.78     0.40 101.70   98.62
    10 01/10/2003    0.29     0.43 101.91   98.79

[^1]: This index refers to the Fortaleza city which is the capital of
    the State of Ceará.
