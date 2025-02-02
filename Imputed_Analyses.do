******************************************************************
*       Childhood trauma, adolescent risk behaviours, &          *
* cardiovascular health indices in the 2004 Pelotas Birth Cohort *
******************************************************************

********************
* IMPUTED ANALYSES *
********************

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

* TABLE 1: SAMPLE CHARACTERISTICS ACCORDING TO TRAUMA EXPOSURE STATUS AT AGE 18 *

* model 4 *
//total sample 
mi estimate: proportion y18_alltrauma
mi estimate: proportion sex
mi estimate: proportion ethnicity
mi estimate: proportion msmoking
mi estimate: proportion malcohol
mi estimate: proportion y18_alcohol
mi estimate: proportion y18_smoking
mi estimate: proportion y18_druguse
mi estimate: mean fincome
mi estimate: mean meduc
mi estimate: mean birthday
mi estimate: mean y18_sleepdur

//unexposed
foreach var of varlist sex ethnicity msmoking malcohol y18_alcohol y18_smoking y18_druguse {
	mi estimate, esampvaryok: proportion `var' if y18_alltrauma==0
}
foreach var of varlist fincome meduc birthday y18_sleepdur {
	mi estimate, esampvaryok: mean `var' if y18_alltrauma==0
}

//exposed
foreach var of varlist sex ethnicity msmoking malcohol y18_alcohol y18_smoking y18_druguse {
	mi estimate, esampvaryok: proportion `var' if y18_alltrauma==1
}
foreach var of varlist fincome meduc birthday y18_sleepdur {
	mi estimate, esampvaryok: mean `var' if y18_alltrauma==1
}

//trauma-confounder associations
mi estimate, or: logistic y18_alltrauma i.sex 
mi estimate, or: logistic y18_alltrauma ib2.sex
mi estimate, or: logistic y18_alltrauma i.ethnicity 
mi estimate, or: logistic y18_alltrauma ib2.ethnicity 
mi estimate, or: logistic y18_alltrauma i.msmoking 
mi estimate, or: logistic y18_alltrauma i.malcohol 
mi estimate, or: logistic y18_alltrauma i.y18_alcohol
mi estimate, or: logistic y18_alltrauma i.y18_smoking
mi estimate, or: logistic y18_alltrauma i.y18_druguse
mi estimate: regress fincome y18_alltrauma
mi estimate: regress meduc y18_alltrauma
mi estimate: regress birthday y18_alltrauma
mi estimate: regress y18_sleepdur y18_alltrauma

**********************************************************

* TABLE 2: CROSS-SECTIONAL AND LONGITUDINAL ASSOCIATIONS BETWEEN CUMULATIVE TRAUMA UP TO AGES 11, 15, AND 18 AND ADOLESCENT RISK BEHAVIOURS AT AGE 18 *

* model 1 - cross-sectional *
//unadjusted
mi estimate, or: logistic y18_alcohol y18_cte
mi estimate, or: logistic y18_smoking y18_cte
mi estimate, or: logistic y18_druguse y18_cte
mi estimate: regress y18_sleepdur y18_cte
//adjusted
mi estimate, or: logistic y18_alcohol y18_cte i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday
mi estimate, or: logistic y18_smoking y18_cte i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday
mi estimate, or: logistic y18_druguse y18_cte i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday
mi estimate: regress y18_sleepdur y18_cte i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday

* model 2 - longitudinal: age 11 cte *
//unadjusted
mi estimate, or: logistic y18_alcohol y11_cte
mi estimate, or: logistic y18_smoking y11_cte
mi estimate, or: logistic y18_druguse y11_cte
mi estimate: regress y18_sleepdur y11_cte
//adjusted
mi estimate, or: logistic y18_alcohol y11_cte i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday
mi estimate, or: logistic y18_smoking y11_cte i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday
mi estimate, or: logistic y18_druguse y11_cte i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday
mi estimate: regress y18_sleepdur y11_cte i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday

* model 3 - longitudinal: age 15 cte *
//unadjusted
mi estimate, or: logistic y18_alcohol y15_cte
mi estimate, or: logistic y18_smoking y15_cte
mi estimate, or: logistic y18_druguse y15_cte
mi estimate: regress y18_sleepdur y15_cte
//adjusted
mi estimate, or: logistic y18_alcohol y15_cte i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday
mi estimate, or: logistic y18_smoking y15_cte i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday
mi estimate, or: logistic y18_druguse y15_cte i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday
mi estimate: regress y18_sleepdur y15_cte i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday

**********************************************************

* IMPUTED SEX DIFFERENCES *

* model 1 - cross-sectional *
mi estimate, or: logistic y18_alcohol c.y18_cte##i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday
mi estimate, or: logistic y18_smoking c.y18_cte##i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday
mi estimate, or: logistic y18_druguse c.y18_cte##i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday
mi estimate: regress y18_sleepdur c.y18_cte##i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday
*significant interaction effects for drug use
mi estimate, or: logistic y18_druguse y18_cte i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday if sex==0
mi estimate, or: logistic y18_druguse y18_cte i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday if sex==1

* model 2 - longitudinal: age 11 cte *
mi estimate, or: logistic y18_alcohol c.y11_cte##i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday
mi estimate, or: logistic y18_smoking c.y11_cte##i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday
mi estimate, or: logistic y18_druguse c.y11_cte##i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday
mi estimate: regress y18_sleepdur c.y11_cte##i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday
*significant interaction effects for drug use
mi estimate, or: logistic y18_druguse y11_cte i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday if sex==0
mi estimate, or: logistic y18_druguse y11_cte i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday if sex==1

* model 3 - longitudinal: age 15 cte *
mi estimate, or: logistic y18_alcohol c.y15_cte##i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday
mi estimate, or: logistic y18_smoking c.y15_cte##i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday
mi estimate, or: logistic y18_druguse c.y15_cte##i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday
mi estimate: regress y18_sleepdur c.y15_cte##i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday
*significant interaction effects for smoking
mi estimate, or: logistic y18_smoking y15_cte i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday if sex==0
mi estimate, or: logistic y18_smoking y15_cte i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday if sex==1

**********************************************************

* POPULATION ATTRIBUTABLE FRACTIONS *

* model 4 *
putexcel set "080424_PAFimp_MB", sheet("y18") modify
putexcel A1="Outcome" B1="beta" C1="SE" D1="P Value" E1="RR" F1="LCI" G1= "UCI" H1="PAF" I1="LPAF" J1="UPAF" K1="pc"

global outcome "y18_alcohol y18_smoking y18_druguse"
local x=1

foreach out of global outcome{
	use "[pathname]/080424_miM4_MB.dta", clear
	
	mi estimate: glm `out' y18_alltrauma i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday, family(poisson) link(log) nolog vce(robust)
	mi estimate, post

	local beta = _b[y18_alltrauma]
	local se = _se[y18_alltrauma]
	test y18_alltrauma
	local pvalue = `r(p)'
	
	bysort _mi_m `out': egen denom = count(idnum) if _mi_m!=0
	bysort _mi_m `out': egen num2 = count(idnum) if _mi_m!=0 & y18_alltrauma==1
	bysort _mi_m `out': egen num = min(num2)
	gen prop = num/denom if _mi_m!= 0
	bysort _mi_m `out': egen seq = seq() if _mi_m!=0 
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

* TABLE 3: CROSS-SECTIONAL ASSOCIATIONS BETWEEN ADOLESCENT RISK BEHAVIOURS AT AGE 18 AND RESTING HR, SBP, AND DBP AT AGE 18

* model 5 *
//alcohol use
mi estimate: regress y18_hr y18_alcohol
mi estimate: regress y18_sbp y18_alcohol
mi estimate: regress y18_dbp y18_alcohol
mi estimate: regress y18_hr y18_alcohol y15_cte y15_activity y15_bmi sex ethnicity msmoking malcohol meduc fincome birthday
mi estimate: regress y18_sbp y18_alcohol y15_cte y15_activity y15_bmi sex ethnicity msmoking malcohol meduc fincome birthday
mi estimate: regress y18_dbp y18_alcohol y15_cte y15_activity y15_bmi sex ethnicity msmoking malcohol meduc fincome birthday
//smoking
mi estimate: regress y18_hr y18_smoking
mi estimate: regress y18_sbp y18_smoking
mi estimate: regress y18_dbp y18_smoking
mi estimate: regress y18_hr y18_smoking y15_cte y15_activity y15_bmi sex ethnicity msmoking malcohol meduc fincome birthday
mi estimate: regress y18_sbp y18_smoking y15_cte y15_activity y15_bmi sex ethnicity msmoking malcohol meduc fincome birthday
mi estimate: regress y18_dbp y18_smoking y15_cte y15_activity y15_bmi sex ethnicity msmoking malcohol meduc fincome birthday
//drug use
mi estimate: regress y18_hr y18_druguse
mi estimate: regress y18_sbp y18_druguse
mi estimate: regress y18_dbp y18_druguse
mi estimate: regress y18_hr y18_druguse y15_cte y15_activity y15_bmi sex ethnicity msmoking malcohol meduc fincome birthday
mi estimate: regress y18_sbp y18_druguse y15_cte y15_activity y15_bmi sex ethnicity msmoking malcohol meduc fincome birthday
mi estimate: regress y18_dbp y18_druguse y15_cte y15_activity y15_bmi sex ethnicity msmoking malcohol meduc fincome birthday
//sleep duration
mi estimate: regress y18_hr y18_sleepdur
mi estimate: regress y18_sbp y18_sleepdur
mi estimate: regress y18_dbp y18_sleepdur
mi estimate: regress y18_hr y18_sleepdur y15_cte y15_activity y15_bmi sex ethnicity msmoking malcohol meduc fincome birthday
mi estimate: regress y18_sbp y18_sleepdur y15_cte y15_activity y15_bmi sex ethnicity msmoking malcohol meduc fincome birthday
mi estimate: regress y18_dbp y18_sleepdur y15_cte y15_activity y15_bmi sex ethnicity msmoking malcohol meduc fincome birthday

**********************************************************

* TABLE 4: MEDIATION MODELS OF THE RELATIONSHIP BETWEEN CUMULATIVE TRAUMA UP TO AGE 15 AND RESTING HR, SBP, AND DBP AT AGE 18 THROUGH MEDIATING SUBSTANCE USE BEHAVIOURS (PROBLEMATIC ALCOHOL USE, SMOKING, AND ILLICIT DRUG USE; SIMULTANEOUSLY INCLUDED IN THE MODELS) *

* model 5 *
* HR unadjusted
log using "gformula_imp_HRunadj.log", replace

forvalues impdata = 1/50 { 
	use 300424_miM5_MB, clear
	di "`impdata'"
	keep if _mi_m==`impdata'
	
gformula y18_hr y15_cte y18_alcohol y18_smoking y18_druguse, ///
mediation outcome(y18_hr) exposure(y15_cte) mediator (y18_alcohol y18_smoking y18_druguse) ///
commands(y18_hr:regress, y18_alcohol:logit, y18_smoking:logit, y18_druguse:logit) ///
equations(y18_hr: y15_cte y18_alcohol y18_smoking y18_druguse, y18_alcohol: y15_cte, y18_smoking: y15_cte, y18_druguse: y15_cte) ///
control(y18_alcohol:0, y18_smoking:0, y18_druguse:0) linexp  ///
samples(50) seed(79) moreMC sim(10000) minsim
}

log close

//extract estimates and standard errors for the TCE, NDE, and NIE from the log file gformula_imp_HRunadj - save in a new stata dataset
* existing variables: 
*tce nde nie pm (effect estimates)
*tce_bse nde_bse nie_bse pm_bse (SEs)

* create copies called x_b
clonevar pm_b = pm 
clonevar nde_b = nde
clonevar nie_b = nie 
clonevar tce_b = tce

for any pm_ nde_ nie_ tce_: gen Xvar = Xbse^2

renvars pm nde nie tce / pm_mn nde_mn nie_mn tce_mn
renvars pm_var nde_var nie_var tce_var / pm_w nde_w nie_w tce_w

collapse (mean) pm_mn nde_mn nie_mn tce_mn pm_w nde_w nie_w tce_w (sd) pm_b nde_b nie_b tce_b
for var pm_b nde_b nie_b tce_b: replace X = X^2
for any pm_ nde_ nie_ tce_: gen Xtotvar = Xw + (1 + 1/50)*Xb

for any pm_ nde_ nie_ tce_: gen Xtotse = Xtotvar^0.5

list pm_mn pm_totse 
list nde_mn nde_totse 
list nie_mn nie_totse 
list tce_mn tce_totse

* HR adjusted
log using "gformula_imp_HRadj.log", replace

forvalues impdata = 1/50 { 
	use 300424_miM5_MB, clear
	di "`impdata'"
	keep if _mi_m==`impdata'
	
gformula y18_hr y15_cte y18_alcohol y18_smoking y18_druguse y15_activity y15_bmi sex ethnicity msmoking malcohol meduc fincome birthday, ///
mediation outcome(y18_hr) exposure(y15_cte) mediator(y18_alcohol y18_smoking y18_druguse) post_confs(y15_activity y15_bmi) base_confs(sex ethnicity msmoking malcohol meduc fincome birthday) ///
commands(y18_hr:regress, y18_alcohol:logit, y18_smoking:logit, y18_druguse:logit, y15_activity:regress, y15_bmi:regress) ///
equations(y18_hr: y15_cte y18_alcohol y18_smoking y18_druguse y15_bmi y15_activity i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday, y18_alcohol: y15_cte y15_bmi y15_activity i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday, y18_smoking: y15_cte y15_bmi y15_activity i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday, y18_druguse: y15_cte y15_bmi y15_activity i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday, y15_activity: y15_cte i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday, y15_bmi: y15_cte y15_activity i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday) ///
control(y18_alcohol:0, y18_smoking:0, y18_druguse:0) linexp ///
samples(50) seed(79) moreMC sim(10000) minsim
}

log close

//extract estimates and standard errors for the TCE, NDE, and NIE from the log file gformula_imp_HRadj - save in a new stata dataset
* existing variables: 
*tce nde nie pm (effect estimates)
*tce_bse nde_bse nie_bse pm_bse (SEs)

* create copies called x_b
clonevar pm_b = pm 
clonevar nde_b = nde
clonevar nie_b = nie 
clonevar tce_b = tce

for any pm_ nde_ nie_ tce_: gen Xvar = Xbse^2

renvars pm nde nie tce / pm_mn nde_mn nie_mn tce_mn
renvars pm_var nde_var nie_var tce_var / pm_w nde_w nie_w tce_w

collapse (mean) pm_mn nde_mn nie_mn tce_mn pm_w nde_w nie_w tce_w (sd) pm_b nde_b nie_b tce_b
for var pm_b nde_b nie_b tce_b: replace X = X^2
for any pm_ nde_ nie_ tce_: gen Xtotvar = Xw + (1 + 1/50)*Xb

for any pm_ nde_ nie_ tce_: gen Xtotse = Xtotvar^0.5

list pm_mn pm_totse 
list nde_mn nde_totse 
list nie_mn nie_totse 
list tce_mn tce_totse

*sBP unadjusted
log using "gformula_imp_sBPunadj.log", replace

forvalues impdata = 1/50 { 
	use 300424_miM5_MB, clear
	di "`impdata'"
	keep if _mi_m==`impdata'
	
gformula y18_sbp y15_cte y18_alcohol y18_smoking y18_druguse, ///
mediation outcome(y18_sbp) exposure(y15_cte) mediator (y18_alcohol y18_smoking y18_druguse) ///
commands(y18_sbp:regress, y18_alcohol:logit, y18_smoking:logit, y18_druguse:logit) ///
equations(y18_sbp: y15_cte y18_alcohol y18_smoking y18_druguse, y18_alcohol: y15_cte, y18_smoking: y15_cte, y18_druguse: y15_cte) ///
control(y18_alcohol:0, y18_smoking:0, y18_druguse:0) linexp  ///
samples(50) seed(79) moreMC sim(10000) minsim
}

log close

//extract estimates and standard errors for the TCE, NDE, and NIE from the log file gformula_imp_sBPunadj - save in a new stata dataset
* existing variables: 
*tce nde nie pm (effect estimates)
*tce_bse nde_bse nie_bse pm_bse (SEs)

* create copies called x_b
clonevar pm_b = pm 
clonevar nde_b = nde
clonevar nie_b = nie 
clonevar tce_b = tce

for any pm_ nde_ nie_ tce_: gen Xvar = Xbse^2

renvars pm nde nie tce / pm_mn nde_mn nie_mn tce_mn
renvars pm_var nde_var nie_var tce_var / pm_w nde_w nie_w tce_w

collapse (mean) pm_mn nde_mn nie_mn tce_mn pm_w nde_w nie_w tce_w (sd) pm_b nde_b nie_b tce_b
for var pm_b nde_b nie_b tce_b: replace X = X^2
for any pm_ nde_ nie_ tce_: gen Xtotvar = Xw + (1 + 1/50)*Xb

for any pm_ nde_ nie_ tce_: gen Xtotse = Xtotvar^0.5

list pm_mn pm_totse 
list nde_mn nde_totse 
list nie_mn nie_totse 
list tce_mn tce_totse

*sBP adjusted
log using "gformula_imp_sBPadj.log", replace

forvalues impdata = 1/50 { 
	use 300424_miM5_MB, clear
	di "`impdata'"
	keep if _mi_m==`impdata'
	
gformula y18_sbp y15_cte y18_alcohol y18_smoking y18_druguse y15_activity y15_bmi sex ethnicity msmoking malcohol meduc fincome birthday, ///
mediation outcome(y18_sbp) exposure(y15_cte) mediator(y18_alcohol y18_smoking y18_druguse) post_confs(y15_activity y15_bmi) base_confs(sex ethnicity msmoking malcohol meduc fincome birthday) ///
commands(y18_sbp:regress, y18_alcohol:logit, y18_smoking:logit, y18_druguse:logit, y15_activity:regress, y15_bmi:regress) ///
equations(y18_sbp: y15_cte y18_alcohol y18_smoking y18_druguse y15_bmi y15_activity i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday, y18_alcohol: y15_cte y15_bmi y15_activity i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday, y18_smoking: y15_cte y15_bmi y15_activity i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday, y18_druguse: y15_cte y15_bmi y15_activity i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday, y15_activity: y15_cte i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday, y15_bmi: y15_cte y15_activity i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday) ///
control(y18_alcohol:0, y18_smoking:0, y18_druguse:0) linexp ///
samples(50) seed(79) moreMC sim(10000) minsim
}

log close

//extract estimates and standard errors for the TCE, NDE, and NIE from the log file gformula_imp_sBPadj - save in a new stata dataset
* existing variables: 
*tce nde nie pm (effect estimates)
*tce_bse nde_bse nie_bse pm_bse (SEs)

* create copies called x_b
clonevar pm_b = pm 
clonevar nde_b = nde
clonevar nie_b = nie 
clonevar tce_b = tce

for any pm_ nde_ nie_ tce_: gen Xvar = Xbse^2

renvars pm nde nie tce / pm_mn nde_mn nie_mn tce_mn
renvars pm_var nde_var nie_var tce_var / pm_w nde_w nie_w tce_w

collapse (mean) pm_mn nde_mn nie_mn tce_mn pm_w nde_w nie_w tce_w (sd) pm_b nde_b nie_b tce_b
for var pm_b nde_b nie_b tce_b: replace X = X^2
for any pm_ nde_ nie_ tce_: gen Xtotvar = Xw + (1 + 1/50)*Xb

for any pm_ nde_ nie_ tce_: gen Xtotse = Xtotvar^0.5

list pm_mn pm_totse 
list nde_mn nde_totse 
list nie_mn nie_totse 
list tce_mn tce_totse

*dBP unadjusted
log using "gformula_imp_dBPunadj.log", replace

forvalues impdata = 1/50 { 
	use 300424_miM5_MB, clear
	di "`impdata'"
	keep if _mi_m==`impdata'
	
gformula y18_dbp y15_cte y18_alcohol y18_smoking y18_druguse, ///
mediation outcome(y18_dbp) exposure(y15_cte) mediator (y18_alcohol y18_smoking y18_druguse) ///
commands(y18_dbp:regress, y18_alcohol:logit, y18_smoking:logit, y18_druguse:logit) ///
equations(y18_dbp: y15_cte y18_alcohol y18_smoking y18_druguse, y18_alcohol: y15_cte, y18_smoking: y15_cte, y18_druguse: y15_cte) ///
control(y18_alcohol:0, y18_smoking:0, y18_druguse:0) linexp  ///
samples(50) seed(79) moreMC sim(10000) minsim
}

log close

//extract estimates and standard errors for the TCE, NDE, and NIE from the log file gformula_imp_dBPunadj - save in a new stata dataset
* existing variables: 
*tce nde nie pm (effect estimates)
*tce_bse nde_bse nie_bse pm_bse (SEs)

* create copies called x_b
clonevar pm_b = pm 
clonevar nde_b = nde
clonevar nie_b = nie 
clonevar tce_b = tce

for any pm_ nde_ nie_ tce_: gen Xvar = Xbse^2

renvars pm nde nie tce / pm_mn nde_mn nie_mn tce_mn
renvars pm_var nde_var nie_var tce_var / pm_w nde_w nie_w tce_w

collapse (mean) pm_mn nde_mn nie_mn tce_mn pm_w nde_w nie_w tce_w (sd) pm_b nde_b nie_b tce_b
for var pm_b nde_b nie_b tce_b: replace X = X^2
for any pm_ nde_ nie_ tce_: gen Xtotvar = Xw + (1 + 1/50)*Xb

for any pm_ nde_ nie_ tce_: gen Xtotse = Xtotvar^0.5

list pm_mn pm_totse 
list nde_mn nde_totse 
list nie_mn nie_totse 
list tce_mn tce_totse

*dBP adjusted
log using "gformula_imp_dBPadj.log", replace

forvalues impdata = 1/50 { 
	use 300424_miM5_MB, clear
	di "`impdata'"
	keep if _mi_m==`impdata'
	
gformula y18_dbp y15_cte y18_alcohol y18_smoking y18_druguse y15_activity y15_bmi sex ethnicity msmoking malcohol meduc fincome birthday, ///
mediation outcome(y18_dbp) exposure(y15_cte) mediator(y18_alcohol y18_smoking y18_druguse) post_confs(y15_activity y15_bmi) base_confs(sex ethnicity msmoking malcohol meduc fincome birthday) ///
commands(y18_dbp:regress, y18_alcohol:logit, y18_smoking:logit, y18_druguse:logit, y15_activity:regress, y15_bmi:regress) ///
equations(y18_dbp: y15_cte y18_alcohol y18_smoking y18_druguse y15_bmi y15_activity i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday, y18_alcohol: y15_cte y15_bmi y15_activity i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday, y18_smoking: y15_cte y15_bmi y15_activity i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday, y18_druguse: y15_cte y15_bmi y15_activity i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday, y15_activity: y15_cte i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday, y15_bmi: y15_cte y15_activity i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday) ///
control(y18_alcohol:0, y18_smoking:0, y18_druguse:0) linexp ///
samples(50) seed(79) moreMC sim(10000) minsim
}

log close

//extract estimates and standard errors for the TCE, NDE, and NIE from the log file gformula_imp_dBPadj - save in a new stata dataset
* existing variables: 
*tce nde nie pm (effect estimates)
*tce_bse nde_bse nie_bse pm_bse (SEs)

* create copies called x_b
clonevar pm_b = pm 
clonevar nde_b = nde
clonevar nie_b = nie 
clonevar tce_b = tce

for any pm_ nde_ nie_ tce_: gen Xvar = Xbse^2

renvars pm nde nie tce / pm_mn nde_mn nie_mn tce_mn
renvars pm_var nde_var nie_var tce_var / pm_w nde_w nie_w tce_w

collapse (mean) pm_mn nde_mn nie_mn tce_mn pm_w nde_w nie_w tce_w (sd) pm_b nde_b nie_b tce_b
for var pm_b nde_b nie_b tce_b: replace X = X^2
for any pm_ nde_ nie_ tce_: gen Xtotvar = Xw + (1 + 1/50)*Xb

for any pm_ nde_ nie_ tce_: gen Xtotse = Xtotvar^0.5

list pm_mn pm_totse 
list nde_mn nde_totse 
list nie_mn nie_totse 
list tce_mn tce_totse

**********************************************************

* APPENDIX 2 TABLE S1 - CROSS-SECTIONAL ASSOCIATIONS BETWEEN TRAUMA EXPOSURE UP TO AGE 18, CODED AS A BINARY VARIABLE, AND ADOLESCENT RISK BEHAVIOURS AT AGE 18 *

* model 4 *
//total sample 
mi estimate: proportion y18_alltrauma
mi estimate: proportion y18_alcohol
mi estimate: proportion y18_smoking
mi estimate: proportion y18_druguse
mi estimate: mean y18_sleepdur

//unexposed
foreach var of varlist y18_alcohol y18_smoking y18_druguse {
	mi estimate, esampvaryok: proportion `var' if y18_alltrauma==0
}
mi estimate, esampvaryok: mean y18_sleepdur if y18_alltrauma==0

//exposed
foreach var of varlist y18_alcohol y18_smoking y18_druguse {
	mi estimate, esampvaryok: proportion `var' if y18_alltrauma==1
}
mi estimate, esampvaryok: mean y18_sleepdur if y18_alltrauma==1

//trauma-risk behaviour associations
mi estimate, or: logistic y18_alcohol y18_alltrauma
mi estimate, or: logistic y18_smoking y18_alltrauma
mi estimate, or: logistic y18_druguse y18_alltrauma
mi estimate: regress y18_sleepdur y18_alltrauma

**********************************************************

* APPENDIX 2 TABLE S2 - DESCRIPTIVE STATISTICS FOR ADOLESCENT RISK BEHAVIOURS AND CARDIOVASCULAR HEALTH INDICES ACCORDING TO CUMULATIVE TRAUMA EXPOSURE UP TO AGE 15 *

* model 5 *
//total sample
mi estimate: proportion y15_cte
foreach var of varlist y18_alcohol y18_smoking y18_druguse {
	mi estimate, esampvaryok: proportion `var'
}
foreach var of varlist y18_sleepdur y18_hr y18_sbp y18_dbp y15_activity y15_bmi {
	mi estimate, esampvaryok: mean `var'
}
//unexposed
foreach var of varlist y18_alcohol y18_smoking y18_druguse {
	mi estimate, esampvaryok: proportion `var' if y15_cte==0
}
foreach var of varlist y18_sleepdur y18_hr y18_sbp y18_dbp y15_activity y15_bmi {
	mi estimate, esampvaryok: mean `var' if y15_cte==0
}
//1 trauma
foreach var of varlist y18_alcohol y18_smoking y18_druguse {
	mi estimate, esampvaryok: proportion `var' if y15_cte==1
}
foreach var of varlist y18_sleepdur y18_hr y18_sbp y18_dbp y15_activity y15_bmi {
	mi estimate, esampvaryok: mean `var' if y15_cte==1
}
//2 traumas
foreach var of varlist y18_alcohol y18_smoking y18_druguse {
	mi estimate, esampvaryok: proportion `var' if y15_cte==2
}
foreach var of varlist y18_sleepdur y18_hr y18_sbp y18_dbp y15_activity y15_bmi {
	mi estimate, esampvaryok: mean `var' if y15_cte==2
}
//≥3 traumas
foreach var of varlist y18_alcohol y18_smoking y18_druguse {
	mi estimate, esampvaryok: proportion `var' if y15_cte==3
}
foreach var of varlist y18_sleepdur y18_hr y18_sbp y18_dbp y15_activity y15_bmi {
	mi estimate, esampvaryok: mean `var' if y15_cte==3
}

**********************************************************

* APPENDIX 2 TABLE S3 - MEDIATION MODELS OF THE RELATIONSHIP BETWEEN CUMULATIVE TRAUMA UP TO AGE 15 AND RESTING HEART RATE AT AGE 18 THROUGH MEDIATING SUBSTANCE USE BEHAVIOURS (PROBLEMATIC ALCOHOL USE, SMOKING, AND ILLICIT DRUG USE; INCLUDED INDIVIDUALLY) *

* model 5 *
* unadjusted - alcohol use
log using "gformula_imp_HRunadj_alc.log", replace

forvalues impdata = 1/50 { 
	use 300424_miM5_MB, clear
	di "`impdata'"
	keep if _mi_m==`impdata'
	
gformula y18_hr y15_cte y18_alcohol, ///
mediation outcome(y18_hr) exposure(y15_cte) mediator(y18_alcohol) ///
commands(y18_hr:regress, y18_alcohol:logit) ///
equations(y18_hr: y15_cte y18_alcohol, y18_alcohol: y15_cte) ///
control(y18_alcohol:0) linexp  ///
samples(50) seed(79) moreMC sim(10000) minsim
}

log close

*extract estimates and SEs from log file into an excel file - upload excel file and save
clonevar pm_b = pm 
clonevar nde_b = nde
clonevar nie_b = nie 
clonevar tce_b = tce

for any pm_ nde_ nie_ tce_: gen Xvar = Xbse^2

renvars pm nde nie tce / pm_mn nde_mn nie_mn tce_mn
renvars pm_var nde_var nie_var tce_var / pm_w nde_w nie_w tce_w

collapse (mean) pm_mn nde_mn nie_mn tce_mn pm_w nde_w nie_w tce_w (sd) pm_b nde_b nie_b tce_b
for var pm_b nde_b nie_b tce_b: replace X = X^2
for any pm_ nde_ nie_ tce_: gen Xtotvar = Xw + (1 + 1/50)*Xb

for any pm_ nde_ nie_ tce_: gen Xtotse = Xtotvar^0.5

list pm_mn pm_totse 
list nde_mn nde_totse 
list nie_mn nie_totse 
list tce_mn tce_totse

* unadjusted - smoking
log using "gformula_imp_HRunadj_smoking.log", replace

forvalues impdata = 1/50 { 
	use 300424_miM5_MB, clear
	di "`impdata'"
	keep if _mi_m==`impdata'
	
gformula y18_hr y15_cte y18_smoking, ///
mediation outcome(y18_hr) exposure(y15_cte) mediator(y18_smoking) ///
commands(y18_hr:regress, y18_smoking:logit) ///
equations(y18_hr: y15_cte y18_smoking, y18_smoking: y15_cte) ///
control(y18_smoking:0) linexp  ///
samples(50) seed(79) moreMC sim(10000) minsim
}

log close

*extract estimates and SEs from log file into an excel file - upload excel file and save
clonevar pm_b = pm 
clonevar nde_b = nde
clonevar nie_b = nie 
clonevar tce_b = tce

for any pm_ nde_ nie_ tce_: gen Xvar = Xbse^2

renvars pm nde nie tce / pm_mn nde_mn nie_mn tce_mn
renvars pm_var nde_var nie_var tce_var / pm_w nde_w nie_w tce_w

collapse (mean) pm_mn nde_mn nie_mn tce_mn pm_w nde_w nie_w tce_w (sd) pm_b nde_b nie_b tce_b
for var pm_b nde_b nie_b tce_b: replace X = X^2
for any pm_ nde_ nie_ tce_: gen Xtotvar = Xw + (1 + 1/50)*Xb

for any pm_ nde_ nie_ tce_: gen Xtotse = Xtotvar^0.5

list pm_mn pm_totse 
list nde_mn nde_totse 
list nie_mn nie_totse 
list tce_mn tce_totse

* unadjusted - drug use
log using "gformula_imp_HRunadj_druguse.log", replace

forvalues impdata = 1/50 { 
	use 300424_miM5_MB, clear
	di "`impdata'"
	keep if _mi_m==`impdata'
	
gformula y18_hr y15_cte y18_druguse, ///
mediation outcome(y18_hr) exposure(y15_cte) mediator(y18_druguse) ///
commands(y18_hr:regress, y18_druguse:logit) ///
equations(y18_hr: y15_cte y18_druguse, y18_druguse: y15_cte) ///
control(y18_druguse:0) linexp  ///
samples(50) seed(79) moreMC sim(10000) minsim
}

log close

*extract estimates and SEs from log file into an excel file - upload excel file and save
clonevar pm_b = pm 
clonevar nde_b = nde
clonevar nie_b = nie 
clonevar tce_b = tce

for any pm_ nde_ nie_ tce_: gen Xvar = Xbse^2

renvars pm nde nie tce / pm_mn nde_mn nie_mn tce_mn
renvars pm_var nde_var nie_var tce_var / pm_w nde_w nie_w tce_w

collapse (mean) pm_mn nde_mn nie_mn tce_mn pm_w nde_w nie_w tce_w (sd) pm_b nde_b nie_b tce_b
for var pm_b nde_b nie_b tce_b: replace X = X^2
for any pm_ nde_ nie_ tce_: gen Xtotvar = Xw + (1 + 1/50)*Xb

for any pm_ nde_ nie_ tce_: gen Xtotse = Xtotvar^0.5

list pm_mn pm_totse 
list nde_mn nde_totse 
list nie_mn nie_totse 
list tce_mn tce_totse

* adjusted - alcohol 
log using "gformula_imp_HRadj_alc.log", replace

forvalues impdata = 1/50 { 
	use 300424_miM5_MB, clear
	di "`impdata'"
	keep if _mi_m==`impdata'
	
gformula y18_hr y15_cte y18_alcohol y15_activity y15_bmi sex ethnicity msmoking malcohol meduc fincome birthday, ///
mediation outcome(y18_hr) exposure(y15_cte) mediator(y18_alcohol) post_confs(y15_activity y15_bmi) base_confs(sex ethnicity msmoking malcohol meduc fincome birthday) ///
commands(y18_hr:regress, y18_alcohol:logit, y15_activity:regress, y15_bmi:regress) ///
equations(y18_hr: y15_cte y18_alcohol y15_bmi y15_activity i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday, y18_alcohol: y15_cte y15_bmi y15_activity i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday, y15_activity: y15_cte i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday, y15_bmi: y15_cte y15_activity i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday) ///
control(y18_alcohol:0) linexp ///
samples(50) seed(79) moreMC sim(10000) minsim
}

log close

*extract estimates and SEs from log file into an excel file - upload excel file and save
clonevar pm_b = pm 
clonevar nde_b = nde
clonevar nie_b = nie 
clonevar tce_b = tce

for any pm_ nde_ nie_ tce_: gen Xvar = Xbse^2

renvars pm nde nie tce / pm_mn nde_mn nie_mn tce_mn
renvars pm_var nde_var nie_var tce_var / pm_w nde_w nie_w tce_w

collapse (mean) pm_mn nde_mn nie_mn tce_mn pm_w nde_w nie_w tce_w (sd) pm_b nde_b nie_b tce_b
for var pm_b nde_b nie_b tce_b: replace X = X^2
for any pm_ nde_ nie_ tce_: gen Xtotvar = Xw + (1 + 1/50)*Xb

for any pm_ nde_ nie_ tce_: gen Xtotse = Xtotvar^0.5

list pm_mn pm_totse 
list nde_mn nde_totse 
list nie_mn nie_totse 
list tce_mn tce_totse

* adjusted - smoking 
log using "gformula_imp_HRadj_smoking.log", replace

forvalues impdata = 1/50 { 
	use 300424_miM5_MB, clear
	di "`impdata'"
	keep if _mi_m==`impdata'
	
gformula y18_hr y15_cte y18_smoking y15_activity y15_bmi sex ethnicity msmoking malcohol meduc fincome birthday, ///
mediation outcome(y18_hr) exposure(y15_cte) mediator(y18_smoking) post_confs(y15_activity y15_bmi) base_confs(sex ethnicity msmoking malcohol meduc fincome birthday) ///
commands(y18_hr:regress, y18_smoking:logit, y15_activity:regress, y15_bmi:regress) ///
equations(y18_hr: y15_cte y18_smoking y15_bmi y15_activity i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday, y18_smoking: y15_cte y15_bmi y15_activity i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday, y15_activity: y15_cte i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday, y15_bmi: y15_cte y15_activity i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday) ///
control(y18_smoking:0) linexp ///
samples(50) seed(79) moreMC sim(10000) minsim
}

log close

*extract estimates and SEs from log file into an excel file - upload excel file and save
clonevar pm_b = pm 
clonevar nde_b = nde
clonevar nie_b = nie 
clonevar tce_b = tce

for any pm_ nde_ nie_ tce_: gen Xvar = Xbse^2

renvars pm nde nie tce / pm_mn nde_mn nie_mn tce_mn
renvars pm_var nde_var nie_var tce_var / pm_w nde_w nie_w tce_w

collapse (mean) pm_mn nde_mn nie_mn tce_mn pm_w nde_w nie_w tce_w (sd) pm_b nde_b nie_b tce_b
for var pm_b nde_b nie_b tce_b: replace X = X^2
for any pm_ nde_ nie_ tce_: gen Xtotvar = Xw + (1 + 1/50)*Xb

for any pm_ nde_ nie_ tce_: gen Xtotse = Xtotvar^0.5

list pm_mn pm_totse 
list nde_mn nde_totse 
list nie_mn nie_totse 
list tce_mn tce_totse

* adjusted - drug use 
log using "gformula_imp_HRadj_druguse.log", replace

forvalues impdata = 1/50 { 
	use 300424_miM5_MB, clear
	di "`impdata'"
	keep if _mi_m==`impdata'
	
gformula y18_hr y15_cte y18_druguse y15_activity y15_bmi sex ethnicity msmoking malcohol meduc fincome birthday, ///
mediation outcome(y18_hr) exposure(y15_cte) mediator(y18_druguse) post_confs(y15_activity y15_bmi) base_confs(sex ethnicity msmoking malcohol meduc fincome birthday) ///
commands(y18_hr:regress, y18_druguse:logit, y15_activity:regress, y15_bmi:regress) ///
equations(y18_hr: y15_cte y18_druguse y15_bmi y15_activity i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday, y18_druguse: y15_cte y15_bmi y15_activity i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday, y15_activity: y15_cte i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday, y15_bmi: y15_cte y15_activity i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday) ///
control(y18_druguse:0) linexp ///
samples(50) seed(79) moreMC sim(10000) minsim
}

log close

*extract estimates and SEs from log file into an excel file - upload excel file and save
clonevar pm_b = pm 
clonevar nde_b = nde
clonevar nie_b = nie 
clonevar tce_b = tce

for any pm_ nde_ nie_ tce_: gen Xvar = Xbse^2

renvars pm nde nie tce / pm_mn nde_mn nie_mn tce_mn
renvars pm_var nde_var nie_var tce_var / pm_w nde_w nie_w tce_w

collapse (mean) pm_mn nde_mn nie_mn tce_mn pm_w nde_w nie_w tce_w (sd) pm_b nde_b nie_b tce_b
for var pm_b nde_b nie_b tce_b: replace X = X^2
for any pm_ nde_ nie_ tce_: gen Xtotvar = Xw + (1 + 1/50)*Xb

for any pm_ nde_ nie_ tce_: gen Xtotse = Xtotvar^0.5

list pm_mn pm_totse 
list nde_mn nde_totse 
list nie_mn nie_totse 
list tce_mn tce_totse

**********************************************************

* APPENDIX 2 TABLE S4 - MEDIATION MODELS OF THE RELATIONSHIP BETWEEN CUMULATIVE TRAUMA UP TO AGE 15 AND RESTING SYSTOLIC BLOOD PRESSURE  AT AGE 18 THROUGH MEDIATING SUBSTANCE USE BEHAVIOURS (PROBLEMATIC ALCOHOL USE, SMOKING, AND ILLICIT DRUG USE; INCLUDED INDIVIDUALLY) *

* model 5 *
* unadjusted - alcohol use
log using "gformula_imp_sBPunadj_alc.log", replace

forvalues impdata = 1/50 { 
	use 300424_miM5_MB, clear
	di "`impdata'"
	keep if _mi_m==`impdata'
	
gformula y18_sbp y15_cte y18_alcohol, ///
mediation outcome(y18_sbp) exposure(y15_cte) mediator(y18_alcohol) ///
commands(y18_sbp:regress, y18_alcohol:logit) ///
equations(y18_sbp: y15_cte y18_alcohol, y18_alcohol: y15_cte) ///
control(y18_alcohol:0) linexp  ///
samples(50) seed(79) moreMC sim(10000) minsim
}

log close

*extract estimates and SEs from log file into an excel file - upload excel file and save
clonevar pm_b = pm 
clonevar nde_b = nde
clonevar nie_b = nie 
clonevar tce_b = tce

for any pm_ nde_ nie_ tce_: gen Xvar = Xbse^2

renvars pm nde nie tce / pm_mn nde_mn nie_mn tce_mn
renvars pm_var nde_var nie_var tce_var / pm_w nde_w nie_w tce_w

collapse (mean) pm_mn nde_mn nie_mn tce_mn pm_w nde_w nie_w tce_w (sd) pm_b nde_b nie_b tce_b
for var pm_b nde_b nie_b tce_b: replace X = X^2
for any pm_ nde_ nie_ tce_: gen Xtotvar = Xw + (1 + 1/50)*Xb

for any pm_ nde_ nie_ tce_: gen Xtotse = Xtotvar^0.5

list pm_mn pm_totse 
list nde_mn nde_totse 
list nie_mn nie_totse 
list tce_mn tce_totse

* unadjusted - smoking
log using "gformula_imp_sBPunadj_smoking.log", replace

forvalues impdata = 1/50 { 
	use 300424_miM5_MB, clear
	di "`impdata'"
	keep if _mi_m==`impdata'
	
gformula y18_sbp y15_cte y18_smoking, ///
mediation outcome(y18_sbp) exposure(y15_cte) mediator(y18_smoking) ///
commands(y18_sbp:regress, y18_smoking:logit) ///
equations(y18_sbp: y15_cte y18_smoking, y18_smoking: y15_cte) ///
control(y18_smoking:0) linexp  ///
samples(50) seed(79) moreMC sim(10000) minsim
}

log close

*extract estimates and SEs from log file into an excel file - upload excel file and save
clonevar pm_b = pm 
clonevar nde_b = nde
clonevar nie_b = nie 
clonevar tce_b = tce

for any pm_ nde_ nie_ tce_: gen Xvar = Xbse^2

renvars pm nde nie tce / pm_mn nde_mn nie_mn tce_mn
renvars pm_var nde_var nie_var tce_var / pm_w nde_w nie_w tce_w

collapse (mean) pm_mn nde_mn nie_mn tce_mn pm_w nde_w nie_w tce_w (sd) pm_b nde_b nie_b tce_b
for var pm_b nde_b nie_b tce_b: replace X = X^2
for any pm_ nde_ nie_ tce_: gen Xtotvar = Xw + (1 + 1/50)*Xb

for any pm_ nde_ nie_ tce_: gen Xtotse = Xtotvar^0.5

list pm_mn pm_totse 
list nde_mn nde_totse 
list nie_mn nie_totse 
list tce_mn tce_totse

* unadjusted - drug use
log using "gformula_imp_sBPunadj_druguse.log", replace

forvalues impdata = 1/50 { 
	use 300424_miM5_MB, clear
	di "`impdata'"
	keep if _mi_m==`impdata'
	
gformula y18_sbp y15_cte y18_druguse, ///
mediation outcome(y18_sbp) exposure(y15_cte) mediator(y18_druguse) ///
commands(y18_sbp:regress, y18_druguse:logit) ///
equations(y18_sbp: y15_cte y18_druguse, y18_druguse: y15_cte) ///
control(y18_druguse:0) linexp  ///
samples(50) seed(79) moreMC sim(10000) minsim
}

log close

*extract estimates and SEs from log file into an excel file - upload excel file and save
clonevar pm_b = pm 
clonevar nde_b = nde
clonevar nie_b = nie 
clonevar tce_b = tce

for any pm_ nde_ nie_ tce_: gen Xvar = Xbse^2

renvars pm nde nie tce / pm_mn nde_mn nie_mn tce_mn
renvars pm_var nde_var nie_var tce_var / pm_w nde_w nie_w tce_w

collapse (mean) pm_mn nde_mn nie_mn tce_mn pm_w nde_w nie_w tce_w (sd) pm_b nde_b nie_b tce_b
for var pm_b nde_b nie_b tce_b: replace X = X^2
for any pm_ nde_ nie_ tce_: gen Xtotvar = Xw + (1 + 1/50)*Xb

for any pm_ nde_ nie_ tce_: gen Xtotse = Xtotvar^0.5

list pm_mn pm_totse 
list nde_mn nde_totse 
list nie_mn nie_totse 
list tce_mn tce_totse

* adjusted - alcohol 
log using "gformula_imp_sBPadj_alc.log", replace

forvalues impdata = 1/50 { 
	use 300424_miM5_MB, clear
	di "`impdata'"
	keep if _mi_m==`impdata'
	
gformula y18_sbp y15_cte y18_alcohol y15_activity y15_bmi sex ethnicity msmoking malcohol meduc fincome birthday, ///
mediation outcome(y18_sbp) exposure(y15_cte) mediator(y18_alcohol) post_confs(y15_activity y15_bmi) base_confs(sex ethnicity msmoking malcohol meduc fincome birthday) ///
commands(y18_sbp:regress, y18_alcohol:logit, y15_activity:regress, y15_bmi:regress) ///
equations(y18_sbp: y15_cte y18_alcohol y15_bmi y15_activity i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday, y18_alcohol: y15_cte y15_bmi y15_activity i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday, y15_activity: y15_cte i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday, y15_bmi: y15_cte y15_activity i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday) ///
control(y18_alcohol:0) linexp ///
samples(50) seed(79) moreMC sim(10000) minsim
}

log close

*extract estimates and SEs from log file into an excel file - upload excel file and save
clonevar pm_b = pm 
clonevar nde_b = nde
clonevar nie_b = nie 
clonevar tce_b = tce

for any pm_ nde_ nie_ tce_: gen Xvar = Xbse^2

renvars pm nde nie tce / pm_mn nde_mn nie_mn tce_mn
renvars pm_var nde_var nie_var tce_var / pm_w nde_w nie_w tce_w

collapse (mean) pm_mn nde_mn nie_mn tce_mn pm_w nde_w nie_w tce_w (sd) pm_b nde_b nie_b tce_b
for var pm_b nde_b nie_b tce_b: replace X = X^2
for any pm_ nde_ nie_ tce_: gen Xtotvar = Xw + (1 + 1/50)*Xb

for any pm_ nde_ nie_ tce_: gen Xtotse = Xtotvar^0.5

list pm_mn pm_totse 
list nde_mn nde_totse 
list nie_mn nie_totse 
list tce_mn tce_totse

* adjusted - smoking 
log using "gformula_imp_sBPadj_smoking.log", replace

forvalues impdata = 1/50 { 
	use 300424_miM5_MB, clear
	di "`impdata'"
	keep if _mi_m==`impdata'
	
gformula y18_sbp y15_cte y18_smoking y15_activity y15_bmi sex ethnicity msmoking malcohol meduc fincome birthday, ///
mediation outcome(y18_sbp) exposure(y15_cte) mediator(y18_smoking) post_confs(y15_activity y15_bmi) base_confs(sex ethnicity msmoking malcohol meduc fincome birthday) ///
commands(y18_sbp:regress, y18_smoking:logit, y15_activity:regress, y15_bmi:regress) ///
equations(y18_sbp: y15_cte y18_smoking y15_bmi y15_activity i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday, y18_smoking: y15_cte y15_bmi y15_activity i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday, y15_activity: y15_cte i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday, y15_bmi: y15_cte y15_activity i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday) ///
control(y18_smoking:0) linexp ///
samples(50) seed(79) moreMC sim(10000) minsim
}

log close

*extract estimates and SEs from log file into an excel file - upload excel file and save
clonevar pm_b = pm 
clonevar nde_b = nde
clonevar nie_b = nie 
clonevar tce_b = tce

for any pm_ nde_ nie_ tce_: gen Xvar = Xbse^2

renvars pm nde nie tce / pm_mn nde_mn nie_mn tce_mn
renvars pm_var nde_var nie_var tce_var / pm_w nde_w nie_w tce_w

collapse (mean) pm_mn nde_mn nie_mn tce_mn pm_w nde_w nie_w tce_w (sd) pm_b nde_b nie_b tce_b
for var pm_b nde_b nie_b tce_b: replace X = X^2
for any pm_ nde_ nie_ tce_: gen Xtotvar = Xw + (1 + 1/50)*Xb

for any pm_ nde_ nie_ tce_: gen Xtotse = Xtotvar^0.5

list pm_mn pm_totse 
list nde_mn nde_totse 
list nie_mn nie_totse 
list tce_mn tce_totse

* adjusted - drug use 
log using "gformula_imp_sBPadj_druguse.log", replace

forvalues impdata = 1/50 { 
	use 300424_miM5_MB, clear
	di "`impdata'"
	keep if _mi_m==`impdata'
	
gformula y18_sbp y15_cte y18_druguse y15_activity y15_bmi sex ethnicity msmoking malcohol meduc fincome birthday, ///
mediation outcome(y18_sbp) exposure(y15_cte) mediator(y18_druguse) post_confs(y15_activity y15_bmi) base_confs(sex ethnicity msmoking malcohol meduc fincome birthday) ///
commands(y18_sbp:regress, y18_druguse:logit, y15_activity:regress, y15_bmi:regress) ///
equations(y18_sbp: y15_cte y18_druguse y15_bmi y15_activity i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday, y18_druguse: y15_cte y15_bmi y15_activity i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday, y15_activity: y15_cte i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday, y15_bmi: y15_cte y15_activity i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday) ///
control(y18_druguse:0) linexp ///
samples(50) seed(79) moreMC sim(10000) minsim
}

log close

*extract estimates and SEs from log file into an excel file - upload excel file and save
clonevar pm_b = pm 
clonevar nde_b = nde
clonevar nie_b = nie 
clonevar tce_b = tce

for any pm_ nde_ nie_ tce_: gen Xvar = Xbse^2

renvars pm nde nie tce / pm_mn nde_mn nie_mn tce_mn
renvars pm_var nde_var nie_var tce_var / pm_w nde_w nie_w tce_w

collapse (mean) pm_mn nde_mn nie_mn tce_mn pm_w nde_w nie_w tce_w (sd) pm_b nde_b nie_b tce_b
for var pm_b nde_b nie_b tce_b: replace X = X^2
for any pm_ nde_ nie_ tce_: gen Xtotvar = Xw + (1 + 1/50)*Xb

for any pm_ nde_ nie_ tce_: gen Xtotse = Xtotvar^0.5

list pm_mn pm_totse 
list nde_mn nde_totse 
list nie_mn nie_totse 
list tce_mn tce_totse

**********************************************************

* APPENDIX 2 TABLE S5 - MEDIATION MODELS OF THE RELATIONSHIP BETWEEN CUMULATIVE TRAUMA UP TO AGE 15 AND RESTING DIASTOLIC BLOOD PRESSURE  AT AGE 18 THROUGH MEDIATING SUBSTANCE USE BEHAVIOURS (PROBLEMATIC ALCOHOL USE, SMOKING, AND ILLICIT DRUG USE; INCLUDED INDIVIDUALLY) *

* model 5 *
* unadjusted - alcohol use
log using "gformula_imp_dBPunadj_alc.log", replace

forvalues impdata = 1/50 { 
	use 300424_miM5_MB, clear
	di "`impdata'"
	keep if _mi_m==`impdata'
	
gformula y18_dbp y15_cte y18_alcohol, ///
mediation outcome(y18_dbp) exposure(y15_cte) mediator(y18_alcohol) ///
commands(y18_dbp:regress, y18_alcohol:logit) ///
equations(y18_dbp: y15_cte y18_alcohol, y18_alcohol: y15_cte) ///
control(y18_alcohol:0) linexp  ///
samples(50) seed(79) moreMC sim(10000) minsim
}

log close

*extract estimates and SEs from log file into an excel file - upload excel file and save
clonevar pm_b = pm 
clonevar nde_b = nde
clonevar nie_b = nie 
clonevar tce_b = tce

for any pm_ nde_ nie_ tce_: gen Xvar = Xbse^2

renvars pm nde nie tce / pm_mn nde_mn nie_mn tce_mn
renvars pm_var nde_var nie_var tce_var / pm_w nde_w nie_w tce_w

collapse (mean) pm_mn nde_mn nie_mn tce_mn pm_w nde_w nie_w tce_w (sd) pm_b nde_b nie_b tce_b
for var pm_b nde_b nie_b tce_b: replace X = X^2
for any pm_ nde_ nie_ tce_: gen Xtotvar = Xw + (1 + 1/50)*Xb

for any pm_ nde_ nie_ tce_: gen Xtotse = Xtotvar^0.5

list pm_mn pm_totse 
list nde_mn nde_totse 
list nie_mn nie_totse 
list tce_mn tce_totse

* unadjusted - smoking
log using "gformula_imp_dBPunadj_smoking.log", replace

forvalues impdata = 1/50 { 
	use 300424_miM5_MB, clear
	di "`impdata'"
	keep if _mi_m==`impdata'
	
gformula y18_dbp y15_cte y18_smoking, ///
mediation outcome(y18_dbp) exposure(y15_cte) mediator(y18_smoking) ///
commands(y18_dbp:regress, y18_smoking:logit) ///
equations(y18_dbp: y15_cte y18_smoking, y18_smoking: y15_cte) ///
control(y18_smoking:0) linexp  ///
samples(50) seed(79) moreMC sim(10000) minsim
}

log close

*extract estimates and SEs from log file into an excel file - upload excel file and save
clonevar pm_b = pm 
clonevar nde_b = nde
clonevar nie_b = nie 
clonevar tce_b = tce

for any pm_ nde_ nie_ tce_: gen Xvar = Xbse^2

renvars pm nde nie tce / pm_mn nde_mn nie_mn tce_mn
renvars pm_var nde_var nie_var tce_var / pm_w nde_w nie_w tce_w

collapse (mean) pm_mn nde_mn nie_mn tce_mn pm_w nde_w nie_w tce_w (sd) pm_b nde_b nie_b tce_b
for var pm_b nde_b nie_b tce_b: replace X = X^2
for any pm_ nde_ nie_ tce_: gen Xtotvar = Xw + (1 + 1/50)*Xb

for any pm_ nde_ nie_ tce_: gen Xtotse = Xtotvar^0.5

list pm_mn pm_totse 
list nde_mn nde_totse 
list nie_mn nie_totse 
list tce_mn tce_totse

* unadjusted - drug use
log using "gformula_imp_dBPunadj_druguse.log", replace

forvalues impdata = 1/50 { 
	use 300424_miM5_MB, clear
	di "`impdata'"
	keep if _mi_m==`impdata'
	
gformula y18_dbp y15_cte y18_druguse, ///
mediation outcome(y18_dbp) exposure(y15_cte) mediator(y18_druguse) ///
commands(y18_dbp:regress, y18_druguse:logit) ///
equations(y18_dbp: y15_cte y18_druguse, y18_druguse: y15_cte) ///
control(y18_druguse:0) linexp  ///
samples(50) seed(79) moreMC sim(10000) minsim
}

log close

*extract estimates and SEs from log file into an excel file - upload excel file and save
clonevar pm_b = pm 
clonevar nde_b = nde
clonevar nie_b = nie 
clonevar tce_b = tce

for any pm_ nde_ nie_ tce_: gen Xvar = Xbse^2

renvars pm nde nie tce / pm_mn nde_mn nie_mn tce_mn
renvars pm_var nde_var nie_var tce_var / pm_w nde_w nie_w tce_w

collapse (mean) pm_mn nde_mn nie_mn tce_mn pm_w nde_w nie_w tce_w (sd) pm_b nde_b nie_b tce_b
for var pm_b nde_b nie_b tce_b: replace X = X^2
for any pm_ nde_ nie_ tce_: gen Xtotvar = Xw + (1 + 1/50)*Xb

for any pm_ nde_ nie_ tce_: gen Xtotse = Xtotvar^0.5

list pm_mn pm_totse 
list nde_mn nde_totse 
list nie_mn nie_totse 
list tce_mn tce_totse

* adjusted - alcohol 
log using "gformula_imp_dBPadj_alc.log", replace

forvalues impdata = 1/50 { 
	use 300424_miM5_MB, clear
	di "`impdata'"
	keep if _mi_m==`impdata'
	
gformula y18_dbp y15_cte y18_alcohol y15_activity y15_bmi sex ethnicity msmoking malcohol meduc fincome birthday, ///
mediation outcome(y18_dbp) exposure(y15_cte) mediator(y18_alcohol) post_confs(y15_activity y15_bmi) base_confs(sex ethnicity msmoking malcohol meduc fincome birthday) ///
commands(y18_dbp:regress, y18_alcohol:logit, y15_activity:regress, y15_bmi:regress) ///
equations(y18_dbp: y15_cte y18_alcohol y15_bmi y15_activity i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday, y18_alcohol: y15_cte y15_bmi y15_activity i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday, y15_activity: y15_cte i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday, y15_bmi: y15_cte y15_activity i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday) ///
control(y18_alcohol:0) linexp ///
samples(50) seed(79) moreMC sim(10000) minsim
}

log close

*extract estimates and SEs from log file into an excel file - upload excel file and save
clonevar pm_b = pm 
clonevar nde_b = nde
clonevar nie_b = nie 
clonevar tce_b = tce

for any pm_ nde_ nie_ tce_: gen Xvar = Xbse^2

renvars pm nde nie tce / pm_mn nde_mn nie_mn tce_mn
renvars pm_var nde_var nie_var tce_var / pm_w nde_w nie_w tce_w

collapse (mean) pm_mn nde_mn nie_mn tce_mn pm_w nde_w nie_w tce_w (sd) pm_b nde_b nie_b tce_b
for var pm_b nde_b nie_b tce_b: replace X = X^2
for any pm_ nde_ nie_ tce_: gen Xtotvar = Xw + (1 + 1/50)*Xb

for any pm_ nde_ nie_ tce_: gen Xtotse = Xtotvar^0.5

list pm_mn pm_totse 
list nde_mn nde_totse 
list nie_mn nie_totse 
list tce_mn tce_totse

* adjusted - smoking 
log using "gformula_imp_dBPadj_smoking.log", replace

forvalues impdata = 1/50 { 
	use 300424_miM5_MB, clear
	di "`impdata'"
	keep if _mi_m==`impdata'
	
gformula y18_dbp y15_cte y18_smoking y15_activity y15_bmi sex ethnicity msmoking malcohol meduc fincome birthday, ///
mediation outcome(y18_dbp) exposure(y15_cte) mediator(y18_smoking) post_confs(y15_activity y15_bmi) base_confs(sex ethnicity msmoking malcohol meduc fincome birthday) ///
commands(y18_dbp:regress, y18_smoking:logit, y15_activity:regress, y15_bmi:regress) ///
equations(y18_dbp: y15_cte y18_smoking y15_bmi y15_activity i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday, y18_smoking: y15_cte y15_bmi y15_activity i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday, y15_activity: y15_cte i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday, y15_bmi: y15_cte y15_activity i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday) ///
control(y18_smoking:0) linexp ///
samples(50) seed(79) moreMC sim(10000) minsim
}

log close

*extract estimates and SEs from log file into an excel file - upload excel file and save
clonevar pm_b = pm 
clonevar nde_b = nde
clonevar nie_b = nie 
clonevar tce_b = tce

for any pm_ nde_ nie_ tce_: gen Xvar = Xbse^2

renvars pm nde nie tce / pm_mn nde_mn nie_mn tce_mn
renvars pm_var nde_var nie_var tce_var / pm_w nde_w nie_w tce_w

collapse (mean) pm_mn nde_mn nie_mn tce_mn pm_w nde_w nie_w tce_w (sd) pm_b nde_b nie_b tce_b
for var pm_b nde_b nie_b tce_b: replace X = X^2
for any pm_ nde_ nie_ tce_: gen Xtotvar = Xw + (1 + 1/50)*Xb

for any pm_ nde_ nie_ tce_: gen Xtotse = Xtotvar^0.5

list pm_mn pm_totse 
list nde_mn nde_totse 
list nie_mn nie_totse 
list tce_mn tce_totse

* adjusted - drug use 
log using "gformula_imp_dBPadj_druguse.log", replace

forvalues impdata = 1/50 { 
	use 300424_miM5_MB, clear
	di "`impdata'"
	keep if _mi_m==`impdata'
	
gformula y18_dbp y15_cte y18_druguse y15_activity y15_bmi sex ethnicity msmoking malcohol meduc fincome birthday, ///
mediation outcome(y18_dbp) exposure(y15_cte) mediator(y18_druguse) post_confs(y15_activity y15_bmi) base_confs(sex ethnicity msmoking malcohol meduc fincome birthday) ///
commands(y18_dbp:regress, y18_druguse:logit, y15_activity:regress, y15_bmi:regress) ///
equations(y18_dbp: y15_cte y18_druguse y15_bmi y15_activity i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday, y18_druguse: y15_cte y15_bmi y15_activity i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday, y15_activity: y15_cte i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday, y15_bmi: y15_cte y15_activity i.sex i.ethnicity i.msmoking i.malcohol meduc fincome birthday) ///
control(y18_druguse:0) linexp ///
samples(50) seed(79) moreMC sim(10000) minsim
}

log close

*extract estimates and SEs from log file into an excel file - upload excel file and save
clonevar pm_b = pm 
clonevar nde_b = nde
clonevar nie_b = nie 
clonevar tce_b = tce

for any pm_ nde_ nie_ tce_: gen Xvar = Xbse^2

renvars pm nde nie tce / pm_mn nde_mn nie_mn tce_mn
renvars pm_var nde_var nie_var tce_var / pm_w nde_w nie_w tce_w

collapse (mean) pm_mn nde_mn nie_mn tce_mn pm_w nde_w nie_w tce_w (sd) pm_b nde_b nie_b tce_b
for var pm_b nde_b nie_b tce_b: replace X = X^2
for any pm_ nde_ nie_ tce_: gen Xtotvar = Xw + (1 + 1/50)*Xb

for any pm_ nde_ nie_ tce_: gen Xtotse = Xtotvar^0.5

list pm_mn pm_totse 
list nde_mn nde_totse 
list nie_mn nie_totse 
list tce_mn tce_totse
