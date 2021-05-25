cd "C:\Users\leong\Desktop\MEMOIRE\Données\"
use Database, clear
drop if product_reexportation=="Pas réexportation"
drop if export_import=="Imports"
egen reexptotnat=sum(value), by(year)
collapse reexptotnat, by (year)
merge 1:1 year using ExpManufNat
reg exptot reexptotnat
reg BalCom year reexptotnat
reg exptot year
predict exptothat, xb
reg reexptot year
predict reexptothat, xb
gen exptotres=exptot-exptothat
gen reexptotres=reexptotnat-reexptothat
reg exptotres reexptotres


