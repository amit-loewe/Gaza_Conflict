*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
*** CODE TO CREATE APPENDIX RESULTS SHOWN IN: 
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
log using "Gaza\appendix.smcl", replace

/*** -------------------------------------------------------------------------------
*** TABLE OF CONTENTS ***
------------------------------------------------------------------------------- ***/
* Table AI
* Table AII
* Table AIII
* Table AV
* Table AVI 
* Table AVII 
* Table AVIII
* Table AIX
* Table AX
* Table AXI
* Table AXII
* Table AXIII 
* Table AXIV 
* Table AXV
* Table AXVI
* Table AXVII
* Table AXVIII
* Figure A1
* Figure A2
* Figure A3
* Footnote 16


*****Table AI
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

*descriptive statistics for comparison

keep if age >= 18
gen female = (sex == 2)
gen married = (maritals == 3)
gen refugee_stat = (refugee == 1 | refugee == 2) if refugee ~= .

*locality type indicators. Base category is urban
tab locality_type
gen urban =  locality_type == 1
gen village = locality_type == 2 
gen camp =  locality_type == 3 

gen age_group = 0
replace age_group = 1 if age >= 18 & age <=24
replace age_group = 2 if age >= 25 & age <=31
replace age_group = 3 if age >= 32 & age <=38
replace age_group = 4 if age >= 39 & age <=45
replace age_group = 5 if age >= 46 & age <=52
replace age_group = 6 if age >= 53

sum female married refugee_stat ib0.locality_type ib0.age_group ib0.educ_level

*****Table AII
use "Gaza\master_data.dta", clear
global demographic female i.age_group married i.educ_level i.occupation i.sector i.locality_type refugees
global treatment summer clouds battle blockade hot_winter cast_lead
global gaza_treatment gaza_summer gaza_clouds gaza_battle gaza_blockade gaza_winter gaza_lead
global districts i.district
global fe_quart i.year_quarter

*only operation autumn clouds

mlogit mvote gaza clouds gaza_clouds fatalities fat_lag1 unemployment r_dwage $demographic $districts $fe_quart, robust cluster(district) rrr
outreg2 using table_aii, excel eform cti(odds ratio)

*****Table AIII
*2.	No fatalities

mlogit mvote gaza summer clouds battle blockade hot_winter cast_lead gaza_summer gaza_clouds gaza_battle gaza_blockade gaza_winter gaza_lead unemployment r_dwage $demographic $districts $fe_quart, robust cluster(district) rrr
outreg2 using table_aiii, excel eform cti(odds ratio)

mlogit mvote gaza summer gaza_summer unemployment r_dwage $demographic $districts $fe_quart, robust cluster(district) rrr
outreg2 using table_aiii, excel eform cti(odds ratio)

mlogit mvote gaza summer clouds gaza_summer gaza_clouds unemployment r_dwage $demographic $districts $fe_quart, robust cluster(district) rrr
outreg2 using table_aiii, excel eform cti(odds ratio)

mlogit mvote gaza summer clouds battle gaza_summer gaza_clouds gaza_battle unemployment r_dwage $demographic $districts $fe_quart, robust cluster(district) rrr
outreg2 using table_aiii, excel eform cti(odds ratio)

mlogit mvote gaza summer clouds battle blockade gaza_summer gaza_clouds gaza_battle gaza_blockade unemployment r_dwage $demographic $districts $fe_quart, robust cluster(district) rrr
outreg2 using table_aiii, excel eform cti(odds ratio)

mlogit mvote gaza summer clouds battle blockade hot_winter gaza_summer gaza_clouds gaza_battle gaza_blockade gaza_winter unemployment r_dwage $demographic $districts $fe_quart, robust cluster(district) rrr
outreg2 using table_aiii, excel eform cti(odds ratio)

*****Table AIV
*3. non-lagged fatalities only

mlogit mvote gaza summer clouds battle blockade hot_winter cast_lead gaza_summer gaza_clouds gaza_battle gaza_blockade gaza_winter gaza_lead fatalities  unemployment r_dwage $demographic $districts $fe_quart, robust cluster(district) rrr
outreg2 using table_aiv, excel eform cti(odds ratio)

mlogit mvote gaza summer gaza_summer fatalities unemployment r_dwage $demographic $districts $fe_quart, robust cluster(district) rrr
outreg2 using table_aiv, excel eform cti(odds ratio)

mlogit mvote gaza summer clouds gaza_summer gaza_clouds fatalities unemployment r_dwage $demographic $districts $fe_quart, robust cluster(district) rrr
outreg2 using table_aiv, excel eform cti(odds ratio)

mlogit mvote gaza summer clouds battle gaza_summer gaza_clouds gaza_battle fatalities unemployment r_dwage $demographic $districts $fe_quart, robust cluster(district) rrr
outreg2 using table_aiv, excel eform cti(odds ratio)

mlogit mvote gaza summer clouds battle blockade gaza_summer gaza_clouds gaza_battle gaza_blockade fatalities unemployment r_dwage $demographic $districts $fe_quart, robust cluster(district) rrr
outreg2 using table_aiv, excel eform cti(odds ratio)

mlogit mvote gaza summer clouds battle blockade hot_winter gaza_summer gaza_clouds gaza_battle gaza_blockade gaza_winter fatalities unemployment r_dwage $demographic $districts $fe_quart, robust cluster(district) rrr
outreg2 using table_aiv, excel eform cti(odds ratio)

*****Table AV
*4. lagged fatalities only

mlogit mvote gaza summer clouds battle blockade hot_winter cast_lead gaza_summer gaza_clouds gaza_battle gaza_blockade gaza_winter gaza_lead fat_lag1 unemployment r_dwage $demographic $districts $fe_quart, robust cluster(district) rrr
outreg2 using table_av, excel eform cti(odds ratio)

mlogit mvote gaza summer gaza_summer fat_lag1 unemployment r_dwage $demographic $districts $fe_quart, robust cluster(district) rrr
outreg2 using table_av, excel eform cti(odds ratio)

mlogit mvote gaza summer clouds gaza_summer gaza_clouds fat_lag1 unemployment r_dwage $demographic $districts $fe_quart, robust cluster(district) rrr
outreg2 using table_av, excel eform cti(odds ratio)

mlogit mvote gaza summer clouds battle gaza_summer gaza_clouds gaza_battle fat_lag1 unemployment r_dwage $demographic $districts $fe_quart, robust cluster(district) rrr
outreg2 using table_av, excel eform cti(odds ratio)

mlogit mvote gaza summer clouds battle blockade gaza_summer gaza_clouds gaza_battle gaza_blockade fat_lag1 unemployment r_dwage $demographic $districts $fe_quart, robust cluster(district) rrr
outreg2 using table_av, excel eform cti(odds ratio)

mlogit mvote gaza summer clouds battle blockade hot_winter gaza_summer gaza_clouds gaza_battle gaza_blockade gaza_winter fat_lag1 unemployment r_dwage $demographic $districts $fe_quart, robust cluster(district) rrr
outreg2 using table_av, excel eform cti(odds ratio)

*****Table AVI
*5. No socioeconomic variables

mlogit mvote gaza summer clouds battle blockade hot_winter cast_lead gaza_summer gaza_clouds gaza_battle gaza_blockade gaza_winter gaza_lead fatalities fat_lag1 $demographic $districts $fe_quart, robust cluster(district) rrr
outreg2 using table_avi, excel eform cti(odds ratio)

mlogit mvote gaza summer gaza_summer fatalities fat_lag1 $demographic $districts $fe_quart, robust cluster(district) rrr
outreg2 using table_avi, excel eform cti(odds ratio)

mlogit mvote gaza summer clouds gaza_summer gaza_clouds fatalities fat_lag1 $demographic $districts $fe_quart, robust cluster(district) rrr
outreg2 using table_avi, excel eform cti(odds ratio)

mlogit mvote gaza summer clouds battle gaza_summer gaza_clouds gaza_battle fatalities fat_lag1 $demographic $districts $fe_quart, robust cluster(district) rrr
outreg2 using table_avi, excel eform cti(odds ratio)

mlogit mvote gaza summer clouds battle blockade gaza_summer gaza_clouds gaza_battle gaza_blockade fatalities fat_lag1 $demographic $districts $fe_quart, robust cluster(district) rrr
outreg2 using table_avi, excel eform cti(odds ratio)

mlogit mvote gaza summer clouds battle blockade hot_winter gaza_summer gaza_clouds gaza_battle gaza_blockade gaza_winter fatalities fat_lag1 $demographic $districts $fe_quart, robust cluster(district) rrr
outreg2 using table_avi, excel eform cti(odds ratio)

*****Table AVII
*6.	No fatalities, no socioeconomic variables

mlogit mvote gaza summer clouds battle blockade hot_winter cast_lead gaza_summer gaza_clouds gaza_battle gaza_blockade gaza_winter gaza_lead $demographic $districts $fe_quart, robust cluster(district) rrr
outreg2 using table_avii, excel eform cti(odds ratio)

mlogit mvote gaza summer gaza_summer $demographic $districts $fe_quart, robust cluster(district) rrr
outreg2 using table_avii, excel eform cti(odds ratio)

mlogit mvote gaza summer clouds gaza_summer gaza_clouds  $demographic $districts $fe_quart, robust cluster(district) rrr
outreg2 using table_avii, excel eform cti(odds ratio)

mlogit mvote gaza summer clouds battle gaza_summer gaza_clouds gaza_battle $demographic $districts $fe_quart, robust cluster(district) rrr
outreg2 using table_avii, excel eform cti(odds ratio)

mlogit mvote gaza summer clouds battle blockade gaza_summer gaza_clouds gaza_battle gaza_blockade $demographic $districts $fe_quart, robust cluster(district) rrr
outreg2 using table_avii, excel eform cti(odds ratio)

mlogit mvote gaza summer clouds battle blockade hot_winter gaza_summer gaza_clouds gaza_battle gaza_blockade gaza_winter $demographic $districts $fe_quart, robust cluster(district) rrr
outreg2 using table_avii, excel eform cti(odds ratio)

*****Table AVIII
*7. non-lagged fatalities only, no socioeconomic variables

mlogit mvote gaza summer clouds battle blockade hot_winter cast_lead gaza_summer gaza_clouds gaza_battle gaza_blockade gaza_winter gaza_lead fatalities $demographic $districts $fe_quart, robust cluster(district) rrr
outreg2 using table_aviii, excel eform cti(odds ratio)

mlogit mvote gaza summer gaza_summer fatalities $demographic $districts $fe_quart, robust cluster(district) rrr
outreg2 using table_aviii, excel eform cti(odds ratio)

mlogit mvote gaza summer clouds gaza_summer gaza_clouds fatalities $demographic $districts $fe_quart, robust cluster(district) rrr
outreg2 using table_aviii, excel eform cti(odds ratio)

mlogit mvote gaza summer clouds battle gaza_summer gaza_clouds gaza_battle fatalities $demographic $districts $fe_quart, robust cluster(district) rrr
outreg2 using table_aviii, excel eform cti(odds ratio)

mlogit mvote gaza summer clouds battle blockade gaza_summer gaza_clouds gaza_battle gaza_blockade fatalities $demographic $districts $fe_quart, robust cluster(district) rrr
outreg2 using table_aviii, excel eform cti(odds ratio)

mlogit mvote gaza summer clouds battle blockade hot_winter gaza_summer gaza_clouds gaza_battle gaza_blockade gaza_winter fatalities $demographic $districts $fe_quart, robust cluster(district) rrr
outreg2 using table_aviii, excel eform cti(odds ratio)

*****Table AIX
*8. lagged fatalities only, no socioeconomic variables

mlogit mvote gaza summer clouds battle blockade hot_winter cast_lead gaza_summer gaza_clouds gaza_battle gaza_blockade gaza_winter gaza_lead fat_lag1 $demographic $districts $fe_quart, robust cluster(district) rrr
outreg2 using table_aix, excel eform cti(odds ratio)

mlogit mvote gaza summer gaza_summer fat_lag1 $demographic $districts $fe_quart, robust cluster(district) rrr
outreg2 using table_aix, excel eform cti(odds ratio)

mlogit mvote gaza summer clouds gaza_summer gaza_clouds fat_lag1 $demographic $districts $fe_quart, robust cluster(district) rrr
outreg2 using table_aix, excel eform cti(odds ratio)

mlogit mvote gaza summer clouds battle gaza_summer gaza_clouds gaza_battle fat_lag1 $demographic $districts $fe_quart, robust cluster(district) rrr
outreg2 using table_aix, excel eform cti(odds ratio)

mlogit mvote gaza summer clouds battle blockade gaza_summer gaza_clouds gaza_battle gaza_blockade fat_lag1 $demographic $districts $fe_quart, robust cluster(district) rrr
outreg2 using table_aix, excel eform cti(odds ratio)

mlogit mvote gaza summer clouds battle blockade hot_winter gaza_summer gaza_clouds gaza_battle gaza_blockade gaza_winter fat_lag1 $demographic $districts $fe_quart, robust cluster(district) rrr
outreg2 using table_aix, excel eform cti(odds ratio)

*****Table AX

*cubic + interaction
mlogit mvote gaza summer gaza_summer fatalities fat_lag1 unemployment r_dwage trend trend_sqr trend_cube gaza_trend gaza_trend_sqr gaza_trend_cube $demographic $districts, robust cluster(district) iterate(5) rrr
outreg2 using table_ax, excel eform cti(odds ratio)

*squared + interaction
mlogit mvote gaza summer gaza_summer fatalities fat_lag1 unemployment r_dwage trend trend_sqr gaza_trend gaza_trend_sqr $demographic $districts, robust cluster(district) rrr
outreg2 using table_ax, excel eform cti(odds ratio)

*linear + interaction
mlogit mvote gaza summer gaza_summer fatalities fat_lag1 unemployment r_dwage trend gaza_trend $demographic $districts, robust cluster(district) rrr
outreg2 using table_ax, excel eform cti(odds ratio)

*cubic 
mlogit mvote gaza summer gaza_summer fatalities fat_lag1 unemployment r_dwage trend trend_sqr trend_cube $demographic $districts, robust cluster(district) rrr
outreg2 using table_ax, excel eform cti(odds ratio)

*squared
mlogit mvote gaza summer gaza_summer fatalities fat_lag1 unemployment r_dwage trend trend_sqr $demographic $districts, robust cluster(district) rrr
outreg2 using table_ax, excel eform cti(odds ratio)

*linear
mlogit mvote gaza summer gaza_summer fatalities fat_lag1 unemployment r_dwage trend $demographic $districts, robust cluster(district) rrr
outreg2 using table_ax, excel eform cti(odds ratio)

*****Table AXI

*cubic + interaction
mlogit mvote gaza summer clouds gaza_summer gaza_clouds fatalities fat_lag1 unemployment r_dwage trend trend_sqr trend_cube gaza_trend gaza_trend_sqr gaza_trend_cube $demographic $districts, robust cluster(district) iterate(5) rrr
outreg2 using table_axi, excel eform cti(odds ratio)

*squared + interaction
mlogit mvote gaza summer clouds gaza_summer gaza_clouds fatalities fat_lag1 unemployment r_dwage trend trend_sqr gaza_trend gaza_trend_sqr $demographic $districts, robust cluster(district) rrr
outreg2 using table_axi, excel eform cti(odds ratio)

*linear + interaction
mlogit mvote gaza summer clouds gaza_summer gaza_clouds fatalities fat_lag1 unemployment r_dwage trend gaza_trend $demographic $districts, robust cluster(district) rrr
outreg2 using table_axi, excel eform cti(odds ratio)

*cubic 
mlogit mvote gaza summer clouds gaza_summer gaza_clouds fatalities fat_lag1 unemployment r_dwage trend trend_sqr trend_cube $demographic $districts, robust cluster(district) rrr
outreg2 using table_axi, excel eform cti(odds ratio)

*squared
mlogit mvote gaza summer clouds gaza_summer gaza_clouds fatalities fat_lag1 unemployment r_dwage trend trend_sqr $demographic $districts, robust cluster(district) rrr
outreg2 using table_axi, excel eform cti(odds ratio)

*linear
mlogit mvote gaza summer clouds gaza_summer gaza_clouds fatalities fat_lag1 unemployment r_dwage trend $demographic $districts, robust cluster(district) rrr
outreg2 using table_axi, excel eform cti(odds ratio)

*****Table AXII

*cubic + interaction
mlogit mvote gaza summer clouds battle gaza_summer gaza_clouds gaza_battle fatalities fat_lag1 unemployment r_dwage trend trend_sqr trend_cube gaza_trend gaza_trend_sqr gaza_trend_cube $demographic $districts, robust cluster(district) iterate(5) rrr
outreg2 using table_axii, excel eform cti(odds ratio)

*squared + interaction
mlogit mvote gaza summer clouds battle gaza_summer gaza_clouds gaza_battle fatalities fat_lag1 unemployment r_dwage trend trend_sqr gaza_trend gaza_trend_sqr $demographic $districts, robust cluster(district) rrr
outreg2 using table_axii, excel eform cti(odds ratio)

*linear + interaction
mlogit mvote gaza summer clouds battle gaza_summer gaza_clouds gaza_battle fatalities fat_lag1 unemployment r_dwage trend gaza_trend $demographic $districts, robust cluster(district) rrr
outreg2 using table_axii, excel eform cti(odds ratio)

*cubic 
mlogit mvote gaza summer clouds battle gaza_summer gaza_clouds gaza_battle fatalities fat_lag1 unemployment r_dwage trend trend_sqr trend_cube $demographic $districts, robust cluster(district) rrr
outreg2 using table_axii, excel eform cti(odds ratio)

*squared
mlogit mvote gaza summer clouds battle gaza_summer gaza_clouds gaza_battle fatalities fat_lag1 unemployment r_dwage trend trend_sqr $demographic $districts, robust cluster(district) rrr
outreg2 using table_axii, excel eform cti(odds ratio)

*linear
mlogit mvote gaza summer clouds battle gaza_summer gaza_clouds gaza_battle fatalities fat_lag1 unemployment r_dwage trend $demographic $districts, robust cluster(district) rrr
outreg2 using table_axii, excel eform cti(odds ratio)

*****Table AXIII

*cubic + interaction
mlogit mvote gaza summer clouds battle blockade gaza_summer gaza_clouds gaza_battle gaza_blockade fatalities fat_lag1 unemployment r_dwage trend trend_sqr trend_cube gaza_trend gaza_trend_sqr gaza_trend_cube $demographic $districts, robust cluster(district) iterate(5) rrr
outreg2 using table_axiii, excel eform cti(odds ratio)

*squared + interaction
mlogit mvote gaza summer clouds battle blockade gaza_summer gaza_clouds gaza_battle gaza_blockade fatalities fat_lag1 unemployment r_dwage trend trend_sqr gaza_trend gaza_trend_sqr $demographic $districts, robust cluster(district) rrr
outreg2 using table_axiii, excel eform cti(odds ratio)

*linear + interaction
mlogit mvote gaza summer clouds battle blockade gaza_summer gaza_clouds gaza_battle gaza_blockade fatalities fat_lag1 unemployment r_dwage trend gaza_trend $demographic $districts, robust cluster(district) rrr
outreg2 using table_axiii, excel eform cti(odds ratio)

*cubic 
mlogit mvote gaza summer clouds battle blockade gaza_summer gaza_clouds gaza_battle gaza_blockade fatalities fat_lag1 unemployment r_dwage trend trend_sqr trend_cube $demographic $districts, robust cluster(district) rrr
outreg2 using table_axiii, excel eform cti(odds ratio)

*squared
mlogit mvote gaza summer clouds battle blockade gaza_summer gaza_clouds gaza_battle gaza_blockade fatalities fat_lag1 unemployment r_dwage trend trend_sqr $demographic $districts, robust cluster(district) rrr
outreg2 using table_axiii, excel eform cti(odds ratio)

*linear
mlogit mvote gaza summer clouds battle blockade gaza_summer gaza_clouds gaza_battle gaza_blockade fatalities fat_lag1 unemployment r_dwage trend $demographic $districts, robust cluster(district) rrr
outreg2 using table_axiii, excel eform cti(odds ratio)

*****Table AXIV

*cubic + interaction
mlogit mvote gaza summer clouds battle blockade hot_winter gaza_summer gaza_clouds gaza_battle gaza_blockade gaza_winter fatalities fat_lag1 unemployment r_dwage trend trend_sqr trend_cube gaza_trend gaza_trend_sqr gaza_trend_cube $demographic $districts, robust cluster(district) iterate(5) rrr
outreg2 using table_axiv, excel eform cti(odds ratio)

*squared + interaction
mlogit mvote gaza summer clouds battle blockade hot_winter gaza_summer gaza_clouds gaza_battle gaza_blockade gaza_winter fatalities fat_lag1 unemployment r_dwage trend trend_sqr gaza_trend gaza_trend_sqr $demographic $districts, robust cluster(district) rrr
outreg2 using table_axiv, excel eform cti(odds ratio)

*linear + interaction
mlogit mvote gaza summer clouds battle blockade hot_winter gaza_summer gaza_clouds gaza_battle gaza_blockade gaza_winter fatalities fat_lag1 unemployment r_dwage trend gaza_trend $demographic $districts, robust cluster(district) rrr
outreg2 using table_axiv, excel eform cti(odds ratio)

*cubic 
mlogit mvote gaza summer clouds battle blockade hot_winter gaza_summer gaza_clouds gaza_battle gaza_blockade gaza_winter fatalities fat_lag1 unemployment r_dwage trend trend_sqr trend_cube $demographic $districts, robust cluster(district) rrr
outreg2 using table_axiv, excel eform cti(odds ratio)

*squared
mlogit mvote gaza summer clouds battle blockade hot_winter gaza_summer gaza_clouds gaza_battle gaza_blockade gaza_winter fatalities fat_lag1 unemployment r_dwage trend trend_sqr $demographic $districts, robust cluster(district) rrr
outreg2 using table_axiv, excel eform cti(odds ratio)

*linear
mlogit mvote gaza summer clouds battle blockade hot_winter gaza_summer gaza_clouds gaza_battle gaza_blockade gaza_winter fatalities fat_lag1 unemployment r_dwage trend $demographic $districts, robust cluster(district) rrr
outreg2 using table_axiv, excel eform cti(odds ratio)

*****Table AXV

*cubic + interaction
mlogit mvote gaza summer clouds battle blockade hot_winter cast_lead gaza_summer gaza_clouds gaza_battle gaza_blockade gaza_winter gaza_lead fatalities fat_lag1 unemployment r_dwage trend trend_sqr trend_cube gaza_trend gaza_trend_sqr gaza_trend_cube $demographic $districts, robust cluster(district) iterate(5) rrr
outreg2 using table_axv, excel eform cti(odds ratio)

*squared + interaction
mlogit mvote gaza summer clouds battle blockade hot_winter cast_lead gaza_summer gaza_clouds gaza_battle gaza_blockade gaza_winter gaza_lead fatalities fat_lag1 unemployment r_dwage trend trend_sqr gaza_trend gaza_trend_sqr $demographic $districts, robust cluster(district) rrr
outreg2 using table_axv, excel eform cti(odds ratio)

*linear + interaction
mlogit mvote gaza summer clouds battle blockade hot_winter cast_lead gaza_summer gaza_clouds gaza_battle gaza_blockade gaza_winter gaza_lead fatalities fat_lag1 unemployment r_dwage trend gaza_trend $demographic $districts, robust cluster(district) rrr
outreg2 using table_axv, excel eform cti(odds ratio)

*cubic 
mlogit mvote gaza summer clouds battle blockade hot_winter cast_lead gaza_summer gaza_clouds gaza_battle gaza_blockade gaza_winter gaza_lead fatalities fat_lag1 unemployment r_dwage trend trend_sqr trend_cube $demographic $districts, robust cluster(district) rrr
outreg2 using table_axv, excel eform cti(odds ratio)

*squared
mlogit mvote gaza summer clouds battle blockade hot_winter cast_lead gaza_summer gaza_clouds gaza_battle gaza_blockade gaza_winter gaza_lead fatalities fat_lag1 unemployment r_dwage trend trend_sqr $demographic $districts, robust cluster(district) rrr
outreg2 using table_axv, excel eform cti(odds ratio)

*linear
mlogit mvote gaza summer clouds battle blockade hot_winter cast_lead gaza_summer gaza_clouds gaza_battle gaza_blockade gaza_winter gaza_lead fatalities fat_lag1 unemployment r_dwage trend $demographic $districts, robust cluster(district) rrr
outreg2 using table_axv, excel eform cti(odds ratio)


*****Table AXVI

reg militant gaza $treatment $gaza_treatment fatalities fat_lag1 unemployment r_dwage $demographic $districts $fe_quart, robust cluster(district)
outreg2 using table_axvi, excel adjr2

reg moderate gaza $treatment $gaza_treatment fatalities fat_lag1 unemployment r_dwage $demographic $districts $fe_quart, robust cluster(district)
outreg2 using table_axvi, excel adjr2

reg other_fac gaza $treatment $gaza_treatment fatalities fat_lag1 unemployment r_dwage $demographic $districts $fe_quart, robust cluster(district)
outreg2 using table_axvi, excel adjr2

*****Table AXVII

use "Gaza\master_data.dta", clear

keep if year_quarter >= 190 & year_quarter ~= .

mlogit mvote gaza summer clouds battle blockade hot_winter cast_lead gaza_summer gaza_clouds gaza_battle gaza_blockade gaza_winter gaza_lead fatalities fat_lag1 unemployment r_dwage $demographic $districts $fe_quart, robust cluster(district) rrr
outreg2 using table_axvii, excel eform cti(odds ratio)

mlogit mvote gaza summer clouds battle blockade gaza_summer gaza_clouds gaza_battle gaza_blockade fatalities fat_lag1 unemployment r_dwage $demographic $districts $fe_quart, robust cluster(district) rrr
outreg2 using table_axvii, excel eform cti(odds ratio)

mlogit mvote gaza summer clouds battle blockade hot_winter gaza_summer gaza_clouds gaza_battle gaza_blockade gaza_winter fatalities fat_lag1 unemployment r_dwage $demographic $districts $fe_quart, robust cluster(district) rrr
outreg2 using table_axvii, excel eform cti(odds ratio)


*general treatment variable
mlogit mvote gaza treatment gaza_treat fatalities fat_lag1 unemployment r_dwage $demographic $districts $fe_quart, robust cluster(district) rrr
outreg2 using table_axvii, excel eform cti(odds ratio)

*general operations variable
mlogit mvote gaza operation gaza_operation fatalities fat_lag1 unemployment r_dwage $demographic $districts $fe_quart, robust cluster(district) rrr
outreg2 using table_axvii, excel eform cti(odds ratio)

*operations and blockae variables
mlogit mvote gaza operation blockade gaza_operation gaza_blockade fatalities fat_lag1 unemployment r_dwage $demographic $districts $fe_quart, robust cluster(district) rrr
outreg2 using table_axvii, excel eform cti(odds ratio)

*****Table AXVIII

use "Gaza\master_data.dta", clear
*treatment-refugees interaction

gen ref_summer = refugees*summer 
gen ref_clouds = refugees*clouds
gen ref_battle = refugees*battle
gen ref_blockade = refugees*blockade
gen ref_winter = refugees*hot_winter
gen ref_lead = refugees*cast_lead

mlogit mvote ref_summer ref_clouds ref_battle ref_blockade ref_winter ref_lead gaza summer clouds battle blockade hot_winter cast_lead gaza_summer gaza_clouds gaza_battle gaza_blockade gaza_winter gaza_lead fatalities fat_lag1 unemployment r_dwage $demographic $districts $fe_quart, robust cluster(district) rrr
outreg2 using ch4_ref3, excel eform cti(odds ratio)

*****Figure A1 and footnote 8
*The following code is meant for the mathing procedure mentioned in footnote 8 and for figure A1

******************************************************************
* Data Preperation for matching
******************************************************************

use "Gaza\fat_and_econ.dta",clear

*so called treatment districts are the five Gaza Strip districts
generate treatment = (district > 11)


collapse treatment r_dwage unemployment fatalities ,by(district)

save "matching_gaza.dta", replace

*We then use the R code "gaza_matching.Rmd" to find the matched pairs of districts; we already include them in the next lines of code

******************************************************************
* matched pairs analysis
******************************************************************

use "Gaza\master_data.dta", clear

keep if district == 1 | district == 3 | district == 4 | district == 6 | district >= 11

tabstat moderate militant other_fac, by(year_quarter)
tabstat moderate militant other_fac if gaza == 0, by(year_quarter)
tabstat moderate militant other_fac if gaza == 1, by(year_quarter)

*****Figure A2
use "Gaza\faction_support.dta", clear
tabstat Fateh Hamas Islamic_Jihad if district > 11, by(year_quarter)

*****Figure A3
*Figure A3 is calculated manually based on Figure 1. See the figure's notes for more information

*****Footnote 16 (results mentioned as "not shown")
use "Gaza\master_data.dta", clear
global demographic female i.age_group married i.educ_level i.occupation i.sector i.locality_type refugees
global treatment summer clouds battle blockade hot_winter cast_lead
global gaza_treatment gaza_summer gaza_clouds gaza_battle gaza_blockade gaza_winter gaza_lead
global districts i.district
global fe_quart i.year_quarter
*no refugees var
mlogit mvote gaza summer clouds battle blockade hot_winter cast_lead gaza_summer gaza_clouds gaza_battle gaza_blockade gaza_winter gaza_lead fatalities fat_lag1 unemployment r_dwage female i.age_group married i.educ_level i.occupation i.sector i.locality_type $districts $fe_quart, robust cluster(district) rrr
outreg2 using footnote16, excel eform cti(odds ratio)

log close
