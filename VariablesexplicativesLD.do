<<<<<<< HEAD
use Database.dta, clear
replace customs_region="Rennes" if customs_region=="Nantes"
egen exptot_val = sum(value), by(customs_region year export_import)
egen exptot_qty = sum(quantity), by(customs_region year export_import)
collapse exptot_val exptot_qty, by(export_import customs_region year)
keep if (customs_region=="Bordeaux"|customs_region=="Bayonne"|customs_region=="Caen"|customs_region=="La Rochelle"|customs_region=="Marseille"|customs_region=="Montpellier"|customs_region=="Rennes"|customs_region=="Rouen")
gen lexpq=log(exptot_qty)
gen lexpv=log(exptot_val)
egen group = group(customs_region)
gen growth_rate_imports_qty=0
gen growth_rate_imports_val=0
foreach i of num 1/8 {
reg lexpq year if (group==`i'& export_import=="Imports")
replace growth_rate_imports_qty=_b[year] if (group==`i'& export_import=="Imports")
}
foreach i of num 1/8 {
reg lexpv year if (group==`i'& export_import=="Imports")
replace growth_rate_imports_val=_b[year] if (group==`i'& export_import=="Imports")
}
gen growth_rate_exports_qty=0
gen growth_rate_exports_val=0
foreach i of num 1/8 {
reg lexpq year if (group==`i'& export_import=="Exports")
replace growth_rate_exports_qty=_b[year] if (group==`i'& export_import=="Exports")
}
foreach i of num 1/8 {
reg lexpv year if (group==`i'& export_import=="Exports")
replace growth_rate_exports_val=_b[year] if (group==`i'& export_import=="Exports")
}
collapse growth_rate_exports_qty growth_rate_exports_val growth_rate_imports_qty growth_rate_imports_val, by(customs_region)
merge 1:1 customs_region using Réexportations
drop _merge
=======
use Database.dta, clear
replace customs_region="Rennes" if customs_region=="Nantes"
egen exptot_val = sum(value), by(customs_region year export_import)
egen exptot_qty = sum(quantity), by(customs_region year export_import)
collapse exptot_val exptot_qty, by(export_import customs_region year)
keep if (customs_region=="Bordeaux"|customs_region=="Bayonne"|customs_region=="Caen"|customs_region=="La Rochelle"|customs_region=="Marseille"|customs_region=="Montpellier"|customs_region=="Rennes"|customs_region=="Rouen")
gen lexpq=log(exptot_qty)
gen lexpv=log(exptot_val)
egen group = group(customs_region)
gen growth_rate_imports_qty=0
gen growth_rate_imports_val=0
foreach i of num 1/8 {
reg lexpq year if (group==`i'& export_import=="Imports")
replace growth_rate_imports_qty=_b[year] if (group==`i'& export_import=="Imports")
}
foreach i of num 1/8 {
reg lexpv year if (group==`i'& export_import=="Imports")
replace growth_rate_imports_val=_b[year] if (group==`i'& export_import=="Imports")
}
gen growth_rate_exports_qty=0
gen growth_rate_exports_val=0
foreach i of num 1/8 {
reg lexpq year if (group==`i'& export_import=="Exports")
replace growth_rate_exports_qty=_b[year] if (group==`i'& export_import=="Exports")
}
foreach i of num 1/8 {
reg lexpv year if (group==`i'& export_import=="Exports")
replace growth_rate_exports_val=_b[year] if (group==`i'& export_import=="Exports")
}
collapse growth_rate_exports_qty growth_rate_exports_val growth_rate_imports_qty growth_rate_imports_val, by(customs_region)
merge 1:1 customs_region using Réexportations
drop _merge
>>>>>>> 196725a800e1ac19ea48443d74415319f1b2161f
