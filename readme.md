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
connects with the BACEN API and extracts the info and converts it to a
readable format. At last, the ***Bacen_Form*** script is a short form
which interacts with the user in order to gather some information
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
and the end date. By specifying these arguments all the url’s are
generated.  
      In the example bellow, we are considering the Brazilian price
index time series (IPCA), whose code is 433, in the 2010/20 interval.
Once you called the function, just write the parameters and the job is
done.

**Attention !**

- have in mind that the date pattern is the brazilian one
  (*dd/mm/yyyy*);
- dot not forget to write the dates in string/character format;

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


ipca_br_url = bacen_url(433, '01/01/2003', '31/12/2023')    # Generating the URL
```

The resulting url is
<https://api.bcb.gov.br/dados/serie/bcdata.sgs.433/dados?formato=json&dataInicial=01/01/2003&dataFinal=31/12/2023>
