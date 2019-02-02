/*  1. DB IMPORT
  	--------------------------------------------------------------------
	NATIONAL UNIVERSITY
	ANA625: Categorical Data Methods, Appl (February 2018)
	Matthew C. Vanderbilt

	OBJECTIVE:
	Import database of San Diego Police Department Vehicle Stop data.
	-------------------------------------------------------------------- */

/*	--------------------------------------------------------------------
	By task:     Import Data Wizard
   
	Source file:
	C:\Users\rdy2d\OneDrive\Documents\Education\Matthew\National
 	University\ANA625\Project\ANA625.accdb
	Server:      Local File System
   
	Output data: WORK.ANA625
	Server:      Local

  	PROC IMPORT reads the data directly from the Microsoft Access
	database.
	-------------------------------------------------------------------- */
LIBNAME ANA625 'C:\..\Documents\Education\Matthew\National University\ANA625\Project';

PROC IMPORT
        TABLE="combinedVehicleStops_FINAL"
        OUT=ANA625.RawData
        REPLACE
        DBMS=ACCESS;
    DATABASE="C:\..\Documents\Education\Matthew\National University\ANA625\Project\ANA625.accdb";
RUN;

/*	--------------------------------------------------------------------
	PROC DATASETS modifies the attributes of the columns within the
	output data set.
	-------------------------------------------------------------------- */
PROC DATASETS LIBRARY=ANA625 NOLIST;
    MODIFY RawData;
        FORMAT
            Index            $CHAR26.
            stop_id          BEST12.
            stop_cause       $CHAR38.
            service_area     $CHAR7.
            subject_race     $CHAR1.
            subject_sex      $CHAR1.
            subject_age      $CHAR6.
            timestamp        $CHAR19.
            stop_date        $CHAR10.
            stop_time        $CHAR255.
            sd_resident      $CHAR1.
            arrested         $CHAR1.
            searched         $CHAR1.
            obtained_consent $CHAR1.
            contraband_found $CHAR1.
            property_seized  $CHAR1.
            search_details_type_flat $CHAR72.
            search_details_description_flat $CHAR113.
            stop_cause_clean $CHAR38.
            age_val          BEST12.
            year_val         BEST12.
            timestamp_val    DATETIME21.2
            race             $CHAR16. ;
        INFORMAT
            Index            $CHAR26.
            stop_id          BEST12.
            stop_cause       $CHAR38.
            service_area     $CHAR7.
            subject_race     $CHAR1.
            subject_sex      $CHAR1.
            subject_age      $CHAR6.
            timestamp        $CHAR19.
            stop_date        $CHAR10.
            stop_time        $CHAR255.
            sd_resident      $CHAR1.
            arrested         $CHAR1.
            searched         $CHAR1.
            obtained_consent $CHAR1.
            contraband_found $CHAR1.
            property_seized  $CHAR1.
            search_details_type_flat $CHAR72.
            search_details_description_flat $CHAR113.
            stop_cause_clean $CHAR38.
            age_val          BEST12.
            year_val         BEST12.
            timestamp_val    DATETIME21.
            race             $CHAR16. ;
RUN;
 
/*  2. CREATE POPULATION
    --------------------------------------------------------------------
	NATIONAL UNIVERSITY
	ANA625: Categorical Data Methods, Appl (February 2018)
	Matthew C. Vanderbilt

	OBJECTIVE:
	Create analytical population with derived fields for analysis
	-------------------------------------------------------------------- */

TITLE '-- SAMPLE TABLE CONTENTS';
PROC CONTENTS DATA=ANA625.RawData;
RUN;

/*	Creation of Population Sub-Sample */
DATA ANA625.Population (KEEP=stop_id
					stop_cause
					service_area
					subject_race
					subject_sex
					subject_age
					sd_resident
					arrested
					searched
					obtained_consent
					contraband_found
					property_seized
					search_details_type_flat
		            search_details_description_flat
		            stop_cause_clean
					age_val
					year_val
					timestamp_val
					race
					race_val
					gender_val
					age_group_val
					resident_val
					arrested_val
					searched_val
					obtained_consent_val
					contraband_found_val
					property_seized_val
					warning_val
					citation_val
					valid_search
					outcome
					policeaction
					time_of_day);
	SET ANA625.RawData	(WHERE=(stop_cause IN('Moving Violation','Equipment Violation')
						));

	LABEL stop_id = 'unique stop identifier';
	LABEL stop_cause = 'reason for the stop';
	LABEL service_area = 'police service area';
	LABEL subject_race = 'race code';
	LABEL subject_sex = 'sex code (M,F)';
	LABEL subject_age = 'age';
	LABEL timestamp = 'ISO8601 timestamp';
	LABEL stop_date = 'date (mm/dd/yy)';
	LABEL stop_time = 'time (24hrs format)';
	LABEL sd_resident = 'if subject is a resident of the City of San Diego (Y|N)';
	LABEL arrested = 'if subject was arrested (Y|N)';
	LABEL searched = 'if a search was conducted (Y|N)';
	LABEL obtained_consent = 'if a search was conducted, if consent was obtained (Y|N)';
	LABEL contraband_found = 'if a search was conducted, if contraband was found (Y|N)';
	LABEL property_seized = 'if a search was conducted, if property was seized (Y|N)';
	LABEL search_details_type_flat = 'type of search details record (Action taken|actionTakenOther|SearchBasis|SearchBasisOther|SearchType)';
	LABEL search_details_description_flat = 'search details description';
	LABEL stop_cause_clean = 'reason for the stop normalized for key data';
	LABEL age_val = 'numeric subject_age';
	LABEL year_val = 'numeric stop year';
	LABEL timestamp_val = '[stop_date]&[stop_time]';
	LABEL race = 'Vehicle Stop Race Code Description';
	LABEL race_val = 'race (1=White|2=Black|3=Hispanic|4=Other)';
	LABEL gender_val = 'gender (1=Male|2=Female|3=Other)';
	LABEL age_group_val = 'rn.com primary age group';
	LABEL resident_val = 'San Diego resident (1=Yes|0=No)';
	LABEL arrested_val = 'arrested (1=Yes|0=No)';
	LABEL searched_val = 'search appears to have been conducted (1=Yes|0=No)';
	LABEL obtained_consent_val = 'assumed consent (1=Yes|0=No/BLANK)';
	LABEL contraband_found_val = 'contraband appears to have been found (1=Yes|0=No)';
	LABEL property_seized_val = 'property appears to hvae been seized (1=Yes|0=No)';
	LABEL citation_val = 'citation issued (1=Yes|0=No)';
	LABEL warning_val = 'warning issued (1=Yes|0=No)';
	LABEL valid_search = 'search with contraband or seized property (1=Yes|0=No)';
	LABEL outcome = 'Highest Outcome: 1=Arrest, 2=Citation, 3=Prop Seized, 4=Warning, 5=Other';
	LABEL policeaction = 'Arrest or Citation (1=Yes|0=No)';
	LABEL time_of_day = '1:5<=Morning<12;2:12<=Afternoon<17;3:17<=Evening<21;4:(Night>=21 | Night<5)';

	IF subject_race IN(' ','') OR MISSING(subject_race) THEN subject_race='5';
	IF subject_sex IN(' ','') OR MISSING(subject_sex) THEN subject_sex = '5';
	IF age_val IN(' ','') OR MISSING(age_val) THEN age_val = 5;
	IF sd_resident IN(' ','') OR MISSING(sd_resident) THEN sd_resident = '5';
	IF arrested IN(' ','') OR MISSING(arrested) THEN arrested = '5';
	IF searched IN(' ','') OR MISSING(searched) THEN searched = '5';
	IF obtained_consent IN(' ','') OR MISSING(obtained_consent) THEN obtained_consent = '5';
	IF contraband_found IN(' ','') OR MISSING(contraband_found) THEN contraband_found = '5';
	IF property_seized IN(' ','') OR MISSING(property_seized) THEN property_seized = '5';
	IF race IN(' ','') OR MISSING(race) THEN race = 'NOT RECORDED';

	race_val = 4;
	IF UPCASE(subject_race) = 'W' THEN race_val = 1;
	IF UPCASE(subject_race) = 'B' THEN race_val = 2;
	IF UPCASE(subject_race) = 'H' THEN race_val = 3;

	gender_val = 5;
	IF UPCASE(subject_sex) = 'M' THEN gender_val = 1;
	IF UPCASE(subject_sex) = 'F' THEN gender_val = 2;
	
	age_group_val = 5;
	IF age_val >= 13 AND age_val <= 18 THEN age_group_val = 1; *adolescent;
	IF age_val >  18 AND age_val <  40 THEN age_group_val = 2; *young adult;
	IF age_val >= 40 AND age_val <  65 THEN age_group_val = 3; *middle aged;
	IF age_val >= 65 AND age_val < 111 THEN age_group_val = 4; *later adult;

	resident_val = 5;
	IF UPCASE(sd_resident) = 'N' THEN resident_val = 0;
	IF UPCASE(sd_resident) = 'Y' THEN resident_val = 1;

	arrested_val = 5;
	IF UPCASE(arrested) = 'N' THEN arrested_val = 0;
	IF UPCASE(arrested) = 'Y' THEN arrested_val = 1;
	IF UPCASE(arrested) NOT IN('Y','N') AND FIND(search_details_description_flat,'Arrest','i') > 0 THEN arrested_val = 1;

	searched_val = 5;
	IF UPCASE(searched) = 'N' THEN searched_val = 0;
	IF UPCASE(searched) = 'Y' THEN sarched_val = 1;
	IF obtained_consent IN('Y','N') 
		OR contraband_found IN('Y','N') 
		OR property_seized IN('Y','N') 
		OR FIND(search_details_type_flat,'Search','i') > 0
		THEN searched_val = 1;

	obtained_consent_val = 5;
	IF searched_val = 0 THEN obtained_consent_val = 2;
	IF UPCASE(obtained_consent) = 'N' THEN obtained_consent_val = 0;
	IF UPCASE(obtained_consent) = 'Y' THEN obtained_consent_val = 1;
	IF UPCASE(obtained_consent) NOT IN('Y','N') AND (FIND(search_details_description_flat,'Consent','i') > 0
													OR FIND(search_details_description_flat,'4th Waiver','i') > 0)
													THEN obtained_consent_val = 1;

	contraband_found_val = 5;
	IF searched_val = 0 THEN contraband_found_val = 2;
	IF UPCASE(contraband_found) = 'N' THEN contraband_found_val = 0;
	IF UPCASE(contraband_found) = 'Y' THEN contraband_found_val = 1;
	IF UPCASE(contraband_found) NOT IN('Y','N') AND FIND(search_details_description_flat,'Contraband Visible','i') > 0 THEN contraband_found_val = 1;

	property_seized_val = 5;
	IF searched_val = 0 THEN property_seized_val = 2;
	IF UPCASE(property_seized) = 'N' THEN property_seized_val = 0;
	IF UPCASE(property_seized) = 'Y' THEN property_seized_val = 1;
	IF UPCASE(property_seized) NOT IN('Y','N') AND (FIND(search_details_description_flat,'Tow','i') > 0
													OR FIND(search_details_description_flat,'Impound','i') > 0)
													THEN property_seized_val = 1;

	citation_val = 0; * default - no citation;
	IF FIND(search_details_description_flat,'Citation','i') > 0 THEN citation_val=1;
	IF FIND(search_details_description_flat,'Ticket','i') > 0 THEN citation_val=1;

	warning_val = 0; * default - no warning;
	IF (FIND(search_details_description_flat,'Warning','i') > 0 AND citation_val IN(0,2,5) AND arrested_val IN(0,5) AND property_seized_val IN(0,2,5)) THEN warning_val=1;

	valid_search = 5; * default - not a valid search;
	IF searched_val = 0 THEN valid_search = 2;
	IF searched_val = 1 AND (arrested_val = 1 OR contraband_found_val = 1 OR property_seized_val = 1) THEN valid_search = 1;
	IF searched_val = 1 AND (arrested_val = 0 AND contraband_found_val = 0 AND property_seized_val = 0) THEN valid_search = 0;

	outcome = 5; * default - no action / no data;
	IF warning_val = 1 THEN outcome = 4;
	IF property_seized_val = 1 THEN outcome = 3;
	IF citation_val = 1 THEN outcome = 2;
	IF arrested_val = 1 THEN outcome = 1;

	policeaction = 5;
	IF outcome IN(1,2,3) THEN policeaction = 1;
	IF outcome IN(4,5) THEN policeaction = 0;

	time_of_day = 0;
	IF HOUR(timestamp_val) >=  5 AND HOUR(timestamp_val) < 12 THEN time_of_day = 1;
	IF HOUR(timestamp_val) >= 12 AND HOUR(timestamp_val) < 17 THEN time_of_day = 2;
	IF HOUR(timestamp_val) >= 17 AND HOUR(timestamp_val) < 21 THEN time_of_day = 3;
	IF HOUR(timestamp_val) >= 21 OR  HOUR(timestamp_val) <  5 THEN time_of_day = 4;

RUN;

TITLE '-- SAMPLE TABLE CONTENTS';
PROC CONTENTS DATA=ANA625.Population;
RUN;

TITLE '-- CHECK RECODING OF VARIABLES';
PROC FREQ DATA=ANA625.Population;
	TABLES race*race_val subject_sex*gender_val sd_resident*resident_val arrested*arrested_val searched*searched_val obtained_consent*obtained_consent_val contraband_found*contraband_found_val property_seized*property_seized_val outcome*policeaction;
RUN;
 
/*  3. CREATE SAMPLE
   	--------------------------------------------------------------------
	NATIONAL UNIVERSITY
	ANA625: Categorical Data Methods, Appl (February 2018)
	Matthew C. Vanderbilt

	OBJECTIVE:
	Create analytical sample for study
	-------------------------------------------------------------------- */

/*	Creation of Population Sub-Sample */
DATA ANA625.Sample  (KEEP=stop_id
					stop_cause
					service_area
					subject_race
					subject_sex
					subject_age
					sd_resident
					arrested
					searched
					obtained_consent
					contraband_found
					property_seized
					search_details_type_flat
		            search_details_description_flat
		            stop_cause_clean
					age_val
					year_val
					timestamp_val
					race
					race_val
					gender_val
					age_group_val
					resident_val
					arrested_val
					searched_val
					obtained_consent_val
					contraband_found_val
					property_seized_val
					warning_val
					citation_val
					valid_search
					outcome
					policeaction
					time_of_day);
	SET ANA625.Population (WHERE=(	subject_race ^= '5'
									AND race NOT IN('NOT RECORDED')
									AND gender_val IN(1,2) /*data dictionary indicates field is only binary*/
									AND resident_val IN(0,1)
									AND policeaction IN(0,1)
									AND time_of_day IN(1,2,3,4)
					));

RUN;

TITLE '-- SAMPLE TABLE CONTENTS';
PROC CONTENTS DATA=ANA625.Sample;

RUN;
 
/*4. TABLES 1 & 2
  	--------------------------------------------------------------------
	NATIONAL UNIVERSITY
	ANA625: Categorical Data Methods, Appl (February 2018)
	Matthew C. Vanderbilt

	OBJECTIVE:
	Characteristics of modeled sample.
	-------------------------------------------------------------------- */

TITLE '-- TABLE 1: Descriptive & Bivariate Statistics';
PROC FREQ DATA=ANA625.Sample;
	TABLES (gender_val age_group_val resident_val searched_val obtained_consent_val contraband_found_val valid_search time_of_day)*race_val / CHISQ;
RUN;

TITLE '-- TABLE 1: Descriptive & Bivariate Statistics (Subset)';
PROC FREQ DATA=ANA625.Sample (WHERE=(searched_val = 1));
	TABLES (obtained_consent_val contraband_found_val valid_search)*race_val / CHISQ; *REMOVED valid_search;
RUN;

TITLE '-- TABLE 2: Descriptive & Univariate Statistics';
PROC FREQ DATA=ANA625.Sample;
	TABLES (race_val gender_val age_group_val resident_val searched_val obtained_consent_val contraband_found_val valid_search time_of_day)*policeaction / CHISQ;

RUN;
 
/*  5. INTERACTIONS
  	--------------------------------------------------------------------
	NATIONAL UNIVERSITY
	ANA625: Categorical Data Methods, Appl (February 2018)
	Matthew C. Vanderbilt

	OBJECTIVE:
	Testing of interactions between model variables.
	-------------------------------------------------------------------- */

TITLE '-- VARIABLE ASSOCIATION: Testing Interactions with Search';
PROC FREQ DATA=ANA625.Sample;
	TABLES (obtained_consent_val contraband_found_val valid_search)*searched_val / CHISQ;
RUN;

TITLE '-- VARIABLE ASSOCIATION: Testing Interactions with Search';
PROC FREQ DATA=ANA625.Sample;
	TABLES (age_group_val)*time_of_day / CHISQ;
RUN;

TITLE '-- MULTIVARIABLE REGRESSION: Testing Interactions with Search';
PROC LOGISTIC DATA=ANA625.Sample;
	CLASS policeaction(REF='0') race_val(REF='1') gender_val(REF='1') age_group_val(REF='2') resident_val(REF='1') searched_val(REF='0') obtained_consent_val(REF='0') contraband_found_val(REF='0') valid_search(REF='0') time_of_day(REF='2') / PARAM=REFERENCE;
	MODEL policeaction =  race_val gender_val age_group_val resident_val searched_val obtained_consent_val contraband_found_val valid_search searched_val*obtained_consent_val searched_val*contraband_found_val searched_val*valid_search valid_search*obtained_consent_val valid_search*contraband_found_val time_of_day age_group_val*time_of_day;
RUN;

TITLE '-- MULTIVARIABLE REGRESSION: Testing Interactions with Search';
PROC LOGISTIC DATA=ANA625.Sample;
	CLASS policeaction(REF='0') race_val(REF='1') gender_val(REF='1') age_group_val(REF='2') resident_val(REF='1') searched_val(REF='0') obtained_consent_val(REF='0') contraband_found_val(REF='0') valid_search(REF='0') time_of_day(REF='2') / PARAM=REFERENCE;
	MODEL policeaction =  race_val gender_val resident_val searched_val*obtained_consent_val searched_val*contraband_found_val searched_val*valid_search valid_search*obtained_consent_val valid_search*contraband_found_val age_group_val*time_of_day;
RUN;

TITLE '-- MULTICOLLINEARITY INVESTIGATION #1: Testing Interactions';
PROC REG DATA=ANA625.Sample;
	MODEL policeaction = race_val gender_val age_group_val resident_val searched_val obtained_consent_val contraband_found_val valid_search time_of_day / VIF TOL;
RUN;

TITLE '-- MULTICOLLINEARITY INVESTIGATION #2: Testing Interactions';
PROC REG DATA=ANA625.Sample;
	MODEL policeaction = race_val gender_val age_group_val resident_val searched_val /*obtained_consent_val*/ contraband_found_val valid_search time_of_day / VIF TOL;
RUN;

TITLE '-- MULTICOLLINEARITY INVESTIGATION #3: Testing Interactions';
PROC REG DATA=ANA625.Sample;
	MODEL policeaction = race_val gender_val age_group_val resident_val searched_val /*obtained_consent_val contraband_found_val*/ valid_search time_of_day / VIF TOL;

RUN;
 
/*  6. REGRESSION
  	--------------------------------------------------------------------
	NATIONAL UNIVERSITY
	ANA625: Categorical Data Methods, Appl (February 2018)
	Matthew C. Vanderbilt

	OBJECTIVE:
	The objective of this analysis is to statistically investigate the 
	association of police action at traffic stops and race, after 
	controlling for gender, age group, San Diego residency status, 
	validity of search, and time of day, within a sample of data from the 
	City of San Diego Police Department.  The formula below provides a 
	general idea of the model utilized:

		Police Action (Y|N) =
			race (White|Black|Hispanic|Other) +
			gender (Male|Female) +
			age (1=Adolescent:  13 <= subject_age <= 18 |
				 2=Young Adult: 18 <  subject_age <  40 |
				 3=Middle-Aged: 40 <= subject_age <  65 |
				 4=Later Adult:       subject_age >= 65) +
			resident (Y|N) +
			valid search (Y|N)
			time of day

	Original Population Size: 390,999 observations from 2014 - 2017
	- After Removal of Duplicate Records by [stop_id]: 387,351 (99.1%)
	-------------------------------------------------------------------- */

TITLE '-- TABLE 3: MULTIVARIABLE LOGISTIC REGRESSION';
PROC LOGISTIC DATA=ANA625.Sample;
	CLASS race_val(REF='1') gender_val(REF='2') age_group_val(REF='2') resident_val(REF='1') searched_val(REF='1') valid_search(REF='1') time_of_day(REF='1') / PARAM=REFERENCE;
	MODEL policeaction = race_val gender_val age_group_val resident_val searched_val valid_search time_of_day / LACKFIT;
RUN;

TITLE '-- TABLE 3: MULTIVARIABLE LOGISTIC REGRESSION';
PROC LOGISTIC DATA=ANA625.Sample;
	CLASS race_val(REF='1') gender_val(REF='2') age_group_val(REF='2') resident_val(REF='1') /*searched_val(REF='1')*/ valid_search(REF='1') time_of_day(REF='1') / PARAM=REFERENCE;
	MODEL policeaction = race_val gender_val age_group_val resident_val /*searched_val*/ valid_search time_of_day / LACKFIT;
RUN;

TITLE '-- TABLE 3: MULTIVARIABLE LOGISTIC REGRESSION';
PROC LOGISTIC DATA=ANA625.Sample;
	CLASS race_val(REF='1') gender_val(REF='2') age_group_val(REF='2') resident_val(REF='1') /*searched_val(REF='1') valid_search(REF='1')*/ time_of_day(REF='1') / PARAM=REFERENCE;
	MODEL policeaction = race_val gender_val age_group_val resident_val /*searched_val valid_search*/ time_of_day / LACKFIT;
RUN;

/* CONFOUNDING TESTING through Manual Backward Stepwise Regression Analysis */
TITLE '-- CONFOUNDING TEST: MULTIVARIABLE LOGISTIC REGRESSION / remove gender_val';
PROC LOGISTIC DATA=ANA625.Sample;
	CLASS race_val(REF='1') gender_val(REF='2') age_group_val(REF='2') resident_val(REF='1') /*searched_val(REF='1') valid_search(REF='1')*/ time_of_day(REF='1') / PARAM=REFERENCE;
	MODEL policeaction = race_val /*gender_val*/ age_group_val resident_val /*searched_val valid_search*/ time_of_day / LACKFIT;
RUN;

TITLE '-- CONFOUNDING TEST: MULTIVARIABLE LOGISTIC REGRESSION / remove age_group_val';
PROC LOGISTIC DATA=ANA625.Sample;
	CLASS race_val(REF='1') gender_val(REF='2') age_group_val(REF='2') resident_val(REF='1') /*searched_val(REF='1') valid_search(REF='1')*/ time_of_day(REF='1') / PARAM=REFERENCE;
	MODEL policeaction = race_val gender_val age_group_val /*resident_val*/ /*searched_val valid_search*/ time_of_day / LACKFIT;
RUN;

TITLE '-- CONFOUNDING TEST: MULTIVARIABLE LOGISTIC REGRESSION / remove resident_val';
PROC LOGISTIC DATA=ANA625.Sample;
	CLASS race_val(REF='1') gender_val(REF='2') age_group_val(REF='2') resident_val(REF='1') /*searched_val(REF='1') valid_search(REF='1')*/ time_of_day(REF='1') / PARAM=REFERENCE;
	MODEL policeaction = race_val gender_val /*age_group_val*/ resident_val /*searched_val valid_search*/ time_of_day / LACKFIT;
RUN;

TITLE '-- CONFOUNDING TEST: MULTIVARIABLE LOGISTIC REGRESSION / remove time-of-day';
PROC LOGISTIC DATA=ANA625.Sample;
	CLASS race_val(REF='1') gender_val(REF='2') age_group_val(REF='2') resident_val(REF='1') /*searched_val(REF='1') valid_search(REF='1')*/ time_of_day(REF='1') / PARAM=REFERENCE;
	MODEL policeaction = race_val gender_val age_group_val resident_val /*searched_val valid_search*/ /*time_of_day*/ / LACKFIT;
RUN;

QUIT;
