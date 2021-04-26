<<<<<<< HEAD
cd "C:\Users\leong\Desktop\MEMOIRE\Données"
use Database.dta, clear
egen exptot_val = sum(value), by(customs_region year export_import)
egen exptot_qty = sum(quantity), by(customs_region year export_import)
collapse exptot_val exptot_qty, by(export_import customs_region year)
keep if (customs_region=="Bordeaux"|customs_region=="Bayonne"|customs_region=="Caen"|customs_region=="La Rochelle"|customs_region=="Marseille"|customs_region=="Montpellier"|customs_region=="Rennes"|customs_region=="Rouen"|customs_region=="Nantes")
=======
use Database.dta, clear
egen exptot_val = sum(value), by(customs_region year export_import)
egen exptot_qty = sum(quantity), by(customs_region year export_import)
collapse exptot_val exptot_qty, by(export_import customs_region year)
keep if (customs_region=="Bordeaux"|customs_region=="Bayonne"|customs_region=="Caen"|customs_region=="La Rochelle"|customs_region=="Marseille"|customs_region=="Montpellier"|customs_region=="Rennes"|customs_region=="Rouen"|customs_region=="Nantes")
>>>>>>> 196725a800e1ac19ea48443d74415319f1b2161f
