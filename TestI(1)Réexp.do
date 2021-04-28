cd "C:\Users\leong\Desktop\MEMOIRE\Données\"
use Database, clear
*drop if product_reexportation=="Pas réexportation"
keep if product_reexportation=="Réexportation"
drop if export_import=="Imports"
egen reexptot=sum(value), by(customs_region year)
collapse reexptot, by (customs_region year)
bysort customs_region : gen lagreexp=reexptot[_n-1] if year==year[_n-1]+1
gen fdreexp=reexptot-lagreexp
reg fdreexp lagreexp
reg fdreexp year lagreexp
bysort customs_region : gen lagfdreexp=fdreexp[_n-1] if year==year[_n-1]+1
reg fdreexp year lagreexp lagfdreexp
reg reexptot year lagreexp
