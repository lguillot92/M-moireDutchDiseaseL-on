cd "C:\Users\leong\Desktop\MEMOIRE\Données"
use Database, clear
keep if product_threesectors=="Manufactures"
egen exptot = sum(value), by(customs_region year export_import product<_sitc_fr)
collapse exptot, by(customs_region year export_import product_sitc_fr)
drop if export_import=="Imports"
bysort customs_region product_sitc_fr : gen lagexptot=exptot[_n-1] if year==year[_n-1]+1
gen expfd=exptot-lagexptot
drop if expfd==.
