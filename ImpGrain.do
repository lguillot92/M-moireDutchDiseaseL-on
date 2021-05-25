use Database.dta, clear
keep if source_type=="Local"
tab product_grains, missing
drop if (product_grains==""|product_grains=="Pas grain (0)")
keep if export_import=="Imports"
egen impgrain=sum(value), by(customs_region year)
collapse impgrain, by(customs_region year)
