use "C:\Users\leong\Desktop\MEMOIRE\Données\Database.dta", clear
keep if source_type=="Local"
tab product_sitc_fr if product_reexportations=="Réexportation"
tab product_sitc_fr if product_threesectors=="Manufactures"
keep if export_import=="Exports"
egen exphuiles=sum(value) if product_sitc_fr=="Huiles, graisses et cires d'origine animale et végétale", by(customs_region year)
egen expbois=sum(value) if product_sitc_fr=="Produits du bois, liège, jonc", by(customs_region year)
egen reexp=sum(value) if product_reexportations=="Réexportation", by(customs_region year)
egen expgrain=sum(value) if product_grain != "Pas grain", by(customs_region year)
egen expcol=sum(value) if partner_grouping=="Amériques", by(customs_region year)
egen expind=sum(value) if product_threesectors=="Manufactures", by(customs_region year)
egen expmerdouille=sum(value) if product_sitc_fr=="Matières brutes non-comestibles non transformées n.d.a.", by(customs_region year)
collapse expbois exphuiles reexp expgrain expcol expind expmerdouille, by(customs_region year)
egen panel_id=group(customs_region)
xtset panel_id year
xtreg expmerdouille reexp year i.panel_id#c.year, fe 
foreach var of varlist expbois exphuiles reexp expgrain expcol expind expmerdouille {
gen log`var'=log(`var')
}
foreach var of varlist expboistot exphuilestot reexptot expgraintot expcoltot expindtot expmerdouilletot {
gen log`var'=log(`var')
}
foreach var of varlist expbois exphuiles reexp expgrain expcol expind expmerdouille {
egen `var'tot=sum(`var'),by(year)
}
foreach var of varlist expbois exphuiles reexp expgrain expcol expind expmerdouille {
bysort customs_region : gen `var'lag=`var'[_n-1] if year[_n-1]==year[_n]-1
}
foreach var of varlist expbois exphuiles reexp expgrain expcol expind expmerdouille {
gen l`var'lag=log(`var'lag)
gen fdl`var'=log`var'-l`var'lag
}
foreach var of varlist expbois exphuiles expgrain expind expmerdouille {
xtreg fdl`var' fdlreexp war year c.year#c.year i.panel_id#c.year, fe cluster(panel_id)
xtreg fdl`var' fdlexpcol war year c.year#c.year i.panel_id#c.year, fe cluster(panel_id)
}

foreach var of varlist logexpbois logexphuiles logexpgrain logexpind logexpmerdouille {
xtreg `var' logexpcol year i.panel_id#c.year, fe cluster(panel_id)
}
foreach var of varlist logexpbois logexphuiles logexpcol logexpind logexpmerdouille {
xtreg `var' logexpgrain year i.panel_id#c.year, fe cluster(panel_id)
}
xtreg logexpind logexpgrain logexpbois logexphuiles logreexp logexpmerdouille year i.panel_id#c.year, fe cluster(panel_id)

gen war=1 if year<=1715
replace war=1 if (year>=1744&year<=1748)
replace war=1 if (year>=1756&year<=1763)
replace war=1 if (year>=1775&year<=1781)
replace war=0 if war==.
egen log

xtivreg logexpind (logexpcol=logexpcoltot) year i.panel_id#c.year, fe
xtivreg logexpgrain (logexpcol=logexpcoltot) year i.panel_id#c.year, fe
