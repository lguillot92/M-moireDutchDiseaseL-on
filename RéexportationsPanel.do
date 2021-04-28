cd "C:\Users\leong\Desktop\MEMOIRE\Données\"
use Database, clear
drop if product_reexportation=="Pas réexportation"
*keep if product_reexportation=="Réexportation"
drop if export_import=="Imports"
egen reexptot=sum(value), by(customs_region year)
collapse reexptot, by (customs_region year)
tab customs_region
*merge 1:m customs_region year using ExportationsTextile*
merge 1:m customs_region year using ExportationsManufacturés2
drop if _merge != 3
drop if export_import=="Imports"
*tab product_luxe, missing gen(l)
/*tab product_sitc_fr, missing gen(p)
drop if (p1==1|p5==1|p14==1|p15==1)
drop p1-p15
tab product_sitc_fr, missing gen(p)
egen panel_id=group(customs_region product_sitc_fr)*/
gen war=1 if year<=1715
replace war=1 if (year>=1740&year<=1748)
replace war=1 if (year>=1756&year<=1763)
replace war=1 if (year>=1775&year<=1781)
replace war=0 if war==.
egen panel_id=group(customs_region)
xtset panel_id year
gen lreexp=log(reexptot)
gen lexp=log(exptot)
bysort customs_region : gen reexplag=reexptot[_n-1] if year[_n-1]==year[_n]-1
bysort customs_region : gen exptotlag=exptot[_n-1] if year[_n-1]==year[_n]-1
gen fdreexp=reexptot-reexplag
gen fdexptot=exptot-exptotlag
gen lreexplag=log(reexplag)
gen lexplag=log(exptotlag)
gen lfdreexp=lreexp-lreexplag
gen lfdexptot=lexp-lexplag
drop if fdreexp==.
xtreg lexp year war lreexp, fe vce(cluster panel_id)
xtreg lexp year lreexp war, re vce (cluster panel_id)
xtreg exptot year reexptot war, fe vce (cluster panel_id)
xtreg BalCom reexptot year war, fe vce (cluster panel_id)
xtreg fdexptot fdreexp year war, fe vce(cluster panel_id)
xtreg lfdexptot lfdreexp year war, fe vce (cluster panel_id)
