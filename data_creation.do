*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
*** CODE TO CREATE MAIN DATASETS USED IN: 
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
log using "Gaza\data_creation.smcl", replace

******************************************************************
* Fatalities data
******************************************************************
use "fatalities\Pal_FINAL_AUG13_stata13.dta", clear

gen	byte lfs_district1	=	.				
replace 	lfs_district1	=	1	if	district=="Jenin"
replace 	lfs_district1	=	2	if	district=="Tubas"
replace 	lfs_district1	=	3	if	district=="Tulkarm"
replace 	lfs_district1	=	4	if	district=="Qalqilya"
replace 	lfs_district1	=	5	if	district=="Salfit"
replace 	lfs_district1	=	6	if	district=="Nablus"
replace 	lfs_district1	=	7	if	district=="Ramallah_&_Al-Bireh"
replace 	lfs_district1	=	8	if	district=="Jerusalem"
replace 	lfs_district1	=	9	if	district=="Jericho"
replace 	lfs_district1	=	10	if	district=="bethlehem"
replace 	lfs_district1	=	11	if	district=="Hebron"
replace 	lfs_district1	=	12	if	district=="North_Gaza"
replace 	lfs_district1	=	13	if	district=="Gaza"
replace 	lfs_district1	=	14	if	district=="Khanyunis"
replace 	lfs_district1	=	15	if	district=="Deir_Al-Balah"
replace 	lfs_district1	=	16	if	district=="Rafah"

label def lfs_district2 1 "Jenin"      2 "Tubas"			3 "Tulkarem"		4 "Qualqilya"		5 "Salfit"   	6 "Nablus"   /*
*/                       7 "Ramallah"	8 "Jerusalem"		9 "Jericho"			10 "Bethlehem"		11 "Hebron"		12 "Gaza North/Jabalya" /*
*/                       13 "Gaza City" 14 "Khanyounis"		15 "Deir El-Balah"	16 "Rafah"      
label  val lfs_district1 lfs_district2
drop   district
rename lfs_district1 district

generate quarter = 0
replace quarter = 1 if month >= 1 & month <= 3
replace quarter = 2 if month >= 4 & month <= 6
replace quarter = 3 if month >= 7 & month <= 9
replace quarter = 4 if month >= 10 & month <= 12

collapse (sum) minor_fat fat_byciv fat_bysecurity fat_bypalest, by(district quarter year)
drop if year < 1998
drop if year == 2011 & quarter == 3

generate year_quarter = yq(year,quarter)
sort district year_quarter

*a single variable for fatalities

generate fatalities = fat_byciv + fat_bysecurity + fat_bypalest


*lagged variable for fatalities

by district: gen fat_lag1 = fatalities[_n-1] if year_quarter==year_quarter[_n-1]+1
replace fat_lag1 = 0 if missing(fat_lag1) & year_quarter > 140

drop minor_fat fat_byciv fat_bysecurity fat_bypalest
save "Gaza\Pal_quart.dta", replace

******************************************************************
* PCPSR public opinion data
******************************************************************

clear
use "Palestinian Public Opinion\Pcpsr\Palestinian Public Opinion dataset\pcbsr_microdata_13.dta", clear

keep year quarter district locality_type sex age_group marital_status educ_level religion occupation sector refugee_status faction_support

tabulate faction_support, generate(faction)

rename faction1 DFLP
rename faction2 Fateh
rename faction3 h_al_shab
rename faction4 Hamas
rename faction5 PFLP
rename faction6 Fida
rename faction7 Ind_Islamists
rename faction8 Ind_Nationalists
rename faction9 Independent
rename faction10 Islamic_Jihad
rename faction11 Others
rename faction12 No_one
rename faction13 PPP
rename faction14 Ind_leftist
rename faction15 national_inititiative
rename faction16 third_way

drop if year < 1998 | year > 2011
drop if year == 2011 & quarter > 2

generate year_quarter = yq(year,quarter)
sort  district year_quarter

save "Gaza\faction_support.dta", replace

******************************************************************
* LFS data
******************************************************************
clear
use "LFS\1995_2013_stata13.dta", clear

gen	lfs_district1	=	.				
replace 	lfs_district1	=	1	if	district==1
replace 	lfs_district1	=	2	if	district==5
replace 	lfs_district1	=	3	if	district==10
replace 	lfs_district1	=	4	if	district==20
replace 	lfs_district1	=	5	if	district==25
replace 	lfs_district1	=	6	if	district==15
replace 	lfs_district1	=	7	if	district==30
replace 	lfs_district1	=	8	if	district==40
replace 	lfs_district1	=	9	if	district==35
replace 	lfs_district1	=	10	if	district==45
replace 	lfs_district1	=	11	if	district==50
replace 	lfs_district1	=	12	if	district==55
replace 	lfs_district1	=	13	if	district==60
replace 	lfs_district1	=	14	if	district==70
replace 	lfs_district1	=	15	if	district==65
replace 	lfs_district1	=	16	if	district==75

label def lfs_district2 1 "Jenin"      2 "Tubas"			3 "Tulkarem"		4 "Qualqilya"		5 "Salfit"   	6 "Nablus"   /*
*/                       7 "Ramallah"	8 "Jerusalem"		9 "Jericho"			10 "Bethlehem"		11 "Hebron"		12 "Gaza North/Jabalya" /*
*/                       13 "Gaza City" 14 "Khanyounis"		15 "Deir El-Balah"	16 "Rafah"     
label  val lfs_district1 lfs_district2
drop   district
rename lfs_district1 district

drop if year > 2011 | year < 1998
drop if year == 2011 & quarter > 2

*keep only working age persons (18-64 as in private public wage gaps paper)
keep if age >= 18 & age <=64

generate year_quarter = yq(year,quarter)
sort district year_quarter

tab district, gen(ddistrict)
egen district_year_quarter = group(district year_quarter)

*generate labor market indicators
gen unemployment = empch == 2 if empch ~=.
*note that this is unemployment share of population, not of the labor force
*gen employment = empch == 1 if empch ~=.
gen LFP = empch ~= 3 if empch ~=.

*collapse to district_year_quarter level
collapse unemployment LFP dwage [aw = qweight],by(district quarter year year_quarter district_year_quarter)
*unemployment as share of the labor force
replace unemployment = unemployment/LFP
sort district year_quarter

save "Gaza\socio_econ.dta", replace

******************************************************************
* consumer price index
******************************************************************

clear
import excel "CPI\cpi1996-2015quart.xls", sheet("cpi") firstrow

drop if year > 2011 | year < 1998
drop if year == 2011 & quarter > 2

generate year_quarter = yq(year,quarter)
sort region year_quarter

save "Gaza\cpi.dta", replace

******************************************************************
* merging files
******************************************************************

*merge cpi into socio-economic indicators and calculate real wages

use "Gaza\socio_econ.dta", replace

generate region = .
replace region = 1 if district < 12 & district != 8
replace region = 2 if district >= 12
replace region = 3 if district == 8

sort region year_quarter

merge m:1 region year_quarter using "Gaza\cpi.dta"
drop _merge
drop region
sort district year_quarter

*real wage
gen r_dwage = (dwage/cpi)*100
drop dwage
drop cpi

save "Gaza\socio_econ.dta", replace

*merge fatalities with socio-economic indicators
use "Gaza\Pal_quart.dta", clear
merge 1:1 district year_quarter using "Gaza\socio_econ.dta"
tab _merge
*filling zero fatalities
replace fatalities = 0 if _merge==2
replace fat_lag1 = 0 if _merge==2 & year_quarter > 140
*ignore missing year-quarter-district clusters for now
drop if _merge == 1
drop _merge

save "Gaza\fat_and_econ.dta", replace

*merge public opinion to other data
clear
use "Gaza\faction_support.dta", clear

merge m:1 district year_quarter using "Gaza\fat_and_econ.dta"
tab _merge
keep if _merge==3
drop _merge

save "Gaza\master_data.dta", replace

******************************************************************
* data clean-up
******************************************************************
use "Gaza\master_data.dta", clear

*remove respondants below the age of 18
drop if age_group == 0

*remove respondents with unknown education level
drop if educ_level == 8

*reomove respondents with missing data

drop if faction_support == .
drop if age_group == .
drop if locality_type == .
drop if educ_level == .
drop if sector == .
drop if occupation == .
drop if sex == .
drop if refugee_status == .
drop if marital_status == .

save "Gaza\master_data.dta", replace

******************************************************************
* create dependent variable
******************************************************************
use "Gaza\master_data.dta", clear


generate moderate = 0
replace moderate = 1 if faction_support == 2 | faction_support == 3 | faction_support == 6 | faction_support ==13 | faction_support == 15 | faction_support == 16
generate militant = 0
replace militant = 1 if faction_support == 1 | faction_support == 4 | faction_support == 5 | faction_support == 7 | faction_support == 8 | faction_support == 10 | faction_support == 10
generate other_fac = 0
replace other_fac = 1 if faction_support == 9 | faction_support == 11 | faction_support == 12

generate mvote = .
replace mvote = 1 if moderate == 1
replace mvote = 2 if militant == 1
replace mvote = 3 if other_fac == 1

label define mvote 1 moderate, add
label define mvote 2 militant, add
label define mvote 3 other, add

save "Gaza\master_data.dta", replace

******************************************************************
* create independent variables
******************************************************************

use "Gaza\master_data.dta", clear

*dummy for West Bank (0) and Gaza (1)
generate gaza = 0
replace gaza = 1 if district > 11

*an indicator for the blockade from 2007q4 to 2010q2
generate blockade = 0
replace blockade = 1 if year_quarter >= 191 & year_quarter <= 201
generate gaza_blockade = gaza*blockade

*indicators for other Gaza conflicts
generate cast_lead = 0
replace cast_lead = 1 if year_quarter == 196
generate gaza_lead = gaza*cast_lead

generate hot_winter = 0
replace hot_winter = 1 if year_quarter == 192
generate gaza_winter = gaza*hot_winter

generate battle = 0
replace battle = 1 if year_quarter == 189
generate gaza_battle = gaza*battle

generate clouds = 0
replace clouds = 1 if year_quarter == 187
generate gaza_clouds = gaza*clouds

generate summer = 0
replace summer = 1 if year_quarter >= 186 & year_quarter <= 187
generate gaza_summer = gaza*summer

*general treatment variable
gen treatment = 0
replace treatment = 1 if blockade == 1 | cast_lead == 1 | hot_winter == 1 | battle == 1 | clouds == 1 | summer == 1
gen gaza_treat = gaza*treatment

*treatment variable for Israeli military operations
gen operation = 0
replace operation = 1 if cast_lead == 1 | hot_winter == 1 | clouds == 1 | summer == 1
gen gaza_operation = gaza*operation

*time trend variables

quietly sum year_quarter
generate trend = year_quarter - r(min) + 1
generate trend_sqr = trend^2
generate trend_cube = trend^3

generate gaza_trend = gaza*trend
generate gaza_trend_sqr = gaza*trend_sqr
generate gaza_trend_cube = gaza*trend_cube

save "Gaza\master_data.dta", replace

************ Socio-demographic variables-
use "Gaza\master_data.dta", clear

gen female=(sex==2 ) if sex~=.
drop sex

tab  marital_status 
gen married=(marital_status==2 ) if marital_status~=.
drop marital_status

tab refugee_status 
gen refugees=(refugee_status==1 ) if refugee_status~=.
drop refugee_status

save "Gaza\master_data.dta", replace

log close
