******************************************************************
*       Childhood trauma, adolescent risk behaviours, &          *
* cardiovascular health indices in the 2004 Pelotas Birth Cohort *
******************************************************************

***************************************************
* MULTIPLE IMPUTATION BY CHAINED EQUATIONS (MICE) *
***************************************************

//AUTHOR: Megan Bailey (mlb51@bath.ac.uk)
//about
Stata/BE 17.0 for Mac (Intel 64-bit)
Revision 19 Dec 2023
Copyright 1985-2021 StataCorp LLC

Total physical memory: 8.01 GB

Stata license: 100-student lab perpetual
Serial number: 301706312444
  Licensed to: Megan Bailey
               University of Bath
	
//ID NUMBER
* idnum: unique identifier	
	
//MEASURES
* Development and Wellbeing Assessment (DAWBA): age 6, 11, and 15 year parent-reports for child trauma
* Mini International Neuropsychiatric Interview (MINI): age 18 adolescent self-reports for trauma
* Alcohol Use Disorders Identification Test (AUDIT): age 18 adolescent problematic alcohol use
* Pittsburgh Sleep Quality Index: age 18 sleep duration

//VARIABLE DICTIONARY - IMPUTATION & ANALYSIS KEY VARIABLES
// trauma
* y6_alltrauma: exposure to any trauma up to age 6
* y6_cte: cumulative trauma load up to age 6
* trauma exposure up to ages 11 (y11_), 15 (y15_), and 18 (y18_) as above - dif prefix (these all consider prior reports from earlier follow-ups)

// adolescent risk behaviours
* y18_alcohol: current problematic alcohol use at age 18 (binary)
* y18_smoking: current smoking at age 18 (binary)
* y18_druguse: current illicit drug use at age 18 (binary)
* y18_sleepdur: current average sleep duration at age 18 (continuous)

// adolescent cardiovascular health indices
* y18_hr: mean resting heart rate at age 18
* y18_sbp: mean resting systolic blood pressure at age 18
* y18_dbp: mean resting diastolic blood pressure at age 18

// confounders
* sex: adolescent sex (binary)
* ethnicity: adolescent ethnicity (binary)
* malcohol: maternal alcohol consumption during pregnancy (binary)
* msmoking: maternal smoking during pregnancy (binary)
* meduc: maternal education years at birth (continuous)
* fincome: monthly family income at birth (continous)
* birthday: day of the year that the adolescent was born (from 1 to 365; proxy for cohort birth order; continuous)
* y15_activity: hours of physical activity at age 15 (continuous)
* y15_bmi: BMI z-score at age 15 (continuous)

// complete case indices
* cs_complete: complete data for adolescent risk behaviours and age 18 trauma exposure
* cs_compcon: as above, also complete case for confounders
* l11_complete: complete data for adolescent risk behaviours and age 11 trauma exposures
* l11_compcon: as above, also complete case for confounders
* l15_complete: complete data for adolescent risk behaviours and age 15 trauma exposure
* l15_compcon: as above, also complete case for confounders
* med_complete: complete data for adolescent substance use, age 15 trauma, and confounders (i.e., mediation data)

// auxiliary variables for multiple imputation
* tctspc6: Conflict & Tactic Scale (parent-report) score at age 6 
* tctspc11: Conflict & Tactic Scale (parent-report) score at age 11 
* tctspc15: Conflict & Tactic Scale (parent-report) score at age 15
* birthweight: child birthweight (continuous)
* y11_alcohol: ever used alcohol at age 11 (binary)
* y11_smoking: ever smoked at age 11 (binary)
* y11_sleepdur: current average sleep duration at age 11 (continuous)
* y15_alcohol: ever been drunk at age 15 (binary)
* y15_smoking: ever smoked at age 15 (binary)
* y15_druguse: ever used illicit drugs at age 15 (binary)
* y15_sleepdur: current average sleep duration at age 15 (continuous)
* y11_activity: physical activity (number of activities) at age 11 (continuous)
* y11_bmi: age adjusted BMI at age 11 (continuous)

**********************************************************

* APPENDIX 1 TABLE S1 - ASSOCIATIONS BETWEEN CONFOUNDERS AND THE MAIN EXPOSURE AND OUTCOMES AT AGE 18 *

//association with CTE @ 18
regress y18_cte sex if cs_compcon==1
regress y18_cte ethnicity if cs_compcon==1
regress y18_cte msmoking if cs_compcon==1
regress y18_cte malcohol if cs_compcon==1
regress y18_cte fincome if cs_compcon==1
regress y18_cte meduc if cs_compcon==1
regress y18_cte birthday if cs_compcon==1
regress y18_cte y11_alcohol if cs_compcon==1
regress y18_cte y11_smoking if cs_compcon==1
regress y18_cte y11_sleepdur if cs_compcon==1

//association with problematic alcohol @ 18
logistic y18_alcohol sex if cs_compcon==1
logistic y18_alcohol ethnicity if cs_compcon==1
logistic y18_alcohol msmoking if cs_compcon==1
logistic y18_alcohol malcohol if cs_compcon==1
logistic y18_alcohol fincome if cs_compcon==1
logistic y18_alcohol meduc if cs_compcon==1
logistic y18_alcohol birthday if cs_compcon==1
logistic y18_alcohol y11_alcohol if cs_compcon==1
logistic y18_alcohol y11_smoking if cs_compcon==1
logistic y18_alcohol y11_sleepdur if cs_compcon==1

//association with smoking @ 18
logistic y18_smoking sex if cs_compcon==1
logistic y18_smoking ethnicity if cs_compcon==1
logistic y18_smoking msmoking if cs_compcon==1
logistic y18_smoking malcohol if cs_compcon==1
logistic y18_smoking fincome if cs_compcon==1
logistic y18_smoking meduc if cs_compcon==1
logistic y18_smoking birthday if cs_compcon==1
logistic y18_smoking y11_alcohol if cs_compcon==1
logistic y18_smoking y11_smoking if cs_compcon==1
logistic y18_smoking y11_sleepdur if cs_compcon==1

//association with illicit drug use @ 18
logistic y18_druguse sex if cs_compcon==1
logistic y18_druguse ethnicity if cs_compcon==1
logistic y18_druguse msmoking if cs_compcon==1
logistic y18_druguse malcohol if cs_compcon==1
logistic y18_druguse fincome if cs_compcon==1
logistic y18_druguse meduc if cs_compcon==1
logistic y18_druguse birthday if cs_compcon==1
logistic y18_druguse y11_alcohol if cs_compcon==1
logistic y18_druguse y11_smoking if cs_compcon==1
logistic y18_druguse y11_sleepdur if cs_compcon==1

//association with sleep duration @ 18
regress y18_sleepdur sex if cs_compcon==1
regress y18_sleepdur ethnicity if cs_compcon==1
regress y18_sleepdur msmoking if cs_compcon==1
regress y18_sleepdur malcohol if cs_compcon==1
regress y18_sleepdur fincome if cs_compcon==1
regress y18_sleepdur meduc if cs_compcon==1
regress y18_sleepdur birthday if cs_compcon==1
regress y18_sleepdur y11_alcohol if cs_compcon==1
regress y18_sleepdur y11_smoking if cs_compcon==1
regress y18_sleepdur y11_sleepdur if cs_compcon==1

**********************************************************

* APPENDIX 1 TABLE S2 - SUMMARY OF MISSING DATA *

*missing values
misstable summarize y18_cte y18_alcohol y18_smoking y18_druguse y18_sleepdur y11_cte y15_cte y18_alltrauma sex ethnicity msmoking malcohol meduc fincome y11_alcohol y11_smoking y11_sleepdur y15_alcohol y15_smoking y15_druguse y15_sleepdur birthweight birthday tctspc6 tctspc11 tctspc15 y18_hr y18_sbp y18_dbp y15_activity y15_bmi y11_activity y11_bmi 
*mean and SD
summarize y18_cte y18_alcohol y18_smoking y18_druguse y18_sleepdur y11_cte y15_cte y18_alltrauma sex ethnicity msmoking malcohol meduc fincome y11_alcohol y11_smoking y11_sleepdur y15_alcohol y15_smoking y15_druguse y15_sleepdur birthweight birthday tctspc6 tctspc11 tctspc15 y18_hr y18_sbp y18_dbp y15_activity y15_bmi y11_activity y11_bmi 
*skewness and kurtosis
sktest y18_cte y18_sleepdur y11_cte y15_cte meduc fincome y11_sleepdur y15_sleepdur birthweight birthday tctspc6 tctspc11 tctspc15 y18_hr y18_sbp y18_dbp y15_activity y15_bmi y11_activity y11_bmi 

**********************************************************

* APPENDIX 1 TABLE S3 - COMPARISON OF COMPLETE CASES AND THOSE WITH MISSING INFORMATION FOR TRAUMA EXPOSURE AT AGE 15 AND ADOLESCENT RISK BEHAVIOURS AT AGE 18 *

generate l15_missing=.
replace l15_missing=1 if l15_complete==0
replace l15_missing=0 if l15_complete==1
label values l15_missing missing
label variable l15_missing "Missingness for longitudinal analyses at age 15"
//proportion missing
misstable summarize y6_alltrauma y11_alltrauma y11_alcohol y11_smoking y11_sleepdur sex ethnicity birthday msmoking malcohol meduc fincome
//complete case statistics
tab y6_alltrauma if l15_missing==0
tab y11_alltrauma if l15_missing==0
tab y11_alcohol if l15_missing==0
tab y11_smoking if l15_missing==0
summarize y11_sleepdur if l15_missing==0
tab sex if l15_missing==0
tab ethnicity if l15_missing==0
summarize birthday if l15_missing==0
tab msmoking if l15_missing==0
tab malcohol if l15_missing==0
summarize meduc if l15_missing==0
summarize fincome if l15_missing==0
//missing statistics
tab y6_alltrauma if l15_missing==1
tab y11_alltrauma if l15_missing==1
tab y11_alcohol if l15_missing==1
tab y11_smoking if l15_missing==1
summarize y11_sleepdur if l15_missing==1
tab sex if l15_missing==1
tab ethnicity if l15_missing==1
summarize birthday if l15_missing==1
tab msmoking if l15_missing==1
tab malcohol if l15_missing==1
summarize meduc if l15_missing==1
summarize fincome if l15_missing==1
//association with missingness
logistic l15_missing i.y6_alltrauma 
logistic l15_missing i.y11_alltrauma
logistic l15_missing i.y11_alcohol
logistic l15_missing i.y11_smoking
logistic l15_missing y11_sleepdur
logistic l15_missing i.sex
logistic l15_missing i.ethnicity
logistic l15_missing birthday
logistic l15_missing i.msmoking
logistic l15_missing i.malcohol
logistic l15_missing meduc
logistic l15_missing fincome

**********************************************************

* APPENDIX 1 TABLE S4 - COMPARISON OF COMPLETE CASES AND THOSE WITH MISSING INFORMATION FOR TRAUMA EXPOSURE AND/OR ADOLESCENT RISK BEHAVIOURS AT AGE 18 *

generate cs_missing=.
replace cs_missing=1 if cs_complete==0
replace cs_missing=0 if cs_complete==1
label define missing 0 "Not missing" 1 "Missing"
label values cs_missing missing
label variable cs_missing "Missingness for cross-sectional analyses"
misstable summarize y6_alltrauma y11_alltrauma y11_alcohol y11_smoking y11_sleepdur sex ethnicity birthday msmoking malcohol meduc fincome 
//complete case statistics
tab y6_alltrauma if cs_missing==0
tab y11_alltrauma if cs_missing==0
tab y11_alcohol if cs_missing==0
tab y11_smoking if cs_missing==0
summarize y11_sleepdur if cs_missing==0
tab sex if cs_missing==0
tab ethnicity if cs_missing==0
summarize birthday if cs_missing==0
tab msmoking if cs_missing==0
tab malcohol if cs_missing==0
summarize meduc if cs_missing==0
summarize fincome if cs_missing==0
//missing statistics
tab y6_alltrauma if cs_missing==1
tab y11_alltrauma if cs_missing==1
tab y11_alcohol if cs_missing==1
tab y11_smoking if cs_missing==1
summarize y11_sleepdur if cs_missing==1
tab sex if cs_missing==1
tab ethnicity if cs_missing==1
summarize birthday if cs_missing==1
tab msmoking if cs_missing==1
tab malcohol if cs_missing==1
summarize meduc if cs_missing==1
summarize fincome if cs_missing==1
//association with missingness
logistic cs_missing i.y6_alltrauma 
logistic cs_missing i.y11_alltrauma
logistic cs_missing i.y11_alcohol
logistic cs_missing i.y11_smoking
logistic cs_missing y11_sleepdur
logistic cs_missing i.sex
logistic cs_missing i.ethnicity
logistic cs_missing birthday
logistic cs_missing i.msmoking
logistic cs_missing i.malcohol
logistic cs_missing meduc
logistic cs_missing fincome

**********************************************************

* CORRELATIONS *
*full sample
tetrachoric y18_alcohol y18_smoking y18_druguse y18_alltrauma sex ethnicity msmoking malcohol y11_alcohol y11_smoking y15_alcohol y15_smoking y15_druguse, pw stats(rho se obs p)
spearman y18_alcohol y18_smoking y18_druguse y18_sleepdur y18_alltrauma y18_cte y11_cte y15_cte sex ethnicity msmoking malcohol meduc fincome y11_alcohol y11_smoking y11_sleepdur y15_alcohol y15_smoking y15_druguse y15_sleepdur birthweight tctspc6 tctspc11 tctspc15 birthday, stats(rho p)
*females
tetrachoric y18_alcohol y18_smoking y18_druguse y18_alltrauma sex ethnicity msmoking malcohol y11_alcohol y11_smoking y15_alcohol y15_smoking y15_druguse, pw stats(rho se obs p)
spearman y18_alcohol y18_smoking y18_druguse y18_sleepdur y18_alltrauma y18_cte y11_cte y15_cte sex ethnicity msmoking malcohol meduc fincome y11_alcohol y11_smoking y11_sleepdur y15_alcohol y15_smoking y15_druguse y15_sleepdur birthweight tctspc6 tctspc11 tctspc15 birthday if sex==0, stats(rho p)
*males
tetrachoric y18_alcohol y18_smoking y18_druguse y18_alltrauma sex ethnicity msmoking malcohol y11_alcohol y11_smoking y15_alcohol y15_smoking y15_druguse, pw stats(rho se obs p)
spearman y18_alcohol y18_smoking y18_druguse y18_sleepdur y18_alltrauma y18_cte y11_cte y15_cte sex ethnicity msmoking malcohol meduc fincome y11_alcohol y11_smoking y11_sleepdur y15_alcohol y15_smoking y15_druguse y15_sleepdur birthweight tctspc6 tctspc11 tctspc15 birthday if sex==1, stats(rho p)

**********************************************************

* MODEL 1: CTE @ 18y *

use "250324_s2prep_v9_MB.dta", clear
save "040424_miM1_MB.dta", replace 

xtset, clear
mi set flong
mi stset, clear
mi register regular sex msmoking malcohol fincome birthday
mi register imputed y18_alcohol y18_smoking y18_druguse y18_sleepdur y18_cte ethnicity meduc y11_alcohol y11_smoking y11_sleepdur y15_alcohol y15_smoking y15_druguse y15_sleepdur birthweight tctspc6 tctspc11 

//dry run model
local auxiliary "birthweight tctspc6 tctspc11"
local sleep "y18_sleepdur y11_sleepdur y15_sleepdur"
local y18hrbs "i.y18_alcohol i.y18_smoking i.y18_druguse"
local y11hrbs "i.y11_alcohol i.y11_smoking"
local y15hrbs "i.y15_alcohol i.y15_smoking i.y15_druguse"
 
set more off
mi impute chained ///
(pmm, knn(10) omit(i.y11_alcohol i.y11_smoking y11_sleepdur i.y15_alcohol i.y15_smoking i.y15_druguse y15_sleepdur birthweight)) y18_cte ///
(logit, omit(i.y11_smoking `sleep' `auxiliary')) y18_alcohol ///
(logit, omit(i.y11_alcohol `sleep' `auxiliary')) y18_smoking ///
(logit, omit(i.y11_alcohol `sleep' `auxiliary')) y18_druguse ///
(pmm, knn(10) omit(`y18hrbs' `y11hrbs' `y15hrbs' `auxiliary')) y18_sleepdur ///
(logit, omit(`y11hrbs' y11_sleepdur `y15hrbs' y15_sleepdur `auxiliary')) ethnicity ///
(pmm, knn(10) omit(`y11hrbs' y11_sleepdur `y15hrbs' y15_sleepdur tctspc6 tctspc11)) meduc ///
(logit, omit(i.y18_druguse y18_cte i.ethnicity meduc `sleep' `auxiliary')) y11_alcohol ///
(logit, omit(i.y18_alcohol y18_cte meduc i.y15_alcohol i.y15_smoking i.y15_druguse `sleep' birthweight)) y11_smoking ///
(pmm, knn(10) omit(`y18hrbs' y18_cte i.ethnicity meduc i.y11_smoking `y15hrbs' y15_sleepdur `auxiliary')) y11_sleepdur ///
(logit, omit(y18_cte i.ethnicity meduc i.y11_smoking `sleep' `auxiliary')) y15_alcohol ///
(logit, omit(i.ethnicity i.y11_smoking `sleep' `auxiliary')) y15_smoking ///
(logit, omit(y18_cte i.ethnicity meduc `y11hrbs' `sleep' `auxiliary')) y15_druguse ///
(pmm, knn(10) omit(i.y18_smoking i.y18_druguse y18_cte i.ethnicity `y11hrbs' y11_sleepdur i.y15_druguse `auxiliary')) y15_sleepdur ///
(pmm, knn(10) omit(`y18hrbs' y18_cte i.ethnicity `y11hrbs' `y15hrbs' tctspc6 tctspc11 `sleep')) birthweight ///
(pmm, knn(10) omit(`y18hrbs' i.ethnicity meduc `y11hrbs' `y15hrbs' birthweight `sleep')) tctspc6 ///
(pmm, knn(10) omit(`y18hrbs' `y11hrbs' `y15hrbs' birthweight `sleep')) tctspc11 ///
	= i.sex i.msmoking i.malcohol fincome birthday, dryrun
	
//convergence checks
regress y18_cte meduc i.ethnicity tctspc11 tctspc6 i.y18_smoking i.y18_druguse i.y18_alcohol y18_sleepdur i.sex i.msmoking i.malcohol fincome birthday if _mi_m==0
logistic y18_alcohol meduc i.ethnicity i.y11_alcohol i.y18_smoking i.y18_druguse y18_cte i.y15_smoking i.y15_alcohol i.y15_druguse i.sex i.msmoking i.malcohol fincome birthday if _mi_m==0
logistic y18_smoking meduc i.ethnicity i.y11_smoking i.y18_druguse i.y18_alcohol y18_cte i.y15_smoking i.y15_alcohol i.y15_druguse i.sex i.msmoking i.malcohol fincome birthday if _mi_m==0
logistic y18_druguse meduc i.ethnicity i.y11_smoking i.y18_smoking i.y18_alcohol y18_cte i.y15_smoking i.y15_alcohol i.y15_druguse i.sex i.msmoking i.malcohol fincome birthday if _mi_m==0
regress y18_sleepdur meduc i.ethnicity y11_sleepdur y18_cte y15_sleepdur i.sex i.msmoking i.malcohol fincome birthday if _mi_m==0
*no abnormally large SEs

//m=10
local auxiliary "birthweight tctspc6 tctspc11"
local sleep "y18_sleepdur y11_sleepdur y15_sleepdur"
local y18hrbs "i.y18_alcohol i.y18_smoking i.y18_druguse"
local y11hrbs "i.y11_alcohol i.y11_smoking"
local y15hrbs "i.y15_alcohol i.y15_smoking i.y15_druguse"
 
set more off
mi impute chained ///
(pmm, knn(10) omit(i.y11_alcohol i.y11_smoking y11_sleepdur i.y15_alcohol i.y15_smoking i.y15_druguse y15_sleepdur birthweight)) y18_cte ///
(logit, omit(i.y11_smoking `sleep' `auxiliary')) y18_alcohol ///
(logit, omit(i.y11_alcohol `sleep' `auxiliary')) y18_smoking ///
(logit, omit(i.y11_alcohol `sleep' `auxiliary')) y18_druguse ///
(pmm, knn(10) omit(`y18hrbs' `y11hrbs' `y15hrbs' `auxiliary')) y18_sleepdur ///
(logit, omit(`y11hrbs' y11_sleepdur `y15hrbs' y15_sleepdur `auxiliary')) ethnicity ///
(pmm, knn(10) omit(`y11hrbs' y11_sleepdur `y15hrbs' y15_sleepdur tctspc6 tctspc11)) meduc ///
(logit, omit(i.y18_druguse y18_cte i.ethnicity meduc `sleep' `auxiliary')) y11_alcohol ///
(logit, omit(i.y18_alcohol y18_cte meduc i.y15_alcohol i.y15_smoking i.y15_druguse `sleep' birthweight)) y11_smoking ///
(pmm, knn(10) omit(`y18hrbs' y18_cte i.ethnicity meduc i.y11_smoking `y15hrbs' y15_sleepdur `auxiliary')) y11_sleepdur ///
(logit, omit(y18_cte i.ethnicity meduc i.y11_smoking `sleep' `auxiliary')) y15_alcohol ///
(logit, omit(i.ethnicity i.y11_smoking `sleep' `auxiliary')) y15_smoking ///
(logit, omit(y18_cte i.ethnicity meduc `y11hrbs' `sleep' `auxiliary')) y15_druguse ///
(pmm, knn(10) omit(i.y18_smoking i.y18_druguse y18_cte i.ethnicity `y11hrbs' y11_sleepdur i.y15_druguse `auxiliary')) y15_sleepdur ///
(pmm, knn(10) omit(`y18hrbs' y18_cte i.ethnicity `y11hrbs' `y15hrbs' tctspc6 tctspc11 `sleep')) birthweight ///
(pmm, knn(10) omit(`y18hrbs' i.ethnicity meduc `y11hrbs' `y15hrbs' birthweight `sleep')) tctspc6 ///
(pmm, knn(10) omit(`y18hrbs' `y11hrbs' `y15hrbs' birthweight `sleep')) tctspc11 ///
	= i.sex i.msmoking i.malcohol fincome birthday, add(10) rseed(100) by(sex) noisily 
	
*perfect pred error - y11_smoking and malcohol for females (sex==0) - omitted malcohol from imputation equation

//m=10
local auxiliary "birthweight tctspc6 tctspc11"
local sleep "y18_sleepdur y11_sleepdur y15_sleepdur"
local y18hrbs "i.y18_alcohol i.y18_smoking i.y18_druguse"
local y11hrbs "i.y11_alcohol i.y11_smoking"
local y15hrbs "i.y15_alcohol i.y15_smoking i.y15_druguse"
 
set more off
mi impute chained ///
(pmm, knn(10) omit(i.y11_alcohol i.y11_smoking y11_sleepdur i.y15_alcohol i.y15_smoking i.y15_druguse y15_sleepdur birthweight)) y18_cte ///
(logit, omit(i.y11_smoking `sleep' `auxiliary')) y18_alcohol ///
(logit, omit(i.y11_alcohol `sleep' `auxiliary')) y18_smoking ///
(logit, omit(i.y11_alcohol `sleep' `auxiliary')) y18_druguse ///
(pmm, knn(10) omit(`y18hrbs' `y11hrbs' `y15hrbs' `auxiliary')) y18_sleepdur ///
(logit, omit(`y11hrbs' y11_sleepdur `y15hrbs' y15_sleepdur `auxiliary')) ethnicity ///
(pmm, knn(10) omit(`y11hrbs' y11_sleepdur `y15hrbs' y15_sleepdur tctspc6 tctspc11)) meduc ///
(logit, omit(i.y18_druguse y18_cte i.ethnicity meduc `sleep' `auxiliary')) y11_alcohol ///
(logit, omit(i.y18_alcohol y18_cte meduc i.y15_alcohol i.y15_smoking i.y15_druguse `sleep' birthweight i.malcohol)) y11_smoking ///
(pmm, knn(10) omit(`y18hrbs' y18_cte i.ethnicity meduc i.y11_smoking `y15hrbs' y15_sleepdur `auxiliary')) y11_sleepdur ///
(logit, omit(y18_cte i.ethnicity meduc i.y11_smoking `sleep' `auxiliary')) y15_alcohol ///
(logit, omit(i.ethnicity i.y11_smoking `sleep' `auxiliary')) y15_smoking ///
(logit, omit(y18_cte i.ethnicity meduc `y11hrbs' `sleep' `auxiliary')) y15_druguse ///
(pmm, knn(10) omit(i.y18_smoking i.y18_druguse y18_cte i.ethnicity `y11hrbs' y11_sleepdur i.y15_druguse `auxiliary')) y15_sleepdur ///
(pmm, knn(10) omit(`y18hrbs' y18_cte i.ethnicity `y11hrbs' `y15hrbs' tctspc6 tctspc11 `sleep')) birthweight ///
(pmm, knn(10) omit(`y18hrbs' i.ethnicity meduc `y11hrbs' `y15hrbs' birthweight `sleep')) tctspc6 ///
(pmm, knn(10) omit(`y18hrbs' `y11hrbs' `y15hrbs' birthweight `sleep')) tctspc11 ///
	= i.sex i.msmoking i.malcohol fincome birthday, add(10) rseed(100) by(sex) noisily 
	
//m=50
local auxiliary "birthweight tctspc6 tctspc11"
local sleep "y18_sleepdur y11_sleepdur y15_sleepdur"
local y18hrbs "i.y18_alcohol i.y18_smoking i.y18_druguse"
local y11hrbs "i.y11_alcohol i.y11_smoking"
local y15hrbs "i.y15_alcohol i.y15_smoking i.y15_druguse"
 
set more off
mi impute chained ///
(pmm, knn(10) omit(i.y11_alcohol i.y11_smoking y11_sleepdur i.y15_alcohol i.y15_smoking i.y15_druguse y15_sleepdur birthweight)) y18_cte ///
(logit, omit(i.y11_smoking `sleep' `auxiliary')) y18_alcohol ///
(logit, omit(i.y11_alcohol `sleep' `auxiliary')) y18_smoking ///
(logit, omit(i.y11_alcohol `sleep' `auxiliary')) y18_druguse ///
(pmm, knn(10) omit(`y18hrbs' `y11hrbs' `y15hrbs' `auxiliary')) y18_sleepdur ///
(logit, omit(`y11hrbs' y11_sleepdur `y15hrbs' y15_sleepdur `auxiliary')) ethnicity ///
(pmm, knn(10) omit(`y11hrbs' y11_sleepdur `y15hrbs' y15_sleepdur tctspc6 tctspc11)) meduc ///
(logit, omit(i.y18_druguse y18_cte i.ethnicity meduc `sleep' `auxiliary')) y11_alcohol ///
(logit, omit(i.y18_alcohol y18_cte meduc i.y15_alcohol i.y15_smoking i.y15_druguse `sleep' birthweight i.malcohol)) y11_smoking ///
(pmm, knn(10) omit(`y18hrbs' y18_cte i.ethnicity meduc i.y11_smoking `y15hrbs' y15_sleepdur `auxiliary')) y11_sleepdur ///
(logit, omit(y18_cte i.ethnicity meduc i.y11_smoking `sleep' `auxiliary')) y15_alcohol ///
(logit, omit(i.ethnicity i.y11_smoking `sleep' `auxiliary')) y15_smoking ///
(logit, omit(y18_cte i.ethnicity meduc `y11hrbs' `sleep' `auxiliary')) y15_druguse ///
(pmm, knn(10) omit(i.y18_smoking i.y18_druguse y18_cte i.ethnicity `y11hrbs' y11_sleepdur i.y15_druguse `auxiliary')) y15_sleepdur ///
(pmm, knn(10) omit(`y18hrbs' y18_cte i.ethnicity `y11hrbs' `y15hrbs' tctspc6 tctspc11 `sleep')) birthweight ///
(pmm, knn(10) omit(`y18hrbs' i.ethnicity meduc `y11hrbs' `y15hrbs' birthweight `sleep')) tctspc6 ///
(pmm, knn(10) omit(`y18hrbs' `y11hrbs' `y15hrbs' birthweight `sleep')) tctspc11 ///
	= i.sex i.msmoking i.malcohol fincome birthday, add(50) rseed(100) by(sex) noisily 
	
//DATA EXPLORATION
log using "[pathname]/040424_miM1_dataexplore.smcl"
summarize _mi_id _mi_miss _mi_m

*compare mean and summary stats for the original data and compare it with imputed data
tab _mi_m, summarize(y18_cte)
tab _mi_m, summarize(y18_alcohol)
tab _mi_m, summarize(y18_smoking)
tab _mi_m, summarize(y18_druguse)
tab _mi_m, summarize(y18_sleepdur)
tab _mi_m, summarize(ethnicity) 
tab _mi_m, summarize(meduc) 
tab _mi_m, summarize(y11_alcohol)
tab _mi_m, summarize(y11_smoking)
tab _mi_m, summarize(y11_sleepdur)
tab _mi_m, summarize(y15_alcohol)
tab _mi_m, summarize(y15_smoking)
tab _mi_m, summarize(y15_druguse)
tab _mi_m, summarize(y15_sleepdur)
tab _mi_m, summarize(birthweight)
tab _mi_m, summarize(tctspc6)
tab _mi_m, summarize(tctspc11)

*Monte Carlo Error - check whether the Monte Carlo error of B is approximately 10 per cent of its standard error (so one value below coefficient vs SE of the coefficient)
mi estimate, mcerror: logistic y18_alcohol y18_cte
mi estimate, mcerror: logistic y18_smoking y18_cte
mi estimate, mcerror: logistic y18_druguse y18_cte
mi estimate, mcerror: regress y18_sleepdur y18_cte
mi estimate, mcerror: logistic y18_alcohol y18_cte sex ethnicity msmoking malcohol meduc fincome birthday
mi estimate, mcerror: logistic y18_smoking y18_cte sex ethnicity msmoking malcohol meduc fincome birthday
mi estimate, mcerror: logistic y18_druguse y18_cte sex ethnicity msmoking malcohol meduc fincome birthday
mi estimate, mcerror: regress y18_sleepdur y18_cte sex ethnicity msmoking malcohol meduc fincome birthday

//IMPUTATION CHECKS
*checking imputation process to see if need more cycles of chained equations algorithm
use "040424_miM1_MB", clear
save "040424_miM1_trace_MB", replace 

//note: savetrace cannot be combined with the by() command
local auxiliary "birthweight tctspc6 tctspc11"
local sleep "y18_sleepdur y11_sleepdur y15_sleepdur"
local y18hrbs "i.y18_alcohol i.y18_smoking i.y18_druguse"
local y11hrbs "i.y11_alcohol i.y11_smoking"
local y15hrbs "i.y15_alcohol i.y15_smoking i.y15_druguse"
 
set more off
mi impute chained ///
(pmm, knn(10) omit(i.y11_alcohol i.y11_smoking y11_sleepdur i.y15_alcohol i.y15_smoking i.y15_druguse y15_sleepdur birthweight)) y18_cte ///
(logit, omit(i.y11_smoking `sleep' `auxiliary')) y18_alcohol ///
(logit, omit(i.y11_alcohol `sleep' `auxiliary')) y18_smoking ///
(logit, omit(i.y11_alcohol `sleep' `auxiliary')) y18_druguse ///
(pmm, knn(10) omit(`y18hrbs' `y11hrbs' `y15hrbs' `auxiliary')) y18_sleepdur ///
(logit, omit(`y11hrbs' y11_sleepdur `y15hrbs' y15_sleepdur `auxiliary')) ethnicity ///
(pmm, knn(10) omit(`y11hrbs' y11_sleepdur `y15hrbs' y15_sleepdur tctspc6 tctspc11)) meduc ///
(logit, omit(i.y18_druguse y18_cte i.ethnicity meduc `sleep' `auxiliary')) y11_alcohol ///
(logit, omit(i.y18_alcohol y18_cte meduc i.y15_alcohol i.y15_smoking i.y15_druguse `sleep' birthweight i.malcohol)) y11_smoking ///
(pmm, knn(10) omit(`y18hrbs' y18_cte i.ethnicity meduc i.y11_smoking `y15hrbs' y15_sleepdur `auxiliary')) y11_sleepdur ///
(logit, omit(y18_cte i.ethnicity meduc i.y11_smoking `sleep' `auxiliary')) y15_alcohol ///
(logit, omit(i.ethnicity i.y11_smoking `sleep' `auxiliary')) y15_smoking ///
(logit, omit(y18_cte i.ethnicity meduc `y11hrbs' `sleep' `auxiliary')) y15_druguse ///
(pmm, knn(10) omit(i.y18_smoking i.y18_druguse y18_cte i.ethnicity `y11hrbs' y11_sleepdur i.y15_druguse `auxiliary')) y15_sleepdur ///
(pmm, knn(10) omit(`y18hrbs' y18_cte i.ethnicity `y11hrbs' `y15hrbs' tctspc6 tctspc11 `sleep')) birthweight ///
(pmm, knn(10) omit(`y18hrbs' i.ethnicity meduc `y11hrbs' `y15hrbs' birthweight `sleep')) tctspc6 ///
(pmm, knn(10) omit(`y18hrbs' `y11hrbs' `y15hrbs' birthweight `sleep')) tctspc11 ///
	= i.sex i.msmoking i.malcohol fincome birthday, rseed(100) chainonly burnin(100) savetrace(m1_imptrace)
	
//check scatterplots for convergence
use m1_imptrace

scatter y18_cte_mean iter, c(1)
graph save "Graph" "[pathname]/Trace Scatterplots/m1_y18cte.gph", replace
scatter y18_alcohol_mean iter, c(1)
graph save "Graph" "[pathname]/Trace Scatterplots/m1_y18alcohol.gph", replace
scatter y18_smoking_mean iter, c(1)
graph save "Graph" "[pathname]/Trace Scatterplots/m1_y18smoking.gph", replace
scatter y18_druguse_mean iter, c(1)
graph save "Graph" "[pathname]/Trace Scatterplots/m1_y18druguse.gph", replace
scatter y18_sleepdur_mean iter, c(1)
graph save "Graph" "[pathname]/Trace Scatterplots/m1_y18sleepdur.gph", replace
scatter ethnicity_mean iter, c(1)
graph save "Graph" "[pathname]/Trace Scatterplots/m1_ethnicity.gph", replace
scatter meduc_mean iter, c(1)
graph save "Graph" "[pathname]/Trace Scatterplots/m1_meduc.gph", replace
scatter y11_alcohol_mean iter, c(1)
graph save "Graph" "[pathname]/Trace Scatterplots/m1_y11alcohol.gph", replace
scatter y11_smoking_mean iter, c(1)
graph save "Graph" "[pathname]/Trace Scatterplots/m1_y11smoking.gph", replace
scatter y11_sleepdur_mean iter, c(1)
graph save "Graph" "[pathname]/Trace Scatterplots/m1_y11sleepdur.gph", replace
scatter y15_alcohol_mean iter, c(1)
graph save "Graph" "[pathname]/Trace Scatterplots/m1_y15alcohol.gph", replace
scatter y15_smoking_mean iter, c(1)
graph save "Graph" "[pathname]/Trace Scatterplots/m1_y15smoking.gph", replace
scatter y15_druguse_mean iter, c(1)
graph save "Graph" "[pathname]/Trace Scatterplots/m1_y15druguse.gph", replace
scatter y15_sleepdur_mean iter, c(1)
graph save "Graph" "[pathname]/Trace Scatterplots/m1_y15sleepdur.gph", replace
scatter birthweight_mean iter, c(1)
graph save "Graph" "[pathname]/Trace Scatterplots/m1_birthweight.gph", replace
scatter tctspc6_mean iter, c(1)
graph save "Graph" "[pathname]/Trace Scatterplots/m1_y6ctspc.gph", replace
scatter tctspc11_mean iter, c(1)
graph save "Graph" "[pathname]/Trace Scatterplots/m1_y11ctspc.gph", replace

**********************************************************

* MODEL 2: CTE @ 11y *

use "250324_s2prep_v9_MB.dta", clear
save "050424_miM2_MB.dta", replace 

xtset, clear
mi set flong
mi stset, clear
mi register regular sex msmoking malcohol fincome birthday
mi register imputed y18_alcohol y18_smoking y18_druguse y18_sleepdur y11_cte ethnicity meduc y11_alcohol y11_smoking y11_sleepdur y15_alcohol y15_smoking y15_druguse y15_sleepdur birthweight tctspc6 tctspc11 

//dry run model
local auxiliary "birthweight tctspc6 tctspc11"
local sleep "y18_sleepdur y11_sleepdur y15_sleepdur"
local y18hrbs "i.y18_alcohol i.y18_smoking i.y18_druguse"
local y11hrbs "i.y11_alcohol i.y11_smoking"
local y15hrbs "i.y15_alcohol i.y15_smoking i.y15_druguse"
 
set more off
mi impute chained ///
(pmm, knn(10) omit(`y11hrbs' y11_sleepdur `y15hrbs' y15_sleepdur birthweight)) y11_cte ///
(logit, omit(i.y11_smoking `sleep' `auxiliary')) y18_alcohol ///
(logit, omit(i.y11_alcohol `sleep' `auxiliary')) y18_smoking ///
(logit, omit(i.y11_alcohol `sleep' `auxiliary')) y18_druguse ///
(pmm, knn(10) omit(`y18hrbs' `y11hrbs' `y15hrbs' `auxiliary')) y18_sleepdur ///
(logit, omit(`y11hrbs' y11_sleepdur `y15hrbs' y15_sleepdur `auxiliary')) ethnicity ///
(pmm, knn(10) omit(`y11hrbs' y11_sleepdur `y15hrbs' y15_sleepdur tctspc6 tctspc11)) meduc ///
(logit, omit(i.y18_druguse y11_cte i.ethnicity meduc `sleep' `auxiliary')) y11_alcohol ///
(logit, omit(i.y18_alcohol y11_cte meduc i.y15_alcohol i.y15_smoking i.y15_druguse `sleep' birthweight i.malcohol)) y11_smoking ///
(pmm, knn(10) omit(`y18hrbs' y11_cte i.ethnicity meduc i.y11_smoking `y15hrbs' y15_sleepdur `auxiliary')) y11_sleepdur ///
(logit, omit(y11_cte i.ethnicity meduc i.y11_smoking `sleep' `auxiliary')) y15_alcohol ///
(logit, omit(y11_cte i.ethnicity i.y11_smoking `sleep' `auxiliary')) y15_smoking ///
(logit, omit(y11_cte i.ethnicity meduc `y11hrbs' `sleep' `auxiliary')) y15_druguse ///
(pmm, knn(10) omit(i.y18_smoking i.y18_druguse y11_cte i.ethnicity `y11hrbs' y11_sleepdur i.y15_druguse `auxiliary')) y15_sleepdur ///
(pmm, knn(10) omit(`y18hrbs' y11_cte i.ethnicity `y11hrbs' `y15hrbs' tctspc6 tctspc11 `sleep')) birthweight ///
(pmm, knn(10) omit(`y18hrbs' i.ethnicity meduc `y11hrbs' `y15hrbs' birthweight `sleep')) tctspc6 ///
(pmm, knn(10) omit(`y18hrbs' `y11hrbs' `y15hrbs' birthweight `sleep')) tctspc11 ///
	= i.sex i.msmoking i.malcohol fincome birthday, dryrun
	
//convergence checks
regress y11_cte meduc i.ethnicity tctspc11 tctspc6 i.y18_smoking i.y18_druguse i.y18_alcohol y18_sleepdur i.sex i.msmoking i.malcohol fincome birthday if _mi_m==0
logistic y18_alcohol meduc i.ethnicity y11_cte i.y11_alcohol i.y18_smoking i.y18_druguse i.y15_smoking i.y15_alcohol i.y15_druguse i.sex i.msmoking i.malcohol fincome birthday if _mi_m==0
logistic y18_smoking meduc i.ethnicity y11_cte i.y11_smoking i.y18_druguse i.y18_alcohol i.y15_smoking i.y15_alcohol i.y15_druguse i.sex i.msmoking i.malcohol fincome birthday if _mi_m==0
logistic y18_druguse meduc i.ethnicity y11_cte i.y11_smoking i.y18_smoking i.y18_alcohol i.y15_smoking i.y15_alcohol i.y15_druguse i.sex i.msmoking i.malcohol fincome birthday if _mi_m==0
regress y18_sleepdur meduc i.ethnicity y11_cte y11_sleepdur y15_sleepdur i.sex i.msmoking i.malcohol fincome birthday if _mi_m==0
*no abnormally large SEs

//m=10
local auxiliary "birthweight tctspc6 tctspc11"
local sleep "y18_sleepdur y11_sleepdur y15_sleepdur"
local y18hrbs "i.y18_alcohol i.y18_smoking i.y18_druguse"
local y11hrbs "i.y11_alcohol i.y11_smoking"
local y15hrbs "i.y15_alcohol i.y15_smoking i.y15_druguse"
 
set more off
mi impute chained ///
(pmm, knn(10) omit(`y11hrbs' y11_sleepdur `y15hrbs' y15_sleepdur birthweight)) y11_cte ///
(logit, omit(i.y11_smoking `sleep' `auxiliary')) y18_alcohol ///
(logit, omit(i.y11_alcohol `sleep' `auxiliary')) y18_smoking ///
(logit, omit(i.y11_alcohol `sleep' `auxiliary')) y18_druguse ///
(pmm, knn(10) omit(`y18hrbs' `y11hrbs' `y15hrbs' `auxiliary')) y18_sleepdur ///
(logit, omit(`y11hrbs' y11_sleepdur `y15hrbs' y15_sleepdur `auxiliary')) ethnicity ///
(pmm, knn(10) omit(`y11hrbs' y11_sleepdur `y15hrbs' y15_sleepdur tctspc6 tctspc11)) meduc ///
(logit, omit(i.y18_druguse y11_cte i.ethnicity meduc `sleep' `auxiliary')) y11_alcohol ///
(logit, omit(i.y18_alcohol y11_cte meduc i.y15_alcohol i.y15_smoking i.y15_druguse `sleep' birthweight i.malcohol)) y11_smoking ///
(pmm, knn(10) omit(`y18hrbs' y11_cte i.ethnicity meduc i.y11_smoking `y15hrbs' y15_sleepdur `auxiliary')) y11_sleepdur ///
(logit, omit(y11_cte i.ethnicity meduc i.y11_smoking `sleep' `auxiliary')) y15_alcohol ///
(logit, omit(y11_cte i.ethnicity i.y11_smoking `sleep' `auxiliary')) y15_smoking ///
(logit, omit(y11_cte i.ethnicity meduc `y11hrbs' `sleep' `auxiliary')) y15_druguse ///
(pmm, knn(10) omit(i.y18_smoking i.y18_druguse y11_cte i.ethnicity `y11hrbs' y11_sleepdur i.y15_druguse `auxiliary')) y15_sleepdur ///
(pmm, knn(10) omit(`y18hrbs' y11_cte i.ethnicity `y11hrbs' `y15hrbs' tctspc6 tctspc11 `sleep')) birthweight ///
(pmm, knn(10) omit(`y18hrbs' i.ethnicity meduc `y11hrbs' `y15hrbs' birthweight `sleep')) tctspc6 ///
(pmm, knn(10) omit(`y18hrbs' `y11hrbs' `y15hrbs' birthweight `sleep')) tctspc11 ///
	= i.sex i.msmoking i.malcohol fincome birthday, add(10) rseed(100) by(sex) noisily 
	
//m=50
local auxiliary "birthweight tctspc6 tctspc11"
local sleep "y18_sleepdur y11_sleepdur y15_sleepdur"
local y18hrbs "i.y18_alcohol i.y18_smoking i.y18_druguse"
local y11hrbs "i.y11_alcohol i.y11_smoking"
local y15hrbs "i.y15_alcohol i.y15_smoking i.y15_druguse"
 
set more off
mi impute chained ///
(pmm, knn(10) omit(`y11hrbs' y11_sleepdur `y15hrbs' y15_sleepdur birthweight)) y11_cte ///
(logit, omit(i.y11_smoking `sleep' `auxiliary')) y18_alcohol ///
(logit, omit(i.y11_alcohol `sleep' `auxiliary')) y18_smoking ///
(logit, omit(i.y11_alcohol `sleep' `auxiliary')) y18_druguse ///
(pmm, knn(10) omit(`y18hrbs' `y11hrbs' `y15hrbs' `auxiliary')) y18_sleepdur ///
(logit, omit(`y11hrbs' y11_sleepdur `y15hrbs' y15_sleepdur `auxiliary')) ethnicity ///
(pmm, knn(10) omit(`y11hrbs' y11_sleepdur `y15hrbs' y15_sleepdur tctspc6 tctspc11)) meduc ///
(logit, omit(i.y18_druguse y11_cte i.ethnicity meduc `sleep' `auxiliary')) y11_alcohol ///
(logit, omit(i.y18_alcohol y11_cte meduc i.y15_alcohol i.y15_smoking i.y15_druguse `sleep' birthweight i.malcohol)) y11_smoking ///
(pmm, knn(10) omit(`y18hrbs' y11_cte i.ethnicity meduc i.y11_smoking `y15hrbs' y15_sleepdur `auxiliary')) y11_sleepdur ///
(logit, omit(y11_cte i.ethnicity meduc i.y11_smoking `sleep' `auxiliary')) y15_alcohol ///
(logit, omit(y11_cte i.ethnicity i.y11_smoking `sleep' `auxiliary')) y15_smoking ///
(logit, omit(y11_cte i.ethnicity meduc `y11hrbs' `sleep' `auxiliary')) y15_druguse ///
(pmm, knn(10) omit(i.y18_smoking i.y18_druguse y11_cte i.ethnicity `y11hrbs' y11_sleepdur i.y15_druguse `auxiliary')) y15_sleepdur ///
(pmm, knn(10) omit(`y18hrbs' y11_cte i.ethnicity `y11hrbs' `y15hrbs' tctspc6 tctspc11 `sleep')) birthweight ///
(pmm, knn(10) omit(`y18hrbs' i.ethnicity meduc `y11hrbs' `y15hrbs' birthweight `sleep')) tctspc6 ///
(pmm, knn(10) omit(`y18hrbs' `y11hrbs' `y15hrbs' birthweight `sleep')) tctspc11 ///
	= i.sex i.msmoking i.malcohol fincome birthday, add(50) rseed(100) by(sex) noisily 
	
//DATA EXPLORATION
log using "[pathname]/040424_miM2_dataexplore.smcl"
summarize _mi_id _mi_miss _mi_m

*compare mean and summary stats for the original data and compare it with imputed data
tab _mi_m, summarize(y11_cte)
tab _mi_m, summarize(y18_alcohol)
tab _mi_m, summarize(y18_smoking)
tab _mi_m, summarize(y18_druguse)
tab _mi_m, summarize(y18_sleepdur)
tab _mi_m, summarize(ethnicity) 
tab _mi_m, summarize(meduc) 
tab _mi_m, summarize(y11_alcohol)
tab _mi_m, summarize(y11_smoking)
tab _mi_m, summarize(y11_sleepdur)
tab _mi_m, summarize(y15_alcohol)
tab _mi_m, summarize(y15_smoking)
tab _mi_m, summarize(y15_druguse)
tab _mi_m, summarize(y15_sleepdur)
tab _mi_m, summarize(birthweight)
tab _mi_m, summarize(tctspc6)
tab _mi_m, summarize(tctspc11)

*Monte Carlo Error - check whether the Monte Carlo error of B is approximately 10 per cent of its standard error (so one value below coefficient vs SE of the coefficient)
mi estimate, mcerror: logistic y18_alcohol y11_cte
mi estimate, mcerror: logistic y18_smoking y11_cte
mi estimate, mcerror: logistic y18_druguse y11_cte
mi estimate, mcerror: regress y18_sleepdur y11_cte
mi estimate, mcerror: logistic y18_alcohol y11_cte sex ethnicity msmoking malcohol meduc fincome birthday
mi estimate, mcerror: logistic y18_smoking y11_cte sex ethnicity msmoking malcohol meduc fincome birthday
mi estimate, mcerror: logistic y18_druguse y11_cte sex ethnicity msmoking malcohol meduc fincome birthday
mi estimate, mcerror: regress y18_sleepdur y11_cte sex ethnicity msmoking malcohol meduc fincome birthday

//IMPUTATION CHECKS
*checking imputation process to see if need more cycles of chained equations algorithm
use "040424_miM2_MB", clear
save "040424_miM2_trace_MB", replace 

//note: savetrace cannot be combined with the by() command
local auxiliary "birthweight tctspc6 tctspc11"
local sleep "y18_sleepdur y11_sleepdur y15_sleepdur"
local y18hrbs "i.y18_alcohol i.y18_smoking i.y18_druguse"
local y11hrbs "i.y11_alcohol i.y11_smoking"
local y15hrbs "i.y15_alcohol i.y15_smoking i.y15_druguse"
 
set more off
mi impute chained ///
(pmm, knn(10) omit(`y11hrbs' y11_sleepdur `y15hrbs' y15_sleepdur birthweight)) y11_cte ///
(logit, omit(i.y11_smoking `sleep' `auxiliary')) y18_alcohol ///
(logit, omit(i.y11_alcohol `sleep' `auxiliary')) y18_smoking ///
(logit, omit(i.y11_alcohol `sleep' `auxiliary')) y18_druguse ///
(pmm, knn(10) omit(`y18hrbs' `y11hrbs' `y15hrbs' `auxiliary')) y18_sleepdur ///
(logit, omit(`y11hrbs' y11_sleepdur `y15hrbs' y15_sleepdur `auxiliary')) ethnicity ///
(pmm, knn(10) omit(`y11hrbs' y11_sleepdur `y15hrbs' y15_sleepdur tctspc6 tctspc11)) meduc ///
(logit, omit(i.y18_druguse y11_cte i.ethnicity meduc `sleep' `auxiliary')) y11_alcohol ///
(logit, omit(i.y18_alcohol y11_cte meduc i.y15_alcohol i.y15_smoking i.y15_druguse `sleep' birthweight i.malcohol)) y11_smoking ///
(pmm, knn(10) omit(`y18hrbs' y11_cte i.ethnicity meduc i.y11_smoking `y15hrbs' y15_sleepdur `auxiliary')) y11_sleepdur ///
(logit, omit(y11_cte i.ethnicity meduc i.y11_smoking `sleep' `auxiliary')) y15_alcohol ///
(logit, omit(y11_cte i.ethnicity i.y11_smoking `sleep' `auxiliary')) y15_smoking ///
(logit, omit(y11_cte i.ethnicity meduc `y11hrbs' `sleep' `auxiliary')) y15_druguse ///
(pmm, knn(10) omit(i.y18_smoking i.y18_druguse y11_cte i.ethnicity `y11hrbs' y11_sleepdur i.y15_druguse `auxiliary')) y15_sleepdur ///
(pmm, knn(10) omit(`y18hrbs' y11_cte i.ethnicity `y11hrbs' `y15hrbs' tctspc6 tctspc11 `sleep')) birthweight ///
(pmm, knn(10) omit(`y18hrbs' i.ethnicity meduc `y11hrbs' `y15hrbs' birthweight `sleep')) tctspc6 ///
(pmm, knn(10) omit(`y18hrbs' `y11hrbs' `y15hrbs' birthweight `sleep')) tctspc11 ///
	= i.sex i.msmoking i.malcohol fincome birthday, rseed(100) chainonly burnin(100) savetrace(m2_imptrace)
	
//check scatterplots for convergence
use m2_imptrace

scatter y11_cte_mean iter, c(1)
graph save "Graph" "[pathname]/Trace Scatterplots/m2_y18cte.gph", replace
scatter y18_alcohol_mean iter, c(1)
graph save "Graph" "[pathname]/Trace Scatterplots/m2_y18alcohol.gph", replace
scatter y18_smoking_mean iter, c(1)
graph save "Graph" "[pathname]/Trace Scatterplots/m2_y18smoking.gph", replace
scatter y18_druguse_mean iter, c(1)
graph save "Graph" "[pathname]/Trace Scatterplots/m2_y18druguse.gph", replace
scatter y18_sleepdur_mean iter, c(1)
graph save "Graph" "[pathname]/Trace Scatterplots/m2_y18sleep.gph", replace
scatter ethnicity_mean iter, c(1)
graph save "Graph" "[pathname]/Trace Scatterplots/m2_ethnicity.gph", replace
scatter meduc_mean iter, c(1)
graph save "Graph" "[pathname]/Trace Scatterplots/m2_meduc.gph", replace
scatter y11_alcohol_mean iter, c(1)
graph save "Graph" "[pathname]/Trace Scatterplots/m2_y11alcohol.gph", replace
scatter y11_smoking_mean iter, c(1)
graph save "Graph" "[pathname]/Trace Scatterplots/m2_y11smoking.gph", replace
scatter y11_sleepdur_mean iter, c(1)
graph save "Graph" "[pathname]/Trace Scatterplots/m2_y11sleep.gph", replace
scatter y15_alcohol_mean iter, c(1)
graph save "Graph" "[pathname]/Trace Scatterplots/m2_y15alcohol.gph", replace
scatter y15_smoking_mean iter, c(1)
graph save "Graph" "[pathname]/Trace Scatterplots/m2_y15smoking.gph", replace
scatter y15_druguse_mean iter, c(1)
graph save "Graph" "[pathname]/Trace Scatterplots/m2_y15druguse.gph", replace
scatter y15_sleepdur_mean iter, c(1)
graph save "Graph" "[pathname]/Trace Scatterplots/m2_y15sleep.gph", replace
scatter birthweight_mean iter, c(1)
graph save "Graph" "[pathname]/Trace Scatterplots/m2_birthweight.gph", replace
scatter tctspc6_mean iter, c(1)
graph save "Graph" "[pathname]/Trace Scatterplots/m2_y6ctspc.gph", replace
scatter tctspc11_mean iter, c(1)
graph save "Graph" "[pathname]/Trace Scatterplots/m2_y11ctspc.gph", replace

**********************************************************

* MODEL 3: CTE @ 15y *

use "250324_s2prep_v9_MB.dta", clear
save "050424_miM3_MB.dta", replace 

xtset, clear
mi set flong
mi stset, clear
mi register regular sex msmoking malcohol fincome birthday
mi register imputed y18_alcohol y18_smoking y18_druguse y18_sleepdur y15_cte ethnicity meduc y11_alcohol y11_smoking y11_sleepdur y15_alcohol y15_smoking y15_druguse y15_sleepdur birthweight tctspc6 tctspc11 

//dry run model
local auxiliary "birthweight tctspc6 tctspc11"
local sleep "y18_sleepdur y11_sleepdur y15_sleepdur"
local y18hrbs "i.y18_alcohol i.y18_smoking i.y18_druguse"
local y11hrbs "i.y11_alcohol i.y11_smoking"
local y15hrbs "i.y15_alcohol i.y15_smoking i.y15_druguse"
 
set more off
mi impute chained ///
(pmm, knn(10) omit(`y11hrbs' y11_sleepdur `y15hrbs' y15_sleepdur birthweight)) y15_cte ///
(logit, omit(i.y11_smoking `sleep' `auxiliary')) y18_alcohol ///
(logit, omit(i.y11_alcohol `sleep' `auxiliary')) y18_smoking ///
(logit, omit(i.y11_alcohol `sleep' `auxiliary')) y18_druguse ///
(pmm, knn(10) omit(`y18hrbs' `y11hrbs' `y15hrbs' `auxiliary')) y18_sleepdur ///
(logit, omit(`y11hrbs' y11_sleepdur `y15hrbs' y15_sleepdur `auxiliary')) ethnicity ///
(pmm, knn(10) omit(`y11hrbs' y11_sleepdur `y15hrbs' y15_sleepdur tctspc6 tctspc11)) meduc ///
(logit, omit(i.y18_druguse y15_cte i.ethnicity meduc `sleep' `auxiliary')) y11_alcohol ///
(logit, omit(i.y18_alcohol y15_cte meduc i.y15_alcohol i.y15_smoking i.y15_druguse `sleep' birthweight i.malcohol)) y11_smoking ///
(pmm, knn(10) omit(`y18hrbs' y15_cte i.ethnicity meduc i.y11_smoking `y15hrbs' y15_sleepdur `auxiliary')) y11_sleepdur ///
(logit, omit(y15_cte i.ethnicity meduc i.y11_smoking `sleep' `auxiliary')) y15_alcohol ///
(logit, omit(y15_cte i.ethnicity i.y11_smoking `sleep' `auxiliary')) y15_smoking ///
(logit, omit(y15_cte i.ethnicity meduc `y11hrbs' `sleep' `auxiliary')) y15_druguse ///
(pmm, knn(10) omit(i.y18_smoking i.y18_druguse y15_cte i.ethnicity `y11hrbs' y11_sleepdur i.y15_druguse `auxiliary')) y15_sleepdur ///
(pmm, knn(10) omit(`y18hrbs' y15_cte i.ethnicity `y11hrbs' `y15hrbs' tctspc6 tctspc11 `sleep')) birthweight ///
(pmm, knn(10) omit(`y18hrbs' i.ethnicity meduc `y11hrbs' `y15hrbs' birthweight `sleep')) tctspc6 ///
(pmm, knn(10) omit(`y18hrbs' `y11hrbs' `y15hrbs' birthweight `sleep')) tctspc11 ///
	= i.sex i.msmoking i.malcohol fincome birthday, dryrun
	
//convergence checks
regress y15_cte meduc i.ethnicity tctspc11 tctspc6 i.y18_smoking i.y18_druguse i.y18_alcohol y18_sleepdur i.sex i.msmoking i.malcohol fincome birthday if _mi_m==0
logistic y18_alcohol meduc i.ethnicity y15_cte i.y11_alcohol i.y18_smoking i.y18_druguse i.y15_smoking i.y15_alcohol i.y15_druguse i.sex i.msmoking i.malcohol fincome birthday if _mi_m==0
logistic y18_smoking meduc i.ethnicity y15_cte i.y11_smoking i.y18_druguse i.y18_alcohol i.y15_smoking i.y15_alcohol i.y15_druguse i.sex i.msmoking i.malcohol fincome birthday if _mi_m==0
logistic y18_druguse meduc i.ethnicity y15_cte i.y11_smoking i.y18_smoking i.y18_alcohol i.y15_smoking i.y15_alcohol i.y15_druguse i.sex i.msmoking i.malcohol fincome birthday if _mi_m==0
regress y18_sleepdur meduc i.ethnicity y15_cte y11_sleepdur y15_sleepdur i.sex i.msmoking i.malcohol fincome birthday if _mi_m==0
*no abnormally large SEs

//m=10
local auxiliary "birthweight tctspc6 tctspc11"
local sleep "y18_sleepdur y11_sleepdur y15_sleepdur"
local y18hrbs "i.y18_alcohol i.y18_smoking i.y18_druguse"
local y11hrbs "i.y11_alcohol i.y11_smoking"
local y15hrbs "i.y15_alcohol i.y15_smoking i.y15_druguse"
 
set more off
mi impute chained ///
(pmm, knn(10) omit(`y11hrbs' y11_sleepdur `y15hrbs' y15_sleepdur birthweight)) y15_cte ///
(logit, omit(i.y11_smoking `sleep' `auxiliary')) y18_alcohol ///
(logit, omit(i.y11_alcohol `sleep' `auxiliary')) y18_smoking ///
(logit, omit(i.y11_alcohol `sleep' `auxiliary')) y18_druguse ///
(pmm, knn(10) omit(`y18hrbs' `y11hrbs' `y15hrbs' `auxiliary')) y18_sleepdur ///
(logit, omit(`y11hrbs' y11_sleepdur `y15hrbs' y15_sleepdur `auxiliary')) ethnicity ///
(pmm, knn(10) omit(`y11hrbs' y11_sleepdur `y15hrbs' y15_sleepdur tctspc6 tctspc11)) meduc ///
(logit, omit(i.y18_druguse y15_cte i.ethnicity meduc `sleep' `auxiliary')) y11_alcohol ///
(logit, omit(i.y18_alcohol y15_cte meduc i.y15_alcohol i.y15_smoking i.y15_druguse `sleep' birthweight i.malcohol)) y11_smoking ///
(pmm, knn(10) omit(`y18hrbs' y15_cte i.ethnicity meduc i.y11_smoking `y15hrbs' y15_sleepdur `auxiliary')) y11_sleepdur ///
(logit, omit(y15_cte i.ethnicity meduc i.y11_smoking `sleep' `auxiliary')) y15_alcohol ///
(logit, omit(y15_cte i.ethnicity i.y11_smoking `sleep' `auxiliary')) y15_smoking ///
(logit, omit(y15_cte i.ethnicity meduc `y11hrbs' `sleep' `auxiliary')) y15_druguse ///
(pmm, knn(10) omit(i.y18_smoking i.y18_druguse y15_cte i.ethnicity `y11hrbs' y11_sleepdur i.y15_druguse `auxiliary')) y15_sleepdur ///
(pmm, knn(10) omit(`y18hrbs' y15_cte i.ethnicity `y11hrbs' `y15hrbs' tctspc6 tctspc11 `sleep')) birthweight ///
(pmm, knn(10) omit(`y18hrbs' i.ethnicity meduc `y11hrbs' `y15hrbs' birthweight `sleep')) tctspc6 ///
(pmm, knn(10) omit(`y18hrbs' `y11hrbs' `y15hrbs' birthweight `sleep')) tctspc11 ///
	= i.sex i.msmoking i.malcohol fincome birthday, add(10) rseed(100) by(sex) noisily 

//m=50
local auxiliary "birthweight tctspc6 tctspc11"
local sleep "y18_sleepdur y11_sleepdur y15_sleepdur"
local y18hrbs "i.y18_alcohol i.y18_smoking i.y18_druguse"
local y11hrbs "i.y11_alcohol i.y11_smoking"
local y15hrbs "i.y15_alcohol i.y15_smoking i.y15_druguse"
 
set more off
mi impute chained ///
(pmm, knn(10) omit(`y11hrbs' y11_sleepdur `y15hrbs' y15_sleepdur birthweight)) y15_cte ///
(logit, omit(i.y11_smoking `sleep' `auxiliary')) y18_alcohol ///
(logit, omit(i.y11_alcohol `sleep' `auxiliary')) y18_smoking ///
(logit, omit(i.y11_alcohol `sleep' `auxiliary')) y18_druguse ///
(pmm, knn(10) omit(`y18hrbs' `y11hrbs' `y15hrbs' `auxiliary')) y18_sleepdur ///
(logit, omit(`y11hrbs' y11_sleepdur `y15hrbs' y15_sleepdur `auxiliary')) ethnicity ///
(pmm, knn(10) omit(`y11hrbs' y11_sleepdur `y15hrbs' y15_sleepdur tctspc6 tctspc11)) meduc ///
(logit, omit(i.y18_druguse y15_cte i.ethnicity meduc `sleep' `auxiliary')) y11_alcohol ///
(logit, omit(i.y18_alcohol y15_cte meduc i.y15_alcohol i.y15_smoking i.y15_druguse `sleep' birthweight i.malcohol)) y11_smoking ///
(pmm, knn(10) omit(`y18hrbs' y15_cte i.ethnicity meduc i.y11_smoking `y15hrbs' y15_sleepdur `auxiliary')) y11_sleepdur ///
(logit, omit(y15_cte i.ethnicity meduc i.y11_smoking `sleep' `auxiliary')) y15_alcohol ///
(logit, omit(y15_cte i.ethnicity i.y11_smoking `sleep' `auxiliary')) y15_smoking ///
(logit, omit(y15_cte i.ethnicity meduc `y11hrbs' `sleep' `auxiliary')) y15_druguse ///
(pmm, knn(10) omit(i.y18_smoking i.y18_druguse y15_cte i.ethnicity `y11hrbs' y11_sleepdur i.y15_druguse `auxiliary')) y15_sleepdur ///
(pmm, knn(10) omit(`y18hrbs' y15_cte i.ethnicity `y11hrbs' `y15hrbs' tctspc6 tctspc11 `sleep')) birthweight ///
(pmm, knn(10) omit(`y18hrbs' i.ethnicity meduc `y11hrbs' `y15hrbs' birthweight `sleep')) tctspc6 ///
(pmm, knn(10) omit(`y18hrbs' `y11hrbs' `y15hrbs' birthweight `sleep')) tctspc11 ///
	= i.sex i.msmoking i.malcohol fincome birthday, add(50) rseed(100) by(sex) noisily 
	
//DATA EXPLORATION
log using "[pathname]/050424_miM3_dataexplore.smcl"
summarize _mi_id _mi_miss _mi_m

*compare mean and summary stats for the original data and compare it with imputed data
tab _mi_m, summarize(y15_cte)
tab _mi_m, summarize(y18_alcohol)
tab _mi_m, summarize(y18_smoking)
tab _mi_m, summarize(y18_druguse)
tab _mi_m, summarize(y18_sleepdur)
tab _mi_m, summarize(ethnicity) 
tab _mi_m, summarize(meduc) 
tab _mi_m, summarize(y11_alcohol)
tab _mi_m, summarize(y11_smoking)
tab _mi_m, summarize(y11_sleepdur)
tab _mi_m, summarize(y15_alcohol)
tab _mi_m, summarize(y15_smoking)
tab _mi_m, summarize(y15_druguse)
tab _mi_m, summarize(y15_sleepdur)
tab _mi_m, summarize(birthweight)
tab _mi_m, summarize(tctspc6)
tab _mi_m, summarize(tctspc11)

*Monte Carlo Error - check whether the Monte Carlo error of B is approximately 10 per cent of its standard error (so one value below coefficient vs SE of the coefficient)
mi estimate, mcerror: logistic y18_alcohol y15_cte
mi estimate, mcerror: logistic y18_smoking y15_cte
mi estimate, mcerror: logistic y18_druguse y15_cte
mi estimate, mcerror: regress y18_sleepdur y15_cte
mi estimate, mcerror: logistic y18_alcohol y15_cte sex ethnicity msmoking malcohol meduc fincome birthday
mi estimate, mcerror: logistic y18_smoking y15_cte sex ethnicity msmoking malcohol meduc fincome birthday
mi estimate, mcerror: logistic y18_druguse y15_cte sex ethnicity msmoking malcohol meduc fincome birthday
mi estimate, mcerror: regress y18_sleepdur y15_cte sex ethnicity msmoking malcohol meduc fincome birthday

//IMPUTATION CHECKS
*checking imputation process to see if need more cycles of chained equations algorithm
use "050424_miM3_MB", clear
save "050424_miM3_trace_MB", replace 

//note: savetrace cannot be combined with the by() command
local auxiliary "birthweight tctspc6 tctspc11"
local sleep "y18_sleepdur y11_sleepdur y15_sleepdur"
local y18hrbs "i.y18_alcohol i.y18_smoking i.y18_druguse"
local y11hrbs "i.y11_alcohol i.y11_smoking"
local y15hrbs "i.y15_alcohol i.y15_smoking i.y15_druguse"
 
set more off
mi impute chained ///
(pmm, knn(10) omit(`y11hrbs' y11_sleepdur `y15hrbs' y15_sleepdur birthweight)) y15_cte ///
(logit, omit(i.y11_smoking `sleep' `auxiliary')) y18_alcohol ///
(logit, omit(i.y11_alcohol `sleep' `auxiliary')) y18_smoking ///
(logit, omit(i.y11_alcohol `sleep' `auxiliary')) y18_druguse ///
(pmm, knn(10) omit(`y18hrbs' `y11hrbs' `y15hrbs' `auxiliary')) y18_sleepdur ///
(logit, omit(`y11hrbs' y11_sleepdur `y15hrbs' y15_sleepdur `auxiliary')) ethnicity ///
(pmm, knn(10) omit(`y11hrbs' y11_sleepdur `y15hrbs' y15_sleepdur tctspc6 tctspc11)) meduc ///
(logit, omit(i.y18_druguse y15_cte i.ethnicity meduc `sleep' `auxiliary')) y11_alcohol ///
(logit, omit(i.y18_alcohol y15_cte meduc i.y15_alcohol i.y15_smoking i.y15_druguse `sleep' birthweight i.malcohol)) y11_smoking ///
(pmm, knn(10) omit(`y18hrbs' y15_cte i.ethnicity meduc i.y11_smoking `y15hrbs' y15_sleepdur `auxiliary')) y11_sleepdur ///
(logit, omit(y15_cte i.ethnicity meduc i.y11_smoking `sleep' `auxiliary')) y15_alcohol ///
(logit, omit(y15_cte i.ethnicity i.y11_smoking `sleep' `auxiliary')) y15_smoking ///
(logit, omit(y15_cte i.ethnicity meduc `y11hrbs' `sleep' `auxiliary')) y15_druguse ///
(pmm, knn(10) omit(i.y18_smoking i.y18_druguse y15_cte i.ethnicity `y11hrbs' y11_sleepdur i.y15_druguse `auxiliary')) y15_sleepdur ///
(pmm, knn(10) omit(`y18hrbs' y15_cte i.ethnicity `y11hrbs' `y15hrbs' tctspc6 tctspc11 `sleep')) birthweight ///
(pmm, knn(10) omit(`y18hrbs' i.ethnicity meduc `y11hrbs' `y15hrbs' birthweight `sleep')) tctspc6 ///
(pmm, knn(10) omit(`y18hrbs' `y11hrbs' `y15hrbs' birthweight `sleep')) tctspc11 ///
	= i.sex i.msmoking i.malcohol fincome birthday, rseed(100) chainonly burnin(100) savetrace(m3_imptrace)
	
//check scatterplots for convergence
use m3_imptrace

scatter y15_cte_mean iter, c(1)
graph save "Graph" "[pathname]/Trace Scatterplots/m3_y15cte.gph", replace
scatter y18_alcohol_mean iter, c(1)
graph save "Graph" "[pathname]/Trace Scatterplots/m3_y18alcohol.gph", replace
scatter y18_smoking_mean iter, c(1)
graph save "Graph" "[pathname]/Trace Scatterplots/m3_y18smoking.gph", replace
scatter y18_druguse_mean iter, c(1)
graph save "Graph" "[pathname]/Trace Scatterplots/m3_y18druguse.gph", replace
scatter y18_sleepdur_mean iter, c(1)
graph save "Graph" "[pathname]/Trace Scatterplots/m3_y18sleep.gph", replace
scatter ethnicity_mean iter, c(1)
graph save "Graph" "[pathname]/Trace Scatterplots/m3_ethnicity.gph", replace
scatter meduc_mean iter, c(1)
graph save "Graph" "[pathname]/Trace Scatterplots/m3_meduc.gph", replace
scatter y11_alcohol_mean iter, c(1)
graph save "Graph" "[pathname]/Trace Scatterplots/m3_y11alcohol.gph", replace
scatter y11_smoking_mean iter, c(1)
graph save "Graph" "[pathname]/Trace Scatterplots/m3_y11smoking.gph", replace
scatter y11_sleepdur_mean iter, c(1)
graph save "Graph" "[pathname]/Trace Scatterplots/m3_y11sleep.gph", replace
scatter y15_alcohol_mean iter, c(1)
graph save "Graph" "[pathname]/Trace Scatterplots/m3_y15alcohol.gph", replace
scatter y15_smoking_mean iter, c(1)
graph save "Graph" "[pathname]/Trace Scatterplots/m3_y15smoking.gph", replace
scatter y15_druguse_mean iter, c(1)
graph save "Graph" "[pathname]/Trace Scatterplots/m3_y15druguse.gph", replace
scatter y15_sleepdur_mean iter, c(1)
graph save "Graph" "[pathname]/Trace Scatterplots/m3_y15sleep.gph", replace
scatter birthweight_mean iter, c(1)
graph save "Graph" "[pathname]/Trace Scatterplots/m3_birthweight.gph", replace
scatter tctspc6_mean iter, c(1)
graph save "Graph" "[pathname]/Trace Scatterplots/m3_y6ctspc.gph", replace
scatter tctspc11_mean iter, c(1)
graph save "Graph" "[pathname]/Trace Scatterplots/m3_y11ctspc.gph", replace
	
**********************************************************

* MODEL 4: BINARY TRAUMA @ 18y *

use "250324_s2prep_v9_MB.dta", clear
save "080424_miM4_MB.dta", replace 

xtset, clear
mi set flong
mi stset, clear
mi register regular sex msmoking malcohol fincome birthday
mi register imputed y18_alcohol y18_smoking y18_druguse y18_sleepdur y18_alltrauma ethnicity meduc y11_alcohol y11_smoking y11_sleepdur y15_alcohol y15_smoking y15_druguse y15_sleepdur birthweight tctspc6 tctspc11 

//dry run model
local auxiliary "birthweight tctspc6 tctspc11"
local sleep "y18_sleepdur y11_sleepdur y15_sleepdur"
local y18hrbs "i.y18_alcohol i.y18_smoking i.y18_druguse"
local y11hrbs "i.y11_alcohol i.y11_smoking"
local y15hrbs "i.y15_alcohol i.y15_smoking i.y15_druguse"
 
set more off
mi impute chained ///
(logit, omit(`y11hrbs' y11_sleepdur `y15hrbs' y15_sleepdur birthweight)) y18_alltrauma ///
(logit, omit(i.y11_smoking `sleep' `auxiliary')) y18_alcohol ///
(logit, omit(i.y11_alcohol `sleep' `auxiliary')) y18_smoking ///
(logit, omit(i.y11_alcohol `sleep' `auxiliary')) y18_druguse ///
(pmm, knn(10) omit(`y18hrbs' `y11hrbs' `y15hrbs' `auxiliary')) y18_sleepdur ///
(logit, omit(`y11hrbs' y11_sleepdur `y15hrbs' y15_sleepdur `auxiliary')) ethnicity ///
(pmm, knn(10) omit(`y11hrbs' y11_sleepdur `y15hrbs' y15_sleepdur tctspc6 tctspc11)) meduc ///
(logit, omit(i.y18_druguse i.y18_alltrauma i.ethnicity meduc `sleep' `auxiliary')) y11_alcohol ///
(logit, omit(i.y18_alcohol i.y18_alltrauma meduc i.y15_alcohol i.y15_smoking i.y15_druguse `sleep' birthweight i.malcohol)) y11_smoking ///
(pmm, knn(10) omit(`y18hrbs' i.y18_alltrauma i.ethnicity meduc i.y11_smoking `y15hrbs' y15_sleepdur `auxiliary')) y11_sleepdur ///
(logit, omit(i.y18_alltrauma i.ethnicity meduc i.y11_smoking `sleep' `auxiliary')) y15_alcohol ///
(logit, omit(i.y18_alltrauma i.ethnicity i.y11_smoking `sleep' `auxiliary')) y15_smoking ///
(logit, omit(i.y18_alltrauma i.ethnicity meduc `y11hrbs' `sleep' `auxiliary')) y15_druguse ///
(pmm, knn(10) omit(i.y18_smoking i.y18_druguse i.y18_alltrauma i.ethnicity `y11hrbs' y11_sleepdur i.y15_druguse `auxiliary')) y15_sleepdur ///
(pmm, knn(10) omit(`y18hrbs' i.y18_alltrauma i.ethnicity `y11hrbs' `y15hrbs' tctspc6 tctspc11 `sleep')) birthweight ///
(pmm, knn(10) omit(`y18hrbs' i.ethnicity meduc `y11hrbs' `y15hrbs' birthweight `sleep')) tctspc6 ///
(pmm, knn(10) omit(`y18hrbs' `y11hrbs' `y15hrbs' birthweight `sleep')) tctspc11 ///
	= i.sex i.msmoking i.malcohol fincome birthday, dryrun
	
//convergence checks
logistic y18_alltrauma meduc i.ethnicity tctspc11 tctspc6 i.y18_smoking i.y18_druguse i.y18_alcohol y18_sleepdur i.sex i.msmoking i.malcohol fincome birthday if _mi_m==0
logistic y18_alcohol meduc i.ethnicity i.y11_alcohol i.y18_smoking i.y18_druguse i.y18_alltrauma i.y15_smoking i.y15_alcohol i.y15_druguse i.sex i.msmoking i.malcohol fincome birthday if _mi_m==0
logistic y18_smoking meduc i.ethnicity i.y11_smoking i.y18_druguse i.y18_alcohol i.y18_alltrauma i.y15_smoking i.y15_alcohol i.y15_druguse i.sex i.msmoking i.malcohol fincome birthday if _mi_m==0
logistic y18_druguse meduc i.ethnicity i.y11_smoking i.y18_smoking i.y18_alcohol i.y18_alltrauma i.y15_smoking i.y15_alcohol i.y15_druguse i.sex i.msmoking i.malcohol fincome birthday if _mi_m==0
regress y18_sleepdur meduc i.ethnicity y11_sleepdur i.y18_alltrauma y15_sleepdur i.sex i.msmoking i.malcohol fincome birthday if _mi_m==0
*no abnormally large SEs

//m=10
local auxiliary "birthweight tctspc6 tctspc11"
local sleep "y18_sleepdur y11_sleepdur y15_sleepdur"
local y18hrbs "i.y18_alcohol i.y18_smoking i.y18_druguse"
local y11hrbs "i.y11_alcohol i.y11_smoking"
local y15hrbs "i.y15_alcohol i.y15_smoking i.y15_druguse"
 
set more off
mi impute chained ///
(logit, omit(`y11hrbs' y11_sleepdur `y15hrbs' y15_sleepdur birthweight)) y18_alltrauma ///
(logit, omit(i.y11_smoking `sleep' `auxiliary')) y18_alcohol ///
(logit, omit(i.y11_alcohol `sleep' `auxiliary')) y18_smoking ///
(logit, omit(i.y11_alcohol `sleep' `auxiliary')) y18_druguse ///
(pmm, knn(10) omit(`y18hrbs' `y11hrbs' `y15hrbs' `auxiliary')) y18_sleepdur ///
(logit, omit(`y11hrbs' y11_sleepdur `y15hrbs' y15_sleepdur `auxiliary')) ethnicity ///
(pmm, knn(10) omit(`y11hrbs' y11_sleepdur `y15hrbs' y15_sleepdur tctspc6 tctspc11)) meduc ///
(logit, omit(i.y18_druguse i.y18_alltrauma i.ethnicity meduc `sleep' `auxiliary')) y11_alcohol ///
(logit, omit(i.y18_alcohol i.y18_alltrauma meduc i.y15_alcohol i.y15_smoking i.y15_druguse `sleep' birthweight i.malcohol)) y11_smoking ///
(pmm, knn(10) omit(`y18hrbs' i.y18_alltrauma i.ethnicity meduc i.y11_smoking `y15hrbs' y15_sleepdur `auxiliary')) y11_sleepdur ///
(logit, omit(i.y18_alltrauma i.ethnicity meduc i.y11_smoking `sleep' `auxiliary')) y15_alcohol ///
(logit, omit(i.y18_alltrauma i.ethnicity i.y11_smoking `sleep' `auxiliary')) y15_smoking ///
(logit, omit(i.y18_alltrauma i.ethnicity meduc `y11hrbs' `sleep' `auxiliary')) y15_druguse ///
(pmm, knn(10) omit(i.y18_smoking i.y18_druguse i.y18_alltrauma i.ethnicity `y11hrbs' y11_sleepdur i.y15_druguse `auxiliary')) y15_sleepdur ///
(pmm, knn(10) omit(`y18hrbs' i.y18_alltrauma i.ethnicity `y11hrbs' `y15hrbs' tctspc6 tctspc11 `sleep')) birthweight ///
(pmm, knn(10) omit(`y18hrbs' i.ethnicity meduc `y11hrbs' `y15hrbs' birthweight `sleep')) tctspc6 ///
(pmm, knn(10) omit(`y18hrbs' `y11hrbs' `y15hrbs' birthweight `sleep')) tctspc11 ///
	= i.sex i.msmoking i.malcohol fincome birthday, add(10) rseed(100) by(sex) noisily 
	
//m=50
local auxiliary "birthweight tctspc6 tctspc11"
local sleep "y18_sleepdur y11_sleepdur y15_sleepdur"
local y18hrbs "i.y18_alcohol i.y18_smoking i.y18_druguse"
local y11hrbs "i.y11_alcohol i.y11_smoking"
local y15hrbs "i.y15_alcohol i.y15_smoking i.y15_druguse"
 
set more off
mi impute chained ///
(logit, omit(`y11hrbs' y11_sleepdur `y15hrbs' y15_sleepdur birthweight)) y18_alltrauma ///
(logit, omit(i.y11_smoking `sleep' `auxiliary')) y18_alcohol ///
(logit, omit(i.y11_alcohol `sleep' `auxiliary')) y18_smoking ///
(logit, omit(i.y11_alcohol `sleep' `auxiliary')) y18_druguse ///
(pmm, knn(10) omit(`y18hrbs' `y11hrbs' `y15hrbs' `auxiliary')) y18_sleepdur ///
(logit, omit(`y11hrbs' y11_sleepdur `y15hrbs' y15_sleepdur `auxiliary')) ethnicity ///
(pmm, knn(10) omit(`y11hrbs' y11_sleepdur `y15hrbs' y15_sleepdur tctspc6 tctspc11)) meduc ///
(logit, omit(i.y18_druguse i.y18_alltrauma i.ethnicity meduc `sleep' `auxiliary')) y11_alcohol ///
(logit, omit(i.y18_alcohol i.y18_alltrauma meduc i.y15_alcohol i.y15_smoking i.y15_druguse `sleep' birthweight i.malcohol)) y11_smoking ///
(pmm, knn(10) omit(`y18hrbs' i.y18_alltrauma i.ethnicity meduc i.y11_smoking `y15hrbs' y15_sleepdur `auxiliary')) y11_sleepdur ///
(logit, omit(i.y18_alltrauma i.ethnicity meduc i.y11_smoking `sleep' `auxiliary')) y15_alcohol ///
(logit, omit(i.y18_alltrauma i.ethnicity i.y11_smoking `sleep' `auxiliary')) y15_smoking ///
(logit, omit(i.y18_alltrauma i.ethnicity meduc `y11hrbs' `sleep' `auxiliary')) y15_druguse ///
(pmm, knn(10) omit(i.y18_smoking i.y18_druguse i.y18_alltrauma i.ethnicity `y11hrbs' y11_sleepdur i.y15_druguse `auxiliary')) y15_sleepdur ///
(pmm, knn(10) omit(`y18hrbs' i.y18_alltrauma i.ethnicity `y11hrbs' `y15hrbs' tctspc6 tctspc11 `sleep')) birthweight ///
(pmm, knn(10) omit(`y18hrbs' i.ethnicity meduc `y11hrbs' `y15hrbs' birthweight `sleep')) tctspc6 ///
(pmm, knn(10) omit(`y18hrbs' `y11hrbs' `y15hrbs' birthweight `sleep')) tctspc11 ///
	= i.sex i.msmoking i.malcohol fincome birthday, add(50) rseed(100) by(sex) noisily 
	
//DATA EXPLORATION
log using "[pathname]/080424_miM3_dataexplore.smcl"
summarize _mi_id _mi_miss _mi_m

*compare mean and summary stats for the original data and compare it with imputed data
tab _mi_m, summarize(y18_alltrauma)
tab _mi_m, summarize(y18_alcohol)
tab _mi_m, summarize(y18_smoking)
tab _mi_m, summarize(y18_druguse)
tab _mi_m, summarize(y18_sleepdur)
tab _mi_m, summarize(ethnicity) 
tab _mi_m, summarize(meduc) 
tab _mi_m, summarize(y11_alcohol)
tab _mi_m, summarize(y11_smoking)
tab _mi_m, summarize(y11_sleepdur)
tab _mi_m, summarize(y15_alcohol)
tab _mi_m, summarize(y15_smoking)
tab _mi_m, summarize(y15_druguse)
tab _mi_m, summarize(y15_sleepdur)
tab _mi_m, summarize(birthweight)
tab _mi_m, summarize(tctspc6)
tab _mi_m, summarize(tctspc11)

*Monte Carlo Error - check whether the Monte Carlo error of B is approximately 10 per cent of its standard error (so one value below coefficient vs SE of the coefficient)
mi estimate, mcerror: logistic y18_alcohol y18_alltrauma
mi estimate, mcerror: logistic y18_smoking y18_alltrauma
mi estimate, mcerror: logistic y18_druguse y18_alltrauma
mi estimate, mcerror: regress y18_sleepdur y18_alltrauma
mi estimate, mcerror: logistic y18_alcohol y18_alltrauma sex ethnicity msmoking malcohol meduc fincome birthday
mi estimate, mcerror: logistic y18_smoking y18_alltrauma sex ethnicity msmoking malcohol meduc fincome birthday
mi estimate, mcerror: logistic y18_druguse y18_alltrauma sex ethnicity msmoking malcohol meduc fincome birthday
mi estimate, mcerror: regress y18_sleepdur y18_alltrauma sex ethnicity msmoking malcohol meduc fincome birthday

//IMPUTATION CHECKS
*checking imputation process to see if need more cycles of chained equations algorithm
use "080424_miM4_MB", clear
save "080424_miM4_trace_MB", replace 

//note: savetrace cannot be combined with the by() command
local auxiliary "birthweight tctspc6 tctspc11"
local sleep "y18_sleepdur y11_sleepdur y15_sleepdur"
local y18hrbs "i.y18_alcohol i.y18_smoking i.y18_druguse"
local y11hrbs "i.y11_alcohol i.y11_smoking"
local y15hrbs "i.y15_alcohol i.y15_smoking i.y15_druguse"
 
set more off
mi impute chained ///
(logit, omit(`y11hrbs' y11_sleepdur `y15hrbs' y15_sleepdur birthweight)) y18_alltrauma ///
(logit, omit(i.y11_smoking `sleep' `auxiliary')) y18_alcohol ///
(logit, omit(i.y11_alcohol `sleep' `auxiliary')) y18_smoking ///
(logit, omit(i.y11_alcohol `sleep' `auxiliary')) y18_druguse ///
(pmm, knn(10) omit(`y18hrbs' `y11hrbs' `y15hrbs' `auxiliary')) y18_sleepdur ///
(logit, omit(`y11hrbs' y11_sleepdur `y15hrbs' y15_sleepdur `auxiliary')) ethnicity ///
(pmm, knn(10) omit(`y11hrbs' y11_sleepdur `y15hrbs' y15_sleepdur tctspc6 tctspc11)) meduc ///
(logit, omit(i.y18_druguse i.y18_alltrauma i.ethnicity meduc `sleep' `auxiliary')) y11_alcohol ///
(logit, omit(i.y18_alcohol i.y18_alltrauma meduc i.y15_alcohol i.y15_smoking i.y15_druguse `sleep' birthweight i.malcohol)) y11_smoking ///
(pmm, knn(10) omit(`y18hrbs' i.y18_alltrauma i.ethnicity meduc i.y11_smoking `y15hrbs' y15_sleepdur `auxiliary')) y11_sleepdur ///
(logit, omit(i.y18_alltrauma i.ethnicity meduc i.y11_smoking `sleep' `auxiliary')) y15_alcohol ///
(logit, omit(i.y18_alltrauma i.ethnicity i.y11_smoking `sleep' `auxiliary')) y15_smoking ///
(logit, omit(i.y18_alltrauma i.ethnicity meduc `y11hrbs' `sleep' `auxiliary')) y15_druguse ///
(pmm, knn(10) omit(i.y18_smoking i.y18_druguse i.y18_alltrauma i.ethnicity `y11hrbs' y11_sleepdur i.y15_druguse `auxiliary')) y15_sleepdur ///
(pmm, knn(10) omit(`y18hrbs' i.y18_alltrauma i.ethnicity `y11hrbs' `y15hrbs' tctspc6 tctspc11 `sleep')) birthweight ///
(pmm, knn(10) omit(`y18hrbs' i.ethnicity meduc `y11hrbs' `y15hrbs' birthweight `sleep')) tctspc6 ///
(pmm, knn(10) omit(`y18hrbs' `y11hrbs' `y15hrbs' birthweight `sleep')) tctspc11 ///
	= i.sex i.msmoking i.malcohol fincome birthday, rseed(100) chainonly burnin(100) savetrace(m4_imptrace)
	
//check scatterplots for convergence
use m4_imptrace

scatter y18_alltrauma_mean iter, c(1)
graph save "Graph" "[pathname]/Trace Scatterplots/m4_y18alltrauma.gph", replace
scatter y18_alcohol_mean iter, c(1)
graph save "Graph" "[pathname]/Trace Scatterplots/m4_y18alcohol.gph", replace
scatter y18_smoking_mean iter, c(1)
graph save "Graph" "[pathname]/Trace Scatterplots/m4_y18smoking.gph", replace
scatter y18_druguse_mean iter, c(1)
graph save "Graph" "[pathname]/Trace Scatterplots/m4_y18druguse.gph", replace
scatter y18_sleepdur_mean iter, c(1)
graph save "Graph" "[pathname]/Trace Scatterplots/m4_y18sleep.gph", replace
scatter ethnicity_mean iter, c(1)
graph save "Graph" "[pathname]/Trace Scatterplots/m4_ethnicity.gph", replace
scatter meduc_mean iter, c(1)
graph save "Graph" "[pathname]/Trace Scatterplots/m4_meduc.gph", replace
scatter y11_alcohol_mean iter, c(1)
graph save "Graph" "[pathname]/Trace Scatterplots/m4_y11alcohol.gph", replace
scatter y11_smoking_mean iter, c(1)
graph save "Graph" "[pathname]/Trace Scatterplots/m4_y11smoking.gph", replace
scatter y11_sleepdur_mean iter, c(1)
graph save "Graph" "[pathname]/Trace Scatterplots/m4_y11sleep.gph", replace
scatter y15_alcohol_mean iter, c(1)
graph save "Graph" "[pathname]/Trace Scatterplots/m4_y15alcohol.gph", replace
scatter y15_smoking_mean iter, c(1)
graph save "Graph" "[pathname]/Trace Scatterplots/m4_y15smoking.gph", replace
scatter y15_druguse_mean iter, c(1)
graph save "Graph" "[pathname]/Trace Scatterplots/m4_y15druguse.gph", replace
scatter y15_sleepdur_mean iter, c(1)
graph save "Graph" "[pathname]/Trace Scatterplots/m4_y15sleep.gph", replace
scatter birthweight_mean iter, c(1)
graph save "Graph" "[pathname]/Trace Scatterplots/m4_birthweight.gph", replace
scatter tctspc6_mean iter, c(1)
graph save "Graph" "[pathname]/Trace Scatterplots/m4_y6ctspc.gph", replace
scatter tctspc11_mean iter, c(1)
graph save "Graph" "[pathname]/Trace Scatterplots/m4_y11ctspc.gph", replace

**********************************************************

* MODEL 5: MEDIATION *

//CORRELATIONS
*full sample
tetrachoric y18_alltrauma y18_alcohol y18_smoking y18_druguse sex ethnicity msmoking malcohol y11_alcohol y11_smoking y15_alcohol y15_smoking y15_druguse, pw stats(rho se obs p)
spearman y18_hr y18_sbp y18_dbp y18_alltrauma y15_cte y18_alcohol y18_smoking y18_druguse y18_sleepdur y15_activity y15_bmi sex ethnicity msmoking malcohol meduc fincome birthday tctspc6 tctspc11 tctspc15 y11_alcohol y11_smoking y11_sleepdur y15_alcohol y15_smoking y15_druguse y15_sleepdur y11_activity y11_bmi birthweight, stats(rho p)
*already know there is no perfect pred for males/females separately

use "300424_HRcomplete_MB.dta", clear
save "300424_miM5_MB.dta", replace 

xtset, clear
mi set flong
mi stset, clear
mi register regular y18_hr y18_sbp y18_dbp sex msmoking malcohol fincome birthday
mi register imputed y15_cte y18_alcohol y18_smoking y18_druguse y18_sleepdur y15_activity y15_bmi ethnicity meduc tctspc6 tctspc11 y11_alcohol y11_smoking y11_sleepdur y15_alcohol y15_smoking y15_druguse y15_sleepdur y11_activity y11_bmi birthweight

//dryrun model
local y11hrbs "i.y11_alcohol i.y11_smoking"
local y15hrbs "i.y15_alcohol i.y15_smoking i.y15_druguse"
local sleep "y11_sleepdur y15_sleepdur"
local auxiliary "tctspc6 tctspc11 birthweight"
local phys "y18_hr y18_sbp y18_dbp"
local activity "y11_activity y15_activity"
local bmi "y11_bmi y15_bmi"
local y11aux "y11_activity y11_bmi"
local y18hrbs "i.y18_alcohol i.y18_smoking i.y18_druguse y18_sleepdur"

set more off
mi impute chained ///
(pmm, knn(10) omit(`y11hrbs' `y15hrbs' `sleep' `y11aux' birthweight)) y15_cte ///
(logit, omit(`sleep' `y11aux' `auxiliary' i.y11_smoking)) y18_alcohol ///
(logit, omit(`sleep' `y11aux' `auxiliary' i.y11_alcohol)) y18_smoking ///
(logit, omit(`sleep' `y11aux' `auxiliary' i.y11_alcohol)) y18_druguse ///
(pmm, knn(10) omit(`y11hrbs' `y15hrbs' `y11aux' `auxiliary')) y18_sleepdur ///
(pmm, knn(10) omit(`y11hrbs' `y15hrbs' `sleep' y11_bmi birthweight)) y15_activity ///
(pmm, knn(10) omit(`y11hrbs' `y15hrbs' `sleep' y11_activity tctspc6 tctspc11)) y15_bmi ///
(logit, omit(`y11hrbs' `y15hrbs' `auxiliary' `y11aux' `sleep')) ethnicity ///
(pmm, knn(10) omit(`y11hrbs' `y15hrbs' `y11aux' `sleep' tctspc6 tctspc11)) meduc ///
(pmm, knn(10) omit(`y11hrbs' `y15hrbs' `sleep' `y18hrbs' `phys' `activity' `bmi' birthweight i.ethnicity meduc)) tctspc6 ///
(pmm, knn(10) omit(`y11hrbs' `y15hrbs' `sleep' `y18hrbs' `phys' `activity' `bmi' birthweight)) tctspc11 ///
(logit, omit(y15_cte `sleep' i.y18_druguse y18_sleepdur i.ethnicity meduc `phys' `activity' `bmi' `auxiliary')) y11_alcohol ///
(logit, omit(y15_cte `sleep' `y15hrbs' i.y18_alcohol y18_sleepdur meduc birthweight `phys' `activity' `bmi' i.malcohol)) y11_smoking ///
(pmm, knn(10) omit(y15_cte i.y11_smoking `y15hrbs' y15_sleepdur i.y18_alcohol i.y18_smoking i.y18_druguse `phys' `activity' `bmi' `auxiliary' i.ethnicity meduc)) y11_sleepdur ///
(logit, omit(y15_cte `sleep' i.y11_smoking y18_sleepdur i.ethnicity meduc `phys' `activity' `bmi' `auxiliary')) y15_alcohol ///
(logit, omit(y15_cte `sleep' i.y11_smoking y18_sleepdur i.ethnicity `phys' `activity' `bmi' `auxiliary')) y15_smoking ///
(logit, omit(y15_cte `sleep' `y11hrbs' y18_sleepdur i.ethnicity meduc `phys' `activity' `bmi' `auxiliary')) y15_druguse ///
(pmm, knn(10) omit(y15_cte `y11hrbs' i.y15_druguse i.y18_smoking i.y18_druguse i.ethnicity `phys' `activity' `bmi' `auxiliary' y11_sleepdur)) y15_sleepdur ///
(pmm, knn(10) omit(y18_dbp y15_cte `bmi' `y11hrbs' `y15hrbs' `y18hrbs' `sleep' `auxiliary')) y11_activity ///
(pmm, knn(10) omit(y18_hr y15_cte i.ethnicity `activity' `y11hrbs' `y15hrbs' `y18hrbs' `sleep' tctspc6 tctspc11)) y11_bmi ///
(pmm, knn(10) omit(`y11hrbs' `y15hrbs' `y18hrbs' `sleep' `phys' `activity' `bmi' i.ethnicity tctspc6 tctspc11 y15_cte)) birthweight ///
	= y18_hr y18_sbp y18_dbp i.sex i.msmoking i.malcohol fincome birthday, dryrun
	
//convergence checks
logit y18_druguse meduc i.ethnicity i.y18_smoking i.y18_alcohol i.y11_smoking y18_sleepdur y15_cte y15_bmi i.y15_smoking i.y15_alcohol i.y15_druguse y15_activity y18_hr y18_sbp y18_dbp i.sex i.msmoking i.malcohol fincome birthday if _mi_m==0
logit y18_smoking meduc i.ethnicity i.y18_druguse i.y18_alcohol i.y11_smoking y18_sleepdur y15_cte y15_bmi i.y15_smoking i.y15_alcohol i.y15_druguse y15_activity y18_hr y18_sbp y18_dbp i.sex i.msmoking i.malcohol fincome birthday if _mi_m==0
logit y18_alcohol meduc i.ethnicity i.y18_druguse i.y18_smoking i.y11_alcohol y18_sleepdur y15_cte y15_bmi i.y15_smoking i.y15_alcohol i.y15_druguse y15_activity y18_hr y18_sbp y18_dbp i.sex i.msmoking i.malcohol fincome birthday if _mi_m==0
regress y18_sleepdur meduc i.ethnicity i.y18_druguse i.y18_smoking i.y18_alcohol y11_sleepdur y15_cte y15_bmi y15_sleepdur y15_activity y18_hr y18_sbp y18_dbp i.sex i.msmoking i.malcohol fincome birthday if _mi_m==0
regress y15_cte meduc i.ethnicity i.y18_druguse i.y18_smoking i.y18_alcohol tctspc11 tctspc6 y18_sleepdur y15_bmi y15_activity y18_hr y18_sbp y18_dbp i.sex i.msmoking i.malcohol fincome birthday if _mi_m==0
regress  y15_bmi birthweight meduc i.ethnicity i.y18_druguse i.y18_smoking i.y18_alcohol y11_bmi y18_sleepdur y15_cte y15_activity y18_hr y18_sbp y18_dbp i.sex i.msmoking i.malcohol fincome birthday if _mi_m==0
regress y15_activity meduc i.ethnicity i.y18_druguse i.y18_smoking i.y18_alcohol y11_activity tctspc11 tctspc6 y18_sleepdur y15_cte y15_bmi y18_hr y18_sbp y18_dbp i.sex i.msmoking i.malcohol fincome birthday if _mi_m==0

//m=10
local y11hrbs "i.y11_alcohol i.y11_smoking"
local y15hrbs "i.y15_alcohol i.y15_smoking i.y15_druguse"
local sleep "y11_sleepdur y15_sleepdur"
local auxiliary "tctspc6 tctspc11 birthweight"
local phys "y18_hr y18_sbp y18_dbp"
local activity "y11_activity y15_activity"
local bmi "y11_bmi y15_bmi"
local y11aux "y11_activity y11_bmi"
local y18hrbs "i.y18_alcohol i.y18_smoking i.y18_druguse y18_sleepdur"

set more off
mi impute chained ///
(pmm, knn(10) omit(`y11hrbs' `y15hrbs' `sleep' `y11aux' birthweight)) y15_cte ///
(logit, omit(`sleep' `y11aux' `auxiliary' i.y11_smoking)) y18_alcohol ///
(logit, omit(`sleep' `y11aux' `auxiliary' i.y11_alcohol)) y18_smoking ///
(logit, omit(`sleep' `y11aux' `auxiliary' i.y11_alcohol)) y18_druguse ///
(pmm, knn(10) omit(`y11hrbs' `y15hrbs' `y11aux' `auxiliary')) y18_sleepdur ///
(pmm, knn(10) omit(`y11hrbs' `y15hrbs' `sleep' y11_bmi birthweight)) y15_activity ///
(pmm, knn(10) omit(`y11hrbs' `y15hrbs' `sleep' y11_activity tctspc6 tctspc11)) y15_bmi ///
(logit, omit(`y11hrbs' `y15hrbs' `auxiliary' `y11aux' `sleep')) ethnicity ///
(pmm, knn(10) omit(`y11hrbs' `y15hrbs' `y11aux' `sleep' tctspc6 tctspc11)) meduc ///
(pmm, knn(10) omit(`y11hrbs' `y15hrbs' `sleep' `y18hrbs' `phys' `activity' `bmi' birthweight i.ethnicity meduc)) tctspc6 ///
(pmm, knn(10) omit(`y11hrbs' `y15hrbs' `sleep' `y18hrbs' `phys' `activity' `bmi' birthweight)) tctspc11 ///
(logit, omit(y15_cte `sleep' i.y18_druguse y18_sleepdur i.ethnicity meduc `phys' `activity' `bmi' `auxiliary')) y11_alcohol ///
(logit, omit(y15_cte `sleep' `y15hrbs' i.y18_alcohol y18_sleepdur meduc birthweight `phys' `activity' `bmi' i.malcohol)) y11_smoking ///
(pmm, knn(10) omit(y15_cte i.y11_smoking `y15hrbs' y15_sleepdur i.y18_alcohol i.y18_smoking i.y18_druguse `phys' `activity' `bmi' `auxiliary' i.ethnicity meduc)) y11_sleepdur ///
(logit, omit(y15_cte `sleep' i.y11_smoking y18_sleepdur i.ethnicity meduc `phys' `activity' `bmi' `auxiliary')) y15_alcohol ///
(logit, omit(y15_cte `sleep' i.y11_smoking y18_sleepdur i.ethnicity `phys' `activity' `bmi' `auxiliary')) y15_smoking ///
(logit, omit(y15_cte `sleep' `y11hrbs' y18_sleepdur i.ethnicity meduc `phys' `activity' `bmi' `auxiliary')) y15_druguse ///
(pmm, knn(10) omit(y15_cte `y11hrbs' i.y15_druguse i.y18_smoking i.y18_druguse i.ethnicity `phys' `activity' `bmi' `auxiliary' y11_sleepdur)) y15_sleepdur ///
(pmm, knn(10) omit(y18_dbp y15_cte `bmi' `y11hrbs' `y15hrbs' `y18hrbs' `sleep' `auxiliary')) y11_activity ///
(pmm, knn(10) omit(y18_hr y15_cte i.ethnicity `activity' `y11hrbs' `y15hrbs' `y18hrbs' `sleep' tctspc6 tctspc11)) y11_bmi ///
(pmm, knn(10) omit(`y11hrbs' `y15hrbs' `y18hrbs' `sleep' `phys' `activity' `bmi' i.ethnicity tctspc6 tctspc11 y15_cte)) birthweight ///
	= y18_hr y18_sbp y18_dbp i.sex i.msmoking i.malcohol fincome birthday, add(10) rseed(100) by(sex) noisily 
	
//m=50
local y11hrbs "i.y11_alcohol i.y11_smoking"
local y15hrbs "i.y15_alcohol i.y15_smoking i.y15_druguse"
local sleep "y11_sleepdur y15_sleepdur"
local auxiliary "tctspc6 tctspc11 birthweight"
local phys "y18_hr y18_sbp y18_dbp"
local activity "y11_activity y15_activity"
local bmi "y11_bmi y15_bmi"
local y11aux "y11_activity y11_bmi"
local y18hrbs "i.y18_alcohol i.y18_smoking i.y18_druguse y18_sleepdur"

set more off
mi impute chained ///
(pmm, knn(10) omit(`y11hrbs' `y15hrbs' `sleep' `y11aux' birthweight)) y15_cte ///
(logit, omit(`sleep' `y11aux' `auxiliary' i.y11_smoking)) y18_alcohol ///
(logit, omit(`sleep' `y11aux' `auxiliary' i.y11_alcohol)) y18_smoking ///
(logit, omit(`sleep' `y11aux' `auxiliary' i.y11_alcohol)) y18_druguse ///
(pmm, knn(10) omit(`y11hrbs' `y15hrbs' `y11aux' `auxiliary')) y18_sleepdur ///
(pmm, knn(10) omit(`y11hrbs' `y15hrbs' `sleep' y11_bmi birthweight)) y15_activity ///
(pmm, knn(10) omit(`y11hrbs' `y15hrbs' `sleep' y11_activity tctspc6 tctspc11)) y15_bmi ///
(logit, omit(`y11hrbs' `y15hrbs' `auxiliary' `y11aux' `sleep')) ethnicity ///
(pmm, knn(10) omit(`y11hrbs' `y15hrbs' `y11aux' `sleep' tctspc6 tctspc11)) meduc ///
(pmm, knn(10) omit(`y11hrbs' `y15hrbs' `sleep' `y18hrbs' `phys' `activity' `bmi' birthweight i.ethnicity meduc)) tctspc6 ///
(pmm, knn(10) omit(`y11hrbs' `y15hrbs' `sleep' `y18hrbs' `phys' `activity' `bmi' birthweight)) tctspc11 ///
(logit, omit(y15_cte `sleep' i.y18_druguse y18_sleepdur i.ethnicity meduc `phys' `activity' `bmi' `auxiliary')) y11_alcohol ///
(logit, omit(y15_cte `sleep' `y15hrbs' i.y18_alcohol y18_sleepdur meduc birthweight `phys' `activity' `bmi' i.malcohol)) y11_smoking ///
(pmm, knn(10) omit(y15_cte i.y11_smoking `y15hrbs' y15_sleepdur i.y18_alcohol i.y18_smoking i.y18_druguse `phys' `activity' `bmi' `auxiliary' i.ethnicity meduc)) y11_sleepdur ///
(logit, omit(y15_cte `sleep' i.y11_smoking y18_sleepdur i.ethnicity meduc `phys' `activity' `bmi' `auxiliary')) y15_alcohol ///
(logit, omit(y15_cte `sleep' i.y11_smoking y18_sleepdur i.ethnicity `phys' `activity' `bmi' `auxiliary')) y15_smoking ///
(logit, omit(y15_cte `sleep' `y11hrbs' y18_sleepdur i.ethnicity meduc `phys' `activity' `bmi' `auxiliary')) y15_druguse ///
(pmm, knn(10) omit(y15_cte `y11hrbs' i.y15_druguse i.y18_smoking i.y18_druguse i.ethnicity `phys' `activity' `bmi' `auxiliary' y11_sleepdur)) y15_sleepdur ///
(pmm, knn(10) omit(y18_dbp y15_cte `bmi' `y11hrbs' `y15hrbs' `y18hrbs' `sleep' `auxiliary')) y11_activity ///
(pmm, knn(10) omit(y18_hr y15_cte i.ethnicity `activity' `y11hrbs' `y15hrbs' `y18hrbs' `sleep' tctspc6 tctspc11)) y11_bmi ///
(pmm, knn(10) omit(`y11hrbs' `y15hrbs' `y18hrbs' `sleep' `phys' `activity' `bmi' i.ethnicity tctspc6 tctspc11 y15_cte)) birthweight ///
	= y18_hr y18_sbp y18_dbp i.sex i.msmoking i.malcohol fincome birthday, add(50) rseed(100) by(sex) noisily 
	
//DATA EXPLORATION
log using "[pathname]/300424_miM5_dataexplore.smcl"
summarize _mi_id _mi_miss _mi_m

*compare mean and summary stats for the original data and compare it with imputed data
tab _mi_m, summarize(y15_cte)
tab _mi_m, summarize(y18_alcohol)
tab _mi_m, summarize(y18_smoking)
tab _mi_m, summarize(y18_druguse)
tab _mi_m, summarize(y18_sleepdur)
tab _mi_m, summarize(y15_activity)
tab _mi_m, summarize(y15_bmi)
tab _mi_m, summarize(ethnicity) 
tab _mi_m, summarize(meduc) 
tab _mi_m, summarize(y11_alcohol)
tab _mi_m, summarize(y11_smoking)
tab _mi_m, summarize(y11_sleepdur)
tab _mi_m, summarize(y15_alcohol)
tab _mi_m, summarize(y15_smoking)
tab _mi_m, summarize(y15_druguse)
tab _mi_m, summarize(y15_sleepdur)
tab _mi_m, summarize(birthweight)
tab _mi_m, summarize(tctspc6)
tab _mi_m, summarize(tctspc11)
tab _mi_m, summarize(y11_activity)
tab _mi_m, summarize(y11_bmi)

*Monte Carlo Error - check whether the Monte Carlo error of B is approximately 10 per cent of its standard error (so one value below coefficient vs SE of the coefficient)
mi estimate, mcerror: regress y18_hr y18_alcohol
mi estimate, mcerror: regress y18_sbp y18_alcohol
mi estimate, mcerror: regress y18_dbp y18_alcohol
mi estimate, mcerror: regress y18_hr y18_alcohol y15_cte y15_activity y15_bmi sex ethnicity msmoking malcohol meduc fincome birthday
mi estimate, mcerror: regress y18_sbp y18_alcohol y15_cte y15_activity y15_bmi sex ethnicity msmoking malcohol meduc fincome birthday
mi estimate, mcerror: regress y18_dbp y18_alcohol y15_cte y15_activity y15_bmi sex ethnicity msmoking malcohol meduc fincome birthday

mi estimate, mcerror: regress y18_hr y18_smoking
mi estimate, mcerror: regress y18_sbp y18_smoking
mi estimate, mcerror: regress y18_dbp y18_smoking
mi estimate, mcerror: regress y18_hr y18_smoking y15_cte y15_activity y15_bmi sex ethnicity msmoking malcohol meduc fincome birthday
mi estimate, mcerror: regress y18_sbp y18_smoking y15_cte y15_activity y15_bmi sex ethnicity msmoking malcohol meduc fincome birthday
mi estimate, mcerror: regress y18_dbp y18_smoking y15_cte y15_activity y15_bmi sex ethnicity msmoking malcohol meduc fincome birthday

mi estimate, mcerror: regress y18_hr y18_druguse
mi estimate, mcerror: regress y18_sbp y18_druguse
mi estimate, mcerror: regress y18_dbp y18_druguse
mi estimate, mcerror: regress y18_hr y18_druguse y15_cte y15_activity y15_bmi sex ethnicity msmoking malcohol meduc fincome birthday
mi estimate, mcerror: regress y18_sbp y18_druguse y15_cte y15_activity y15_bmi sex ethnicity msmoking malcohol meduc fincome birthday
mi estimate, mcerror: regress y18_dbp y18_druguse y15_cte y15_activity y15_bmi sex ethnicity msmoking malcohol meduc fincome birthday

mi estimate, mcerror: regress y18_hr y18_sleepdur
mi estimate, mcerror: regress y18_sbp y18_sleepdur
mi estimate, mcerror: regress y18_dbp y18_sleepdur
mi estimate, mcerror: regress y18_hr y18_sleepdur y15_cte y15_activity y15_bmi sex ethnicity msmoking malcohol meduc fincome birthday
mi estimate, mcerror: regress y18_sbp y18_sleepdur y15_cte y15_activity y15_bmi sex ethnicity msmoking malcohol meduc fincome birthday
mi estimate, mcerror: regress y18_dbp y18_sleepdur y15_cte y15_activity y15_bmi sex ethnicity msmoking malcohol meduc fincome birthday

//IMPUTATION CHECKS
*checking imputation process to see if need more cycles of chained equations algorithm
use "300424_miM5_MB", clear
save "300424_miM5_trace_MB", replace 

//note: savetrace cannot be combined with the by() command
local y11hrbs "i.y11_alcohol i.y11_smoking"
local y15hrbs "i.y15_alcohol i.y15_smoking i.y15_druguse"
local sleep "y11_sleepdur y15_sleepdur"
local auxiliary "tctspc6 tctspc11 birthweight"
local phys "y18_hr y18_sbp y18_dbp"
local activity "y11_activity y15_activity"
local bmi "y11_bmi y15_bmi"
local y11aux "y11_activity y11_bmi"
local y18hrbs "i.y18_alcohol i.y18_smoking i.y18_druguse y18_sleepdur"

set more off
mi impute chained ///
(pmm, knn(10) omit(`y11hrbs' `y15hrbs' `sleep' `y11aux' birthweight)) y15_cte ///
(logit, omit(`sleep' `y11aux' `auxiliary' i.y11_smoking)) y18_alcohol ///
(logit, omit(`sleep' `y11aux' `auxiliary' i.y11_alcohol)) y18_smoking ///
(logit, omit(`sleep' `y11aux' `auxiliary' i.y11_alcohol)) y18_druguse ///
(pmm, knn(10) omit(`y11hrbs' `y15hrbs' `y11aux' `auxiliary')) y18_sleepdur ///
(pmm, knn(10) omit(`y11hrbs' `y15hrbs' `sleep' y11_bmi birthweight)) y15_activity ///
(pmm, knn(10) omit(`y11hrbs' `y15hrbs' `sleep' y11_activity tctspc6 tctspc11)) y15_bmi ///
(logit, omit(`y11hrbs' `y15hrbs' `auxiliary' `y11aux' `sleep')) ethnicity ///
(pmm, knn(10) omit(`y11hrbs' `y15hrbs' `y11aux' `sleep' tctspc6 tctspc11)) meduc ///
(pmm, knn(10) omit(`y11hrbs' `y15hrbs' `sleep' `y18hrbs' `phys' `activity' `bmi' birthweight i.ethnicity meduc)) tctspc6 ///
(pmm, knn(10) omit(`y11hrbs' `y15hrbs' `sleep' `y18hrbs' `phys' `activity' `bmi' birthweight)) tctspc11 ///
(logit, omit(y15_cte `sleep' i.y18_druguse y18_sleepdur i.ethnicity meduc `phys' `activity' `bmi' `auxiliary')) y11_alcohol ///
(logit, omit(y15_cte `sleep' `y15hrbs' i.y18_alcohol y18_sleepdur meduc birthweight `phys' `activity' `bmi' i.malcohol)) y11_smoking ///
(pmm, knn(10) omit(y15_cte i.y11_smoking `y15hrbs' y15_sleepdur i.y18_alcohol i.y18_smoking i.y18_druguse `phys' `activity' `bmi' `auxiliary' i.ethnicity meduc)) y11_sleepdur ///
(logit, omit(y15_cte `sleep' i.y11_smoking y18_sleepdur i.ethnicity meduc `phys' `activity' `bmi' `auxiliary')) y15_alcohol ///
(logit, omit(y15_cte `sleep' i.y11_smoking y18_sleepdur i.ethnicity `phys' `activity' `bmi' `auxiliary')) y15_smoking ///
(logit, omit(y15_cte `sleep' `y11hrbs' y18_sleepdur i.ethnicity meduc `phys' `activity' `bmi' `auxiliary')) y15_druguse ///
(pmm, knn(10) omit(y15_cte `y11hrbs' i.y15_druguse i.y18_smoking i.y18_druguse i.ethnicity `phys' `activity' `bmi' `auxiliary' y11_sleepdur)) y15_sleepdur ///
(pmm, knn(10) omit(y18_dbp y15_cte `bmi' `y11hrbs' `y15hrbs' `y18hrbs' `sleep' `auxiliary')) y11_activity ///
(pmm, knn(10) omit(y18_hr y15_cte i.ethnicity `activity' `y11hrbs' `y15hrbs' `y18hrbs' `sleep' tctspc6 tctspc11)) y11_bmi ///
(pmm, knn(10) omit(`y11hrbs' `y15hrbs' `y18hrbs' `sleep' `phys' `activity' `bmi' i.ethnicity tctspc6 tctspc11 y15_cte)) birthweight ///
	= y18_hr y18_sbp y18_dbp i.sex i.msmoking i.malcohol fincome birthday, rseed(100) chainonly burnin(100) savetrace(m5_imptrace)
	
//check scatterplots for convergence
use m5_imptrace

scatter y15_cte_mean iter, c(1)
graph save "Graph" "[pathname]/Trace Scatterplots/m5_y15cte.gph", replace
scatter y18_alcohol_mean iter, c(1)
graph save "Graph" "[pathname]/Trace Scatterplots/m5_y18alcohol.gph", replace
scatter y18_smoking_mean iter, c(1)
graph save "Graph" "[pathname]/Trace Scatterplots/m5_y18smoking.gph", replace
scatter y18_druguse_mean iter, c(1)
graph save "Graph" "[pathname]/Trace Scatterplots/m5_y18druguse.gph", replace
scatter y18_sleepdur_mean iter, c(1)
graph save "Graph" "[pathname]/Trace Scatterplots/m5_y18sleep.gph", replace
scatter ethnicity_mean iter, c(1)
graph save "Graph" "[pathname]/Trace Scatterplots/m5_ethnicity.gph", replace
scatter meduc_mean iter, c(1)
graph save "Graph" "[pathname]/Trace Scatterplots/m5_meduc.gph", replace
scatter y11_alcohol_mean iter, c(1)
graph save "Graph" "[pathname]/Trace Scatterplots/m5_y11alcohol.gph", replace
scatter y11_smoking_mean iter, c(1)
graph save "Graph" "[pathname]/Trace Scatterplots/m5_y11smoking.gph", replace
scatter y11_sleepdur_mean iter, c(1)
graph save "Graph" "[pathname]/Trace Scatterplots/m5_y11sleep.gph", replace
scatter y15_alcohol_mean iter, c(1)
graph save "Graph" "[pathname]/Trace Scatterplots/m5_y15alcohol.gph", replace
scatter y15_smoking_mean iter, c(1)
graph save "Graph" "[pathname]/Trace Scatterplots/m5_y15smoking.gph", replace
scatter y15_druguse_mean iter, c(1)
graph save "Graph" "[pathname]/Trace Scatterplots/m5_y15druguse.gph", replace
scatter y15_sleepdur_mean iter, c(1)
graph save "Graph" "[pathname]/Trace Scatterplots/m5_y15sleep.gph", replace
scatter birthweight_mean iter, c(1)
graph save "Graph" "[pathname]/Trace Scatterplots/m5_birthweight.gph", replace
scatter tctspc6_mean iter, c(1)
graph save "Graph" "[pathname]/Trace Scatterplots/m5_y6ctspc.gph", replace
scatter tctspc11_mean iter, c(1)
graph save "Graph" "[pathname]/Trace Scatterplots/m5_y11ctspc.gph", replace
scatter y15_activity_mean iter, c(1)
graph save "Graph" "[pathname]/Trace Scatterplots/m5_y15hactivity.gph", replace
scatter y15_bmi_mean iter, c(1)
graph save "Graph" "[pathname]/Trace Scatterplots/m5_y15hbaz.gph", replace
scatter y11_activity_mean iter, c(1)
graph save "Graph" "[pathname]/Trace Scatterplots/m5_y11activity.gph", replace
scatter y11_bmi_mean iter, c(1)
graph save "Graph" "[pathname]/Trace Scatterplots/m5_y11gziibod.gph", replace
