# 2004Pelotas-Trauma-HRB-CVI
Stata code used for imputation and analyses for the manuscript entitled: "Childhood trauma, adolescent risk behaviours and cardiovascular health indices in the 2004 Pelotas Birth Cohort" (Bailey et al., 2025. Journal of Child Psychology & Psychiatry; https://doi.org/10.1111/jcpp.14173). The study aimed to investigate cross-sectional and longitudinal associations between childhood trauma exposure and adolescent risk behaviours (problematic alcohol use, smoking, illicit drug use, and sleep) in Brazilian adolescents. Additionally, this study investigated the effect of childhood trauma on indices of cardiovascular health (heart rate, systolic blood pressure, and diastolic blood pressure) via mediating risk behaviours. Key analyses are as follows:

1. Regressions (logistic and linear) - Exposure: cumulative trauma up to age 11; Outcomes: risk behaviours at age 18 [longitudinal].
2. Regressions (logistic and linear) - Exposure: cumulative trauma up to age 15; Outcomes: risk behaviours at age 18 [longitudinal].
3. Regressions (logistic and linear) - Exposure: cumulative trauma up to age 18; Outcomes: risk behaviours at age 18 [cross-sectional]
4. Sensitivity analyses to examine sex differences.
5. Population attributable fractions - Exposure: trauma exposure up to age 18 (binary); Outcomes: substance use behaviours at age 18 [cross-sectional].
6. Mediation analyses:
                       a) Regressions - Exposure: risk behaviours at age 18; Outcomes: HR, sBP, and dBP at age 18 [cross-sectional].
                       b) Counterfactual Mediation: Exposure: cumulative trauma up to age 15; Mediators: substance use behaviours at age 18; Outcomes: HR, sBP, and dBP.
                       c) Sensitivity analyses to explore whether indirect effects were driven by a single mediator.

The following confounders were adjusted for in all analyses: adolescent sex, adolescent ethnicity, maternal alcohol consumption during pregnancy, maternal smoking during pregnancy, maternal years of education at birth, monthly family income at birth, and day of the year that the adolescent was born (proxy for cohort birth order). Additionally, two intermediate confounders were additionally adjusted for in mediation analyses: child BMI and physical activity (hours per week) at age 15. 

There are three Stata do-files:
1. "Imputation.do": Stata code to run five imputation models (due to perfect prediction errors).
2. "Imputed_Analyses.do": Stata code to run the above analyses on imputed data (N=4229).
3. "Complete_Case_Analyses.do": Stata code to run the above analyses using complete cases.
