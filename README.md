# Secondary Analysis of Police Vehicle Stops
Developed by the [Matthew C. Vanderbilt](https://github.com/rdy2dve) for National University ANA625, Categorical Data Methods, March 2018.  The objective of this study was to statistically evaluate the association of police action and race, controlling for gender, age group, San Diego residency, and time-of-day.

## Getting Started
### Prerequisites
Authorization and connection to Hopper DW_DB required.
[COA_DB](https://github.com/UCSDMed/dw_db-coa_db) schema setup and updated.
Specified error handling procedures on SQL Server preferred.

### Installing
## Built With
* [SAS Enterprise Guide](https://www.sas.com/en_us/software/enterprise-guide.html) - Statistical analysis
* [Microsoft Access](https://products.office.com/en-us/access) - Data cleanup and preparation
** [Microsoft Visual Studio for Applications(VBA)](https://docs.microsoft.com/en-us/office/vba/api/overview/) - Custom data-manipulation function
** [Structured Query Language(SQL)](https://docs.microsoft.com/en-us/office/client-developer/access/desktop-database-reference/microsoft-access-sql-reference) - Custom data-manipulation queries

## Author(s)
* **Matthew C. Vanderbilt** - *Initial work* - [rdy2dve](https://github.com/rdy2dve)

## License
This code is licensed under GNU General Public License Version 3 - see the [LICENSE.md](LICENSE.md) file for details.

## Acknowledgments
* **Allen Browne** - Custom VBA function to concatenate values from related records [ConcatRelated](http://allenbrowne.com/func-concat.html)

## Abstract
San Diego is the eight-largest city in the United States, with its current population of 1.3 million expected to grow to 1.54 million by 2020 and 1.95 million by 2050. Its population is 44.2% White (non-Hispanic), 28.8% Hispanic, 6.7% Black, 16.4% Asian, 3.2% Multi-racial, and 0.8% Other. With the neighborhood partnerships of the San Diego Police Department, San Diego has become one of the safest metropolitan cities in the country. Given the current racial climate of the United States, however, a statistical review of police action and race can identify the need for any additional outreach or training to provide for non-racially-biased policing and reduce the potential for inequalities resulting in racial tension. The objective of this study was to statistically evaluate the association of police action and race, controlling for gender, age group, San Diego residency, and time-of-day. San Diego Police Department vehicle-stop data from 2014 through 2017 was utilized to provide the review of nearly 400,000 interactions. SAS was utilized to perform univariate and logistic regression analyses, as well as provide for multivariable and multivariate analysis of interactions and investigations of confounding and multicollinearity. The model has fairly-good predictive capabilities as measured by the c-statistic, and the results indicated a statistically-significant association between race and police action, as well as between those variables and gender, age, San Diego residency status, and time-of-day. While many additional factors need to be reviewed to identify causal factors and create opportunities for correction, these results support the need for such effort to occur.


##Conclusion
This model contains statistically-significant variables, does not include confounders or have issues with multicollinearity, and has a fairly-good c-statistics. It indicates the statistical association between race and police actions at traffic stops, resulting in increase risk of action for individuals racially identified as Black over White. While additional data is necessary to provide a stronger model and gain greater insight into each incident, this does provide a troubling statistic. Whether associated with negative bias towards Black members of the community, positive bias towards other races, or an underlying cultural disconnect and inherent inequality, such statistics highlight the need for additional analysis. “The American Anthropological Association recommends the elimination of the term ‘race’…as [it] has been scientifically proven to not be a real, natural phenomenon… Yet the concept of race has become thoroughly – and perniciously – woven into the cultural and political fabric of the United States… [T]hese classifications must be transcended and replaced by more non-racist and accurate ways of representing the diversity of the U.S. population.”[2](https://statisticalatlas.com/place/California/San-Diego/Race-and-Ethnicity) As one of the safest metropolitan areas in the United States, with a police department focused on neighborhood partnerships rather than reactionary policing, gaining additional insight into these statistics and real-time monitoring of associated risk trends, could identify outreach and training opportunities that could fundamentally change racial dynamics within the city