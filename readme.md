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
library(devtools)                                           # Package for importing github scripts

# --- Function --- #
# Source the function from a github directory
source('https://raw.githubusercontent.com/paulo-icaro/Bacen_API/main/Bacen_API.R')

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
