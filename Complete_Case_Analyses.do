******************************************************************
*       Childhood trauma, adolescent risk behaviours, &          *
* cardiovascular health indices in the 2004 Pelotas Birth Cohort *
******************************************************************

**************************
* Complete Case Analyses *
**************************

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

* APPENDIX 1 - CTE: LIKELIHOOD RATIO TEST *
//checking to see whether there is statistical evidence that cumulative trauma has a linear relationship with disorders in the complete case data
//if test is significant, it suggests the 2 models differ and the exposure should be treated categorically (rather than continuously)

//cross-sectional at age 18
logistic y18_alcohol y18_cte if cs_complete==1
est store a
logistic y18_alcohol i.y18_cte if cs_complete==1
est store b
lrtest a b

logistic y18_smoking y18_cte if cs_complete==1
est store a
logistic y18_smoking i.y18_cte if cs_complete==1
est store b
lrtest a b

logistic y18_druguse y18_cte if cs_complete==1
est store a
logistic y18_druguse i.y18_cte if cs_complete==1
est store b
lrtest a b

regress y18_sleepdur y18_cte if cs_complete==1
est store a
regress y18_sleepdur i.y18_cte if cs_complete==1
est store b
lrtest a b

//longitudinal at age 11
logistic y18_alcohol y11_cte if l11_complete==1
est store a
logistic y18_alcohol i.y11_cte if l11_complete==1
est store b
lrtest a b

logistic y18_smoking y11_cte if l11_complete==1
est store a
logistic y18_smoking i.y11_cte if l11_complete==1
est store b
lrtest a b

logistic y18_druguse y11_cte if l11_complete==1
est store a
logistic y18_druguse i.y11_cte if l11_complete==1
est store b
lrtest a b

regress y18_sleepdur y11_cte if l11_complete==1
est store a
regress y18_sleepdur i.y11_cte if l11_complete==1
est store b
lrtest a b

//longitudinal at age 15
logistic y18_alcohol y15_cte if l15_complete==1
est store a
logistic y18_alcohol i.y15_cte if l15_complete==1
est store b
lrtest a b

logistic y18_smoking y15_cte if l15_complete==1
est store a
logistic y18_smoking i.y15_cte if l15_complete==1
est store b
lrtest a b

logistic y18_druguse y15_cte if l15_complete==1
est store a
logistic y18_druguse i.y15_cte if l15_complete==1
est store b
lrtest a b

regress y18_sleepdur y15_cte if l15_complete==1
est store a
regress y18_sleepdur i.y15_cte if l15_complete==1
est store b
lrtest a b

*all non-significant therefore ok to treat variable continuously

**********************************************************

* APPENDIX 1 - CTE: LIKELIHOOD RATIO TEST *
//checking to see whether there is statistical evidence that cumulative trauma has a linear relationship with disorders in the complete case data
//if test is significant, it suggests the 2 models differ and the exposure should be treated categorically (rather than continuously)

regress y18_hr y15_cte if med_complete==1
est store a
regress y18_hr i.y15_cte if med_complete==1
est store b
lrtest a b

regress y18_sbp y15_cte if med_complete==1
est store a
regress y18_sbp i.y15_cte if med_complete==1
est store b
lrtest a b

regress y18_dbp y15_cte if med_complete==1
est store a
regress y18_dbp i.y15_cte if med_complete==1
est store b
lrtest a b

*all non-significant therefore ok to treat variable continuously

**********************************************************

* APPENDIX 1 - LINEAR REGRESSION ASSUMPTION CHECKING (FOR SLEEP DURATION) *

*assumption 1: variation in the residuals is the same for all values of x
regress y18_sleepdur y18_cte i.sex i.ethnicity i.msmoking i.malcohol meduc fincome if cs_compcon==1
predict fit1, xb
predict res1, res
scatter res1 fit1
graph save "[pathname]/y18sleep_a1scatter", replace
//assumption is met if there is no fanning out or in of the data points in the plot

//unadjusted
regress y18_sleepdur y18_cte
predict res, res
scatter res y18_cte
graph save "[pathname]/y18sleep_a1noconfound", replace
//residual descriptives: want to see that the means are close to zero and the pattern of positive and negative signs fluctuates randomly; also want the sd to be constant across trauma categories
tab y18_cte, sum(res1)

*assumption 2: the residuals are normally distributed with a mean of zero
regress y18_sleepdur y18_cte i.sex i.ethnicity i.msmoking i.malcohol meduc fincome if cs_compcon==1
predict res2, res
histogram res2
graph save "[pathname]/y18sleep_a2histogram", replace
qnorm res2
graph save "[pathname]/y18sleep_a2qqplot", replace
//assumption is met if the histogram is normally distributed and the qq plot shows the data points following along the solid line (at least in the centre even if there is some deviation at the tails)

*assumption 3: the relationship between x and y is linear
scatter y18_cte y18_sleepdur if cs_compcon==1
graph save "[pathname]/y18sleep_a3scatter", replace
regress y18_sleepdur y18_cte i.sex i.ethnicity i.msmoking i.malcohol meduc fincome if cs_compcon==1
predict fit3, xb
predict res3, res
scatter res3 fit3
graph save "[pathname]/y18sleep_a3scatterresid", replace
//assumption is met if the first plot shows a linear trend and the second plot showing randomly scattered data points (e.g., no curvature)

*for the categorical exposure, a dotplot might also be beneficial
dotplot y18_sleepdur, over(y18_cte) mean
graph save "[pathname]/y18sleep_dotplot", replace

**********************************************************

* APPENDIX 2 TABLE S6: SAMPLE CHARACTERISTICS ACCORDING TO TRAUMA EXPOSURE STATUS AT AGE 18 *

tab sex if cs_compcon==1
tab sex y18_alltrauma if cs_compcon==1
logistic y18_alltrauma i.sex if cs_compcon==1
logistic y18_alltrauma ib2.sex if cs_compcon==1
tab ethnicity if cs_compcon==1
tab ethnicity y18_alltrauma if cs_compcon==1
logistic y18_alltrauma i.ethnicity if cs_compcon==1
logistic y18_alltrauma ib2.ethnicity if cs_compcon==1
tab msmoking if cs_compcon==1
tab msmoking y18_alltrauma if cs_compcon==1
logistic y18_alltrauma i.msmoking if cs_compcon==1
tab malcohol if cs_compcon==1
tab malcohol y18_alltrauma if cs_compcon==1
logistic y18_alltrauma i.malcohol if cs_compcon==1
summarize meduc fincome birthday if cs_compcon==1
summarize meduc fincome birthday if cs_compcon==1 & y18_alltrauma==0
summarize meduc fincome birthday if cs_compcon==1 & y18_alltrauma==1
ttest meduc if cs_compcon==1, by(y18_alltrauma) 
ttest fincome if cs_compcon==1, by(y18_alltrauma) 
ttest birthday if cs_compcon==1, by(y18_alltrauma)

**********************************************************

* APPENDIX 2 TABLE S7: DESCRIPTIVE STATISTICS FOR ADOLESCENT RISK BEHAVIOURS AND CARDIOVASCULAR HEALTH INDICES ACCORDING TO CUMULATIVE TRAUMA EXPOSURE UP TO AGE 15 *

//total sample
tab y15_cte if med_complete==1
foreach var of varlist y18_alcohol y18_smoking y18_druguse {
	tab `var' if med_complete==1
}
foreach var of varlist y18_sleepdur y18_hr y18_sbp y18_dbp y15_activity y15_bmi {
	summ `var' if med_complete==1
}
//unexposed
foreach var of varlist y18_alcohol y18_smoking y18_druguse {
	tab `var' if y15_cte==0 & med_complete==1
}
foreach var of varlist y18_sleepdur y18_hr y18_sbp y18_dbp y15_activity y15_bmi {
	summ `var' if y15_cte==0 & med_complete==1
}
//1 trauma
foreach var of varlist y18_alcohol y18_smoking y18_druguse {
	tab `var' if y15_cte==1 & med_complete==1
}
foreach var of varlist y18_sleepdur y18_hr y18_sbp y18_dbp y15_activity y15_bmi {
	summ `var' if y15_cte==1 & med_complete==1
}
//2 traumas
foreach var of varlist y18_alcohol y18_smoking y18_druguse {
	tab `var' if y15_cte==2 & med_complete==1
}
foreach var of varlist y18_sleepdur y18_hr y18_sbp y18_dbp y15_activity y15_bmi {
	summ `var' if y15_cte==2 & med_complete==1
}
//≥3 traumas
foreach var of varlist y18_alcohol y18_smoking y18_druguse {
	tab `var' if y15_cte==3 & med_complete==1
}
foreach var of varlist y18_sleepdur y18_hr y18_sbp y18_dbp y15_activity y15_bmi {
	summ `var' if y15_cte==3 & med_complete==1
}

**********************************************************

* APPENDIX 2 TABLE S8: CROSS-SECTIONAL AND LONGITUDINAL ASSOCIATIONS BETWEEN CUMULATIVE TRAUMA UP TO AGES 11, 15, AND 18 AND HEALTH RISK BEHAVIOURS (HRBS) AT AGE 18 *

* cross-sectional *
//unadjusted 
logistic y18_alcohol y18_cte if cs_compcon==1
logistic y18_smoking y18_cte if cs_compcon==1
logistic y18_druguse y18_cte if cs_compcon==1
regress y18_sleepdur y18_cte if cs_compcon==1
//adjusted
logistic y18_alcohol y18_cte i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday if cs_compcon==1
logistic y18_smoking y18_cte i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday if cs_compcon==1
logistic y18_druguse y18_cte i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday if cs_compcon==1
regress y18_sleepdur y18_cte i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday if cs_compcon==1

* longitudinal - age 11 cte *
//unadjusted 
logistic y18_alcohol y11_cte if l11_compcon==1
logistic y18_smoking y11_cte if l11_compcon==1
logistic y18_druguse y11_cte if l11_compcon==1
regress y18_sleepdur y11_cte if l11_compcon==1
//adjusted
logistic y18_alcohol y11_cte i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday if l11_compcon==1
logistic y18_smoking y11_cte i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday if l11_compcon==1
logistic y18_druguse y11_cte i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday if l11_compcon==1
regress y18_sleepdur y11_cte i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday if l11_compcon==1

* longitudinal - age 15 cte *
//unadjusted 
logistic y18_alcohol y15_cte if l15_compcon==1
logistic y18_smoking y15_cte if l15_compcon==1
logistic y18_druguse y15_cte if l15_compcon==1
regress y18_sleepdur y15_cte if l15_compcon==1
//adjusted
logistic y18_alcohol y15_cte i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday if l15_compcon==1
logistic y18_smoking y15_cte i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday if l15_compcon==1
logistic y18_druguse y15_cte i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday if l15_compcon==1
regress y18_sleepdur y15_cte i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday if l15_compcon==1

**********************************************************

* SENSITIVITY ANALYSES - SEX DIFFERENCES * 
logistic y18_alcohol c.y18_cte##i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday if cs_compcon==1
logistic y18_smoking c.y18_cte##i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday if cs_compcon==1
logistic y18_druguse c.y18_cte##i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday if cs_compcon==1
regress y18_sleepdur c.y18_cte##i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday if cs_compcon==1

* longitudinal - age 11 cte *
logistic y18_alcohol c.y11_cte##i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday if l11_compcon==1
logistic y18_smoking c.y11_cte##i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday if l11_compcon==1
logistic y18_druguse c.y11_cte##i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday if l11_compcon==1
regress y18_sleepdur c.y11_cte##i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday if l11_compcon==1

* longitudinal - age 15 cte *
logistic y18_alcohol c.y15_cte##i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday if l15_compcon==1
logistic y18_smoking c.y15_cte##i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday if l15_compcon==1
logistic y18_druguse c.y15_cte##i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday if l15_compcon==1
regress y18_sleepdur c.y15_cte##i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday if l15_compcon==1

*significant interaction effects for drug use
logistic y18_druguse y18_cte i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday if cs_compcon==1 & sex==0
logistic y18_druguse y18_cte i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday if cs_compcon==1 & sex==1
logistic y18_druguse y11_cte i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday if l11_compcon==1 & sex==0
logistic y18_druguse y11_cte i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday if l11_compcon==1 & sex==1

**********************************************************

* POPULATION ATTRIBUTABLE FRACTION *

putexcel set "040424_PAFcca_MB", sheet("y18") modify
putexcel A1="Outcome" B1="beta" C1="SE" D1="P Value" E1="RR" F1="LCI" G1= "UCI" H1="PAF" I1="LPAF" J1="UPAF" K1="pc"

global outcome "y18_alcohol y18_smoking y18_druguse"
local x=1

foreach out of global outcome{
	use "[pathname]/250324_s2prep_v9_MB.dta", clear
	
	glm `out' y18_alltrauma i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday if cs_compcon==1, family(poisson) link(log) nolog vce(robust)
	
	local beta = _b[y18_alltrauma]
	local se = _se[y18_alltrauma]
	test y18_alltrauma
	local pvalue = `r(p)'
	
	bysort `out': egen denom = count(idnum)
	bysort `out': egen num2 = count(idnum) if y18_alltrauma==1
	bysort `out': egen num = min(num2)
	gen prop = num/denom
	bysort `out': egen seq = seq() 
	summ prop if seq == 1 & `out'==1
	local pc = r(mean)
	drop denom num num2 prop seq
	
	local x=`x' +1
	local rr=2.718^(`beta')
	local lci=2.718^(`beta'-1.96*`se')
	local uci=2.718^(`beta'+1.96*`se')
	local paf=`pc'*(1-(1/`rr'))
	local lpaf=`pc'*(1-(1/`lci'))
	local upaf=`pc'*(1-(1/`uci'))
	
	putexcel A`x'="`out'" B`x'=`beta' C`x'=`se' D`x'=`pvalue' E`x'=`rr' F`x'=`lci' G`x'=`uci' H`x'=`paf' I`x'=`lpaf' J`x'=`upaf' K`x'=`pc'
}

**********************************************************

* APPENDIX 2 TABLE S9: CROSS-SECTIONAL ASSOCIATIONS BETWEEN ADOLESCENT RISK BEHAVIOURS AT AGE 18 AND RESTING HR, SYSTOLIC BP, AND DIASTOLIC BP AT AGE 18 *

* alcohol use
//unadjusted
regress y18_hr y18_alcohol if med_complete==1
regress y18_sbp y18_alcohol if med_complete==1
regress y18_dbp y18_alcohol if med_complete==1
//adjusted
regress y18_hr y18_alcohol i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday y15_cte y15_bmi y15_activity if med_complete==1
regress y18_sbp y18_alcohol i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday y15_cte y15_bmi y15_activity if med_complete==1
regress y18_dbp y18_alcohol i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday y15_cte y15_bmi y15_activity if med_complete==1

*smoking
//unadjusted
regress y18_hr y18_smoking if med_complete==1
regress y18_sbp y18_smoking if med_complete==1
regress y18_dbp y18_smoking if med_complete==1
//adjusted
regress y18_hr y18_smoking i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday y15_cte y15_bmi y15_activity if med_complete==1
regress y18_sbp y18_smoking i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday y15_cte y15_bmi y15_activity if med_complete==1
regress y18_dbp y18_smoking i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday y15_cte y15_bmi y15_activity if med_complete==1

*drug use
//unadjusted
regress y18_hr y18_druguse if med_complete==1
regress y18_sbp y18_druguse if med_complete==1
regress y18_dbp y18_druguse if med_complete==1
//adjusted
regress y18_hr y18_druguse i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday y15_cte y15_bmi y15_activity if med_complete==1
regress y18_sbp y18_druguse i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday y15_cte y15_bmi y15_activity if med_complete==1
regress y18_dbp y18_druguse i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday y15_cte y15_bmi y15_activity if med_complete==1

*sleep duration
//unadjusted
regress y18_hr y18_sleepdur if med_complete==1
regress y18_sbp y18_sleepdur if med_complete==1
regress y18_dbp y18_sleepdur if med_complete==1
//adjusted
regress y18_hr y18_sleepdur i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday y15_cte y15_bmi y15_activity if med_complete==1
regress y18_sbp y18_sleepdur i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday y15_cte y15_bmi y15_activity if med_complete==1
regress y18_dbp y18_sleepdur i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday y15_cte y15_bmi y15_activity if med_complete==1

**********************************************************

* APPENDIX 2 TABLE S10: MEDIATION MODELS OF THE RELATIONSHIP BETWEEN CUMULATIVE TRAUMA UP TO AGE 15 AND RESTING HR, SBP, AND DBP AT AGE 18 THROUGH MEDIATING SUBSTANCE USE BEHAVIOURS (PROBLEMATIC ALCOHOL USE, SMOKING, AND ILLICIT DRUG USE; SIMULTANEOUSLY INCLUDED IN THE MODELS) *

*resting HR
//unadjusted
gformula y18_hr y15_cte y18_alcohol y18_smoking y18_druguse, ///
mediation outcome(y18_hr) exposure(y15_cte) mediator (y18_alcohol y18_smoking y18_druguse) ///
commands(y18_hr:regress, y18_alcohol:logit, y18_smoking:logit, y18_druguse:logit) ///
equations(y18_hr: y15_cte y18_alcohol y18_smoking y18_druguse, y18_alcohol: y15_cte, y18_smoking: y15_cte, y18_druguse: y15_cte) ///
control(y18_alcohol:0, y18_smoking:0, y18_druguse:0) linexp  ///
samples(50) seed(79) moreMC sim(10000) minsim

//adjusted
gformula y18_hr y15_cte y18_alcohol y18_smoking y18_druguse y15_activity y15_bmi sex ethnicity msmoking malcohol meduc fincome birthday, ///
mediation outcome(y18_hr) exposure(y15_cte) mediator(y18_alcohol y18_smoking y18_druguse) post_confs(y15_activity y15_bmi) base_confs(sex ethnicity msmoking malcohol meduc fincome birthday) ///
commands(y18_hr:regress, y18_alcohol:logit, y18_smoking:logit, y18_druguse:logit, y15_activity:regress, y15_bmi:regress) ///
equations(y18_hr: y15_cte y18_alcohol y18_smoking y18_druguse y15_bmi y15_activity i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday, y18_alcohol: y15_cte y15_bmi y15_activity i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday, y18_smoking: y15_cte y15_bmi y15_activity i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday, y18_druguse: y15_cte y15_bmi y15_activity i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday, y15_activity: y15_cte i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday, y15_bmi: y15_cte y15_activity i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday) ///
control(y18_alcohol:0, y18_smoking:0, y18_druguse:0) linexp ///
samples(50) seed(79) moreMC sim(10000) minsim

*resting sBP
//unadjusted
gformula y18_sbp y15_cte y18_alcohol y18_smoking y18_druguse, ///
mediation outcome(y18_sbp) exposure(y15_cte) mediator (y18_alcohol y18_smoking y18_druguse) ///
commands(y18_sbp:regress, y18_alcohol:logit, y18_smoking:logit, y18_druguse:logit) ///
equations(y18_sbp: y15_cte y18_alcohol y18_smoking y18_druguse, y18_alcohol: y15_cte, y18_smoking: y15_cte, y18_druguse: y15_cte) ///
control(y18_alcohol:0, y18_smoking:0, y18_druguse:0) linexp  ///
samples(50) seed(79) moreMC sim(10000) minsim

//adjusted: 50 samples, 10000 MC samples
gformula y18_sbp y15_cte y18_alcohol y18_smoking y18_druguse y15_activity y15_bmi sex ethnicity msmoking malcohol meduc fincome birthday, ///
mediation outcome(y18_sbp) exposure(y15_cte) mediator(y18_alcohol y18_smoking y18_druguse) post_confs(y15_activity y15_bmi) base_confs(sex ethnicity msmoking malcohol meduc fincome birthday) ///
commands(y18_sbp:regress, y18_alcohol:logit, y18_smoking:logit, y18_druguse:logit, y15_activity:regress, y15_bmi:regress) ///
equations(y18_sbp: y15_cte y18_alcohol y18_smoking y18_druguse y15_bmi y15_activity i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday, y18_alcohol: y15_cte y15_bmi y15_activity i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday, y18_smoking: y15_cte y15_bmi y15_activity i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday, y18_druguse: y15_cte y15_bmi y15_activity i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday, y15_activity: y15_cte i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday, y15_bmi: y15_cte y15_activity i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday) ///
control(y18_alcohol:0, y18_smoking:0, y18_druguse:0) linexp ///
samples(50) seed(79) moreMC sim(10000) minsim

*resting dBP
//unadjusted
gformula y18_dbp y15_cte y18_alcohol y18_smoking y18_druguse, ///
mediation outcome(y18_dbp) exposure(y15_cte) mediator (y18_alcohol y18_smoking y18_druguse) ///
commands(y18_dbp:regress, y18_alcohol:logit, y18_smoking:logit, y18_druguse:logit) ///
equations(y18_dbp: y15_cte y18_alcohol y18_smoking y18_druguse, y18_alcohol: y15_cte, y18_smoking: y15_cte, y18_druguse: y15_cte) ///
control(y18_alcohol:0, y18_smoking:0, y18_druguse:0) linexp  ///
samples(50) seed(79) moreMC sim(10000) minsim

//adjusted: 50 samples, 10000 MC samples
gformula y18_dbp y15_cte y18_alcohol y18_smoking y18_druguse y15_activity y15_bmi sex ethnicity msmoking malcohol meduc fincome birthday, ///
mediation outcome(y18_dbp) exposure(y15_cte) mediator(y18_alcohol y18_smoking y18_druguse) post_confs(y15_activity y15_bmi) base_confs(sex ethnicity msmoking malcohol meduc fincome birthday) ///
commands(y18_dbp:regress, y18_alcohol:logit, y18_smoking:logit, y18_druguse:logit, y15_activity:regress, y15_bmi:regress) ///
equations(y18_dbp: y15_cte y18_alcohol y18_smoking y18_druguse y15_bmi y15_activity i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday, y18_alcohol: y15_cte y15_bmi y15_activity i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday, y18_smoking: y15_cte y15_bmi y15_activity i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday, y18_druguse: y15_cte y15_bmi y15_activity i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday, y15_activity: y15_cte i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday, y15_bmi: y15_cte y15_activity i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday) ///
control(y18_alcohol:0, y18_smoking:0, y18_druguse:0) linexp ///
samples(50) seed(79) moreMC sim(10000) minsim

**********************************************************

* APPENDIX 2 TABLE S11: MEDIATION MODELS OF THE RELATIONSHIP BETWEEN CUMULATIVE TRAUMA UP TO AGE 15 AND RESTING HEART RATE AT AGE 18 THROUGH MEDIATING SUBSTANCE USE BEHAVIOURS (PROBLEMATIC ALCOHOL USE, SMOKING, AND ILLICIT DRUG USE; INCLUDED INDIVIDUALLY) * 

*alcohol
//unadjusted
gformula y18_hr y15_cte y18_alcohol, ///
mediation outcome(y18_hr) exposure(y15_cte) mediator(y18_alcohol) ///
commands(y18_hr:regress, y18_alcohol:logit) ///
equations(y18_hr: y15_cte y18_alcohol, y18_alcohol: y15_cte) ///
control(y18_alcohol:0) linexp  ///
samples(50) seed(79) moreMC sim(10000) minsim

//adjusted
gformula y18_hr y15_cte y18_alcohol y15_activity y15_bmi sex ethnicity msmoking malcohol meduc fincome birthday, ///
mediation outcome(y18_hr) exposure(y15_cte) mediator(y18_alcohol) post_confs(y15_activity y15_bmi) base_confs(sex ethnicity msmoking malcohol meduc fincome birthday) ///
commands(y18_hr:regress, y18_alcohol:logit, y15_activity:regress, y15_bmi:regress) ///
equations(y18_hr: y15_cte y18_alcohol y15_bmi y15_activity i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday, y18_alcohol: y15_cte y15_bmi y15_activity i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday, y15_activity: y15_cte i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday, y15_bmi: y15_cte y15_activity i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday) ///
control(y18_alcohol:0) linexp ///
samples(50) seed(79) moreMC sim(10000) minsim

*smoking
//unadjusted
gformula y18_hr y15_cte y18_smoking, ///
mediation outcome(y18_hr) exposure(y15_cte) mediator(y18_smoking) ///
commands(y18_hr:regress, y18_smoking:logit) ///
equations(y18_hr: y15_cte y18_smoking, y18_smoking: y15_cte) ///
control(y18_smoking:0) linexp  ///
samples(50) seed(79) moreMC sim(10000) minsim

//adjusted
gformula y18_hr y15_cte y18_smoking y15_activity y15_bmi sex ethnicity msmoking malcohol meduc fincome birthday, ///
mediation outcome(y18_hr) exposure(y15_cte) mediator(y18_smoking) post_confs(y15_activity y15_bmi) base_confs(sex ethnicity msmoking malcohol meduc fincome birthday) ///
commands(y18_hr:regress, y18_smoking:logit, y15_activity:regress, y15_bmi:regress) ///
equations(y18_hr: y15_cte y18_smoking y15_bmi y15_activity i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday, y18_smoking: y15_cte y15_bmi y15_activity i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday, y15_activity: y15_cte i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday, y15_bmi: y15_cte y15_activity i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday) ///
control(y18_smoking:0) linexp ///
samples(50) seed(79) moreMC sim(10000) minsim

*drug use
//unadjusted
gformula y18_hr y15_cte y18_druguse, ///
mediation outcome(y18_hr) exposure(y15_cte) mediator(y18_druguse) ///
commands(y18_hr:regress, y18_druguse:logit) ///
equations(y18_hr: y15_cte y18_druguse, y18_druguse: y15_cte) ///
control(y18_druguse:0) linexp  ///
samples(50) seed(79) moreMC sim(10000) minsim

//adjusted
gformula y18_hr y15_cte y18_druguse y15_activity y15_bmi sex ethnicity msmoking malcohol meduc fincome birthday, ///
mediation outcome(y18_hr) exposure(y15_cte) mediator(y18_druguse) post_confs(y15_activity y15_bmi) base_confs(sex ethnicity msmoking malcohol meduc fincome birthday) ///
commands(y18_hr:regress, y18_druguse:logit, y15_activity:regress, y15_bmi:regress) ///
equations(y18_hr: y15_cte y18_druguse y15_bmi y15_activity i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday, y18_druguse: y15_cte y15_bmi y15_activity i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday, y15_activity: y15_cte i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday, y15_bmi: y15_cte y15_activity i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday) ///
control(y18_druguse:0) linexp ///
samples(50) seed(79) moreMC sim(10000) minsim

**********************************************************

* APPENDIX 2 TABLE S12: MEDIATION MODELS OF THE RELATIONSHIP BETWEEN CUMULATIVE TRAUMA UP TO AGE 15 AND RESTING SYSTOLIC BLOOD PRESSURE AT AGE 18 THROUGH MEDIATING SUBSTANCE USE BEHAVIOURS (PROBLEMATIC ALCOHOL USE, SMOKING, AND ILLICIT DRUG USE; INCLUDED INDIVIDUALLY) *

*alcohol
//unadjusted
gformula y18_sbp y15_cte y18_alcohol, ///
mediation outcome(y18_sbp) exposure(y15_cte) mediator(y18_alcohol) ///
commands(y18_sbp:regress, y18_alcohol:logit) ///
equations(y18_sbp: y15_cte y18_alcohol, y18_alcohol: y15_cte) ///
control(y18_alcohol:0) linexp  ///
samples(50) seed(79) moreMC sim(10000) minsim

//adjusted
gformula y18_sbp y15_cte y18_alcohol y15_activity y15_bmi sex ethnicity msmoking malcohol meduc fincome birthday, ///
mediation outcome(y18_sbp) exposure(y15_cte) mediator(y18_alcohol) post_confs(y15_activity y15_bmi) base_confs(sex ethnicity msmoking malcohol meduc fincome birthday) ///
commands(y18_sbp:regress, y18_alcohol:logit, y15_activity:regress, y15_bmi:regress) ///
equations(y18_sbp: y15_cte y18_alcohol y15_bmi y15_activity i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday, y18_alcohol: y15_cte y15_bmi y15_activity i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday, y15_activity: y15_cte i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday, y15_bmi: y15_cte y15_activity i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday) ///
control(y18_alcohol:0) linexp ///
samples(50) seed(79) moreMC sim(10000) minsim

*smoking
//unadjusted
gformula y18_sbp y15_cte y18_smoking, ///
mediation outcome(y18_sbp) exposure(y15_cte) mediator(y18_smoking) ///
commands(y18_sbp:regress, y18_smoking:logit) ///
equations(y18_sbp: y15_cte y18_smoking, y18_smoking: y15_cte) ///
control(y18_smoking:0) linexp  ///
samples(50) seed(79) moreMC sim(10000) minsim

//adjusted
gformula y18_sbp y15_cte y18_smoking y15_activity y15_bmi sex ethnicity msmoking malcohol meduc fincome birthday, ///
mediation outcome(y18_sbp) exposure(y15_cte) mediator(y18_smoking) post_confs(y15_activity y15_bmi) base_confs(sex ethnicity msmoking malcohol meduc fincome birthday) ///
commands(y18_sbp:regress, y18_smoking:logit, y15_activity:regress, y15_bmi:regress) ///
equations(y18_sbp: y15_cte y18_smoking y15_bmi y15_activity i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday, y18_smoking: y15_cte y15_bmi y15_activity i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday, y15_activity: y15_cte i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday, y15_bmi: y15_cte y15_activity i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday) ///
control(y18_smoking:0) linexp ///
samples(50) seed(79) moreMC sim(10000) minsim

*drug use
//unadjusted
gformula y18_sbp y15_cte y18_druguse, ///
mediation outcome(y18_sbp) exposure(y15_cte) mediator(y18_druguse) ///
commands(y18_sbp:regress, y18_druguse:logit) ///
equations(y18_sbp: y15_cte y18_druguse, y18_druguse: y15_cte) ///
control(y18_druguse:0) linexp  ///
samples(50) seed(79) moreMC sim(10000) minsim

//adjusted
gformula y18_sbp y15_cte y18_druguse y15_activity y15_bmi sex ethnicity msmoking malcohol meduc fincome birthday, ///
mediation outcome(y18_sbp) exposure(y15_cte) mediator(y18_druguse) post_confs(y15_activity y15_bmi) base_confs(sex ethnicity msmoking malcohol meduc fincome birthday) ///
commands(y18_sbp:regress, y18_druguse:logit, y15_activity:regress, y15_bmi:regress) ///
equations(y18_sbp: y15_cte y18_druguse y15_bmi y15_activity i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday, y18_druguse: y15_cte y15_bmi y15_activity i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday, y15_activity: y15_cte i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday, y15_bmi: y15_cte y15_activity i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday) ///
control(y18_druguse:0) linexp ///
samples(50) seed(79) moreMC sim(10000) minsim

**********************************************************

* APPENDIX 2 TABLE S13: MEDIATION MODELS OF THE RELATIONSHIP BETWEEN CUMULATIVE TRAUMA UP TO AGE 15 AND RESTING DIASTOLIC BLOOD PRESSURE AT AGE 18 THROUGH MEDIATING SUBSTANCE USE BEHAVIOURS (PROBLEMATIC ALCOHOL USE, SMOKING, AND ILLICIT DRUG USE; INCLUDED INDIVIDUALLY) *

*alcohol
//unadjusted
gformula y18_dbp y15_cte y18_alcohol, ///
mediation outcome(y18_dbp) exposure(y15_cte) mediator(y18_alcohol) ///
commands(y18_dbp:regress, y18_alcohol:logit) ///
equations(y18_dbp: y15_cte y18_alcohol, y18_alcohol: y15_cte) ///
control(y18_alcohol:0) linexp  ///
samples(50) seed(79) moreMC sim(10000) minsim

//adjusted
gformula y18_dbp y15_cte y18_alcohol y15_activity y15_bmi sex ethnicity msmoking malcohol meduc fincome birthday, ///
mediation outcome(y18_dbp) exposure(y15_cte) mediator(y18_alcohol) post_confs(y15_activity y15_bmi) base_confs(sex ethnicity msmoking malcohol meduc fincome birthday) ///
commands(y18_dbp:regress, y18_alcohol:logit, y15_activity:regress, y15_bmi:regress) ///
equations(y18_dbp: y15_cte y18_alcohol y15_bmi y15_activity i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday, y18_alcohol: y15_cte y15_bmi y15_activity i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday, y15_activity: y15_cte i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday, y15_bmi: y15_cte y15_activity i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday) ///
control(y18_alcohol:0) linexp ///
samples(50) seed(79) moreMC sim(10000) minsim

*smoking
//unadjusted
gformula y18_dbp y15_cte y18_smoking, ///
mediation outcome(y18_dbp) exposure(y15_cte) mediator(y18_smoking) ///
commands(y18_dbp:regress, y18_smoking:logit) ///
equations(y18_dbp: y15_cte y18_smoking, y18_smoking: y15_cte) ///
control(y18_smoking:0) linexp  ///
samples(50) seed(79) moreMC sim(10000) minsim

//adjusted
gformula y18_dbp y15_cte y18_smoking y15_activity y15_bmi sex ethnicity msmoking malcohol meduc fincome birthday, ///
mediation outcome(y18_dbp) exposure(y15_cte) mediator(y18_smoking) post_confs(y15_activity y15_bmi) base_confs(sex ethnicity msmoking malcohol meduc fincome birthday) ///
commands(y18_dbp:regress, y18_smoking:logit, y15_activity:regress, y15_bmi:regress) ///
equations(y18_dbp: y15_cte y18_smoking y15_bmi y15_activity i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday, y18_smoking: y15_cte y15_bmi y15_activity i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday, y15_activity: y15_cte i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday, y15_bmi: y15_cte y15_activity i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday) ///
control(y18_smoking:0) linexp ///
samples(50) seed(79) moreMC sim(10000) minsim

*drug use
//unadjusted
gformula y18_dbp y15_cte y18_druguse, ///
mediation outcome(y18_dbp) exposure(y15_cte) mediator(y18_druguse) ///
commands(y18_dbp:regress, y18_druguse:logit) ///
equations(y18_dbp: y15_cte y18_druguse, y18_druguse: y15_cte) ///
control(y18_druguse:0) linexp  ///
samples(50) seed(79) moreMC sim(10000) minsim

//adjusted
gformula y18_dbp y15_cte y18_druguse y15_activity y15_bmi sex ethnicity msmoking malcohol meduc fincome birthday, ///
mediation outcome(y18_dbp) exposure(y15_cte) mediator(y18_druguse) post_confs(y15_activity y15_bmi) base_confs(sex ethnicity msmoking malcohol meduc fincome birthday) ///
commands(y18_dbp:regress, y18_druguse:logit, y15_activity:regress, y15_bmi:regress) ///
equations(y18_dbp: y15_cte y18_druguse y15_bmi y15_activity i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday, y18_druguse: y15_cte y15_bmi y15_activity i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday, y15_activity: y15_cte i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday, y15_bmi: y15_cte y15_activity i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday) ///
control(y18_druguse:0) linexp ///
samples(50) seed(79) moreMC sim(10000) minsim
