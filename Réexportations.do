use Database.dta, clear
replace customs_region="Rennes" if customs_region=="Nantes"
drop if product_reexport=="Pas réexportation"
** keep if product_reexport=="Réexportation" **
egen reexptot_val = sum(value), by(customs_region year)
egen reexptot_qty = sum(quantity), by(customs_region year)
collapse reexptot_val reexptot_qty, by(customs_region year)
keep if (customs_region=="Bordeaux"|customs_region=="Bayonne"|customs_region=="Caen"|customs_region=="La Rochelle"|customs_region=="Marseille"|customs_region=="Montpellier"|customs_region=="Rennes"|customs_region=="Rouen")
gen lrexpv=log(reexptot_val)
gen lrexpq=log(reexptot_qty)
egen group = group(customs_region)
gen growth_rate_reexp_val=0
gen growth_rate_reexp_qty=0
foreach i of num 1/8 {
reg lrexpv year if (group==`i')
replace growth_rate_reexp_val=_b[year] if (group==`i')
}
foreach i of num 1/8 {
reg lrexpq year if (group==`i')
replace growth_rate_reexp_qty=_b[year] if (group==`i')
}
collapse growth_rate_reexp_qty growth_rate_reexp_val, by(customs_region)
