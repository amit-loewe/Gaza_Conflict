*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
*** CODE TO CREATE MAIN RESULTS SHOWN IN: 
*** "How Civilian Attitudes Respond to the State’s Violence: 
*** Lessons from the Israel-Gaza Conflict " 
*** AUTHORS: Amit Loewenthal, Sami Miaari, Alexei Abrahams
*** REVISED: 8 April 2022
*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

set more off

clear all
set matsize 11000

*** SET DIRECTORIES 
cd "ROOT"

*** LOG FILE 
cap log close
log using "Gaza\results.smcl", replace

/*** -------------------------------------------------------------------------------
*** TABLE OF CONTENTS ***
------------------------------------------------------------------------------- ***/
* Table II: Descriptive statistics for public opinion dataset
* Table III: descriptive statistics for PLFS dataset and fatalities 
* Table V: Results with aggregated treatment variables
* Table VI: Results with disaggregated treatment variables 
* Table VII: Multicollinearity sensitivity analysis results 
* Table VIII: Time-trend sensitivity analysis results
* Figure 1: share of respondents who support militant factions in Gaza Strip and the West Bank, 1998q1-2011q2
* Figure 2: Share of respondents support for various political blocks by quarter, 1998q1-2011q2
* Figure 3: Changes in odds of supporting militant factions due to policies and events

*****Table II

use "Gaza\master_data.dta", clear

global demographic female married ibn.occupation ibn.sector refugees ibn.locality_type ibn.age_group ibn.educ_level
sum  moderate militant other_fac $demographic

*****Table III
use "Gaza\master_data.dta", clear

collapse fatalities r_dwage unemployment, by (district_year_quarter)
sum fatalities r_dwage unemployment

global demographic female i.age_group married i.educ_level i.occupation i.sector i.locality_type refugees
global treatment summer clouds battle blockade hot_winter cast_lead
global gaza_treatment gaza_summer gaza_clouds gaza_battle gaza_blockade gaza_winter gaza_lead
global districts i.district
global fe_quart i.year_quarter

*****Table V

use "Gaza\master_data.dta", clear
global demographic female i.age_group married i.educ_level i.occupation i.sector i.locality_type refugees
global treatment summer clouds battle blockade hot_winter cast_lead
global gaza_treatment gaza_summer gaza_clouds gaza_battle gaza_blockade gaza_winter gaza_lead
global districts i.district
global fe_quart i.year_quarter

*(1)
*general treatment variable
mlogit mvote gaza treatment gaza_treat fatalities fat_lag1 unemployment r_dwage $demographic $districts $fe_quart, robust cluster(district) rrr
outreg2 using table_v, excel eform cti(odds ratio)
*(2)
*general operations variable
mlogit mvote gaza operation gaza_operation fatalities fat_lag1 unemployment r_dwage $demographic $districts $fe_quart, robust cluster(district) rrr
outreg2 using table_v, excel eform cti(odds ratio)
*(3)
*operations and blockae variables
mlogit mvote gaza operation blockade gaza_operation gaza_blockade fatalities fat_lag1 unemployment r_dwage $demographic $districts $fe_quart, robust cluster(district) rrr
outreg2 using table_v, excel eform cti(odds ratio)
*(4)
*operations blockade battle variables
mlogit mvote gaza operation blockade battle gaza_operation gaza_blockade gaza_battle fatalities fat_lag1 unemployment r_dwage $demographic $districts $fe_quart, robust cluster(district) rrr
outreg2 using table_v, excel eform cti(odds ratio)
*(5)
*everything but gaza battle
mlogit mvote gaza summer clouds blockade hot_winter cast_lead gaza_summer gaza_clouds gaza_blockade gaza_winter gaza_lead fatalities fat_lag1 unemployment r_dwage $demographic $districts $fe_quart, robust cluster(district) rrr
outreg2 using table_v, excel eform cti(odds ratio)

*****Table VI
use "Gaza\master_data.dta", clear
global demographic female i.age_group married i.educ_level i.occupation i.sector i.locality_type refugees
global treatment summer clouds battle blockade hot_winter cast_lead
global gaza_treatment gaza_summer gaza_clouds gaza_battle gaza_blockade gaza_winter gaza_lead
global districts i.district
global fe_quart i.year_quarter

*(1)
mlogit mvote gaza summer clouds battle blockade hot_winter cast_lead gaza_summer gaza_clouds gaza_battle gaza_blockade gaza_winter gaza_lead fatalities fat_lag1 unemployment r_dwage $demographic $districts $fe_quart, robust cluster(district) rrr
outreg2 using table_vi, excel eform cti(odds ratio)
*(2)
mlogit mvote gaza summer gaza_summer fatalities fat_lag1 unemployment r_dwage $demographic $districts $fe_quart, robust cluster(district) rrr
outreg2 using table_vi, excel eform cti(odds ratio)
*(3)
mlogit mvote gaza summer clouds gaza_summer gaza_clouds fatalities fat_lag1 unemployment r_dwage $demographic $districts $fe_quart, robust cluster(district) rrr
outreg2 using table_vi, excel eform cti(odds ratio)
*(4)
mlogit mvote gaza summer clouds battle gaza_summer gaza_clouds gaza_battle fatalities fat_lag1 unemployment r_dwage $demographic $districts $fe_quart, robust cluster(district) rrr
outreg2 using table_vi, excel eform cti(odds ratio)
*(5)
mlogit mvote gaza summer clouds battle blockade gaza_summer gaza_clouds gaza_battle gaza_blockade fatalities fat_lag1 unemployment r_dwage $demographic $districts $fe_quart, robust cluster(district) rrr
outreg2 using table_vi, excel eform cti(odds ratio)
*(6)
mlogit mvote gaza summer clouds battle blockade hot_winter gaza_summer gaza_clouds gaza_battle gaza_blockade gaza_winter fatalities fat_lag1 unemployment r_dwage $demographic $districts $fe_quart, robust cluster(district) rrr
outreg2 using table_vi, excel eform cti(odds ratio)

*****Table VII
use "Gaza\master_data.dta", clear
global demographic female i.age_group married i.educ_level i.occupation i.sector i.locality_type refugees
global treatment summer clouds battle blockade hot_winter cast_lead
global gaza_treatment gaza_summer gaza_clouds gaza_battle gaza_blockade gaza_winter gaza_lead
global districts i.district
global fe_quart i.year_quarter

*(1)
mlogit mvote gaza summer clouds battle blockade hot_winter cast_lead gaza_summer gaza_clouds gaza_battle gaza_blockade gaza_winter gaza_lead unemployment r_dwage $demographic $districts $fe_quart, robust cluster(district) rrr
outreg2 using table_vii, excel eform cti(odds ratio)	
*(2)
mlogit mvote gaza summer clouds battle blockade hot_winter cast_lead gaza_summer gaza_clouds gaza_battle gaza_blockade gaza_winter gaza_lead fatalities  unemployment r_dwage $demographic $districts $fe_quart, robust cluster(district) rrr
outreg2 using table_vii, excel eform cti(odds ratio)
*(3)
mlogit mvote gaza summer clouds battle blockade hot_winter cast_lead gaza_summer gaza_clouds gaza_battle gaza_blockade gaza_winter gaza_lead fat_lag1 unemployment r_dwage $demographic $districts $fe_quart, robust cluster(district) rrr
outreg2 using table_vii, excel eform cti(odds ratio)
*(4)
mlogit mvote gaza summer clouds battle blockade hot_winter cast_lead gaza_summer gaza_clouds gaza_battle gaza_blockade gaza_winter gaza_lead fatalities fat_lag1 $demographic $districts $fe_quart, robust cluster(district) rrr
outreg2 using table_vii, excel eform cti(odds ratio)
*(5)
mlogit mvote gaza summer clouds battle blockade hot_winter cast_lead gaza_summer gaza_clouds gaza_battle gaza_blockade gaza_winter gaza_lead $demographic $districts $fe_quart, robust cluster(district) rrr
outreg2 using table_vii, excel eform cti(odds ratio)
*(6)
mlogit mvote gaza summer clouds battle blockade hot_winter cast_lead gaza_summer gaza_clouds gaza_battle gaza_blockade gaza_winter gaza_lead $demographic $districts $fe_quart, robust cluster(district) rrr
outreg2 using table_vii, excel eform cti(odds ratio)

*****Table VIII
use "Gaza\master_data.dta", clear
global demographic female i.age_group married i.educ_level i.occupation i.sector i.locality_type refugees
global treatment summer clouds battle blockade hot_winter cast_lead
global gaza_treatment gaza_summer gaza_clouds gaza_battle gaza_blockade gaza_winter gaza_lead
global districts i.district
global fe_quart i.year_quarter

*(1)
*cubic + interaction
mlogit mvote gaza summer clouds battle blockade hot_winter cast_lead gaza_summer gaza_clouds gaza_battle gaza_blockade gaza_winter gaza_lead fatalities fat_lag1 unemployment r_dwage trend trend_sqr trend_cube gaza_trend gaza_trend_sqr gaza_trend_cube $demographic $districts, robust cluster(district) iterate(5) rrr
outreg2 using table_viii, excel eform cti(odds ratio)
*(2)
*squared + interaction
mlogit mvote gaza summer clouds battle blockade hot_winter cast_lead gaza_summer gaza_clouds gaza_battle gaza_blockade gaza_winter gaza_lead fatalities fat_lag1 unemployment r_dwage trend trend_sqr gaza_trend gaza_trend_sqr $demographic $districts, robust cluster(district) rrr
outreg2 using table_viii, excel eform cti(odds ratio)
*(3)
*linear + interaction
mlogit mvote gaza summer clouds battle blockade hot_winter cast_lead gaza_summer gaza_clouds gaza_battle gaza_blockade gaza_winter gaza_lead fatalities fat_lag1 unemployment r_dwage trend gaza_trend $demographic $districts, robust cluster(district) rrr
outreg2 using table_viii, excel eform cti(odds ratio)
*(4)
*cubic 
mlogit mvote gaza summer clouds battle blockade hot_winter cast_lead gaza_summer gaza_clouds gaza_battle gaza_blockade gaza_winter gaza_lead fatalities fat_lag1 unemployment r_dwage trend trend_sqr trend_cube $demographic $districts, robust cluster(district) rrr
outreg2 using table_viii, excel eform cti(odds ratio)
*(5)
*squared
mlogit mvote gaza summer clouds battle blockade hot_winter cast_lead gaza_summer gaza_clouds gaza_battle gaza_blockade gaza_winter gaza_lead fatalities fat_lag1 unemployment r_dwage trend trend_sqr $demographic $districts, robust cluster(district) rrr
outreg2 using table_viii, excel eform cti(odds ratio)
*(6)
*linear
mlogit mvote gaza summer clouds battle blockade hot_winter cast_lead gaza_summer gaza_clouds gaza_battle gaza_blockade gaza_winter gaza_lead fatalities fat_lag1 unemployment r_dwage trend $demographic $districts, robust cluster(district) rrr
outreg2 using table_viii, excel eform cti(odds ratio)


*****Figure 1
use "Gaza\faction_support.dta", clear
generate militant = 0
replace militant = 1 if faction_support == 1 | faction_support == 4 | faction_support == 5 | faction_support == 7 | faction_support == 8 | faction_support == 10 | faction_support == 10

*West Bank
tabstat militant if district <= 11, by(year_quarter)
*Gaza Strip
tabstat militant if district > 11, by(year_quarter)

*****Figure 2
use "Gaza\faction_support.dta", clear
generate militant = 0
replace militant = 1 if faction_support == 1 | faction_support == 4 | faction_support == 5 | faction_support == 7 | faction_support == 8 | faction_support == 10 | faction_support == 10
generate moderate = 0
replace moderate = 1 if faction_support == 2 | faction_support == 3 | faction_support == 6 | faction_support ==13 | faction_support == 15 | faction_support == 16
generate other_fac = 0
replace other_fac = 1 if faction_support == 9 | faction_support == 11 | faction_support == 12

tabstat moderate militant other_fac, by(year_quarter)


*Figure 3
use "Gaza\master_data.dta", clear
global demographic female i.age_group married i.educ_level i.occupation i.sector i.locality_type refugees
global treatment summer clouds battle blockade hot_winter cast_lead
global gaza_treatment gaza_summer gaza_clouds gaza_battle gaza_blockade gaza_winter gaza_lead
global districts i.district
global fe_quart i.year_quarter

*coefficients from this regression are used for West Bank effect
mlogit mvote gaza summer clouds battle blockade hot_winter cast_lead gaza_summer gaza_clouds gaza_battle gaza_blockade gaza_winter gaza_lead fatalities fat_lag1 unemployment r_dwage $demographic $districts $fe_quart, robust cluster(district) rrr

*linear combinations for Gaza Strip net effect in the figure
lincom _b[2:summer] + _b[2:gaza_summer], rrr
lincom _b[2:clouds] + _b[2:gaza_clouds], rrr
lincom _b[2:battle] + _b[2:gaza_battle], rrr
lincom _b[2:blockade] + _b[2:gaza_blockade], rrr
lincom _b[2:hot_winter] + _b[2:gaza_winter], rrr
lincom _b[2:cast_lead] + _b[2:gaza_lead], rrr

lincom _b[2:summer], rrr
lincom _b[2:clouds], rrr
lincom _b[2:battle], rrr
lincom _b[2:blockade], rrr
lincom _b[2:hot_winter], rrr
lincom _b[2:cast_lead], rrr


log close


