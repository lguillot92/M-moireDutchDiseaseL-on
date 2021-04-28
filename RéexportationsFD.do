cd "C:\Users\leong\Desktop\MEMOIRE\Données\"
use Database, clear
drop if product_reexportation=="Pas réexportation"
drop if export_import=="Imports"
egen reexptot=sum(value), by(customs_region year)
collapse reexptot, by (customs_region year)
sort customs_region year
by customs_region : gen lagreexptot = reexptot[_n-1] if year==year[_n-1]+1
gen fdreexp = reexptot - lagreexptot
merge 1:1 customs_region year using ExpManufFD
drop if _merge !=3
egen panel_id=group(customs_region)
xtset panel_id year
xtreg expfd fdreexp year, fe
