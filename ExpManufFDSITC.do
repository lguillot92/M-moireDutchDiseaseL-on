cd "C:\Users\leong\Desktop\MEMOIRE\Données"
use Database, clear
keep if product_threesectors=="Manufactures"
egen exptot = sum(value), by(customs_region year export_import)
collapse exptot, by(customs_region year export_import)
drop if export_import=="Imports"
bysort customs_region : gen lagexptot=exptot[_n-1] if year==year[_n-1]+1
gen expfd=exptot-lagexptot
drop if expfd==.
