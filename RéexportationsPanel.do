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
egen panel_id=group(customs_region)
xtset panel_id year
gen lreexp=log(reexptot)
gen lexp=log(exptot)
xtreg lexp year lreexp (p1-p10)#c.lreexp, fe
xtreg lexp year lreexp (p1-p10)#c.lreexp, re
xtreg exptot year reexptot (p1-p10)#c.reexp, fe
xtreg BalCom reexptot year, fe
