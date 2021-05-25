use "C:\Users\leong\Desktop\MEMOIRE\Données\Database.dta", clear
keep if source_type=="Local"
tab product_threesectors if product_reexportations=="Réexportation"
tab product_sitc_fr if product_threesectors=="Manufactures"
egen reexp=sum(value) if (product_reexportations=="Réexportation" & export_import=="Exports" & product_threesectors=="Non-agricultural primary goods"), by(customs_region year)
egen expcol=sum(value) if (partner_grouping=="Amériques" & product_threesectors=="Non-agricultural primary goods" & export_import=="Imports"), by(customs_region year)
egen expind=sum(value) if (product_threesectors=="Manufactures" & export_import=="Exports") , by(customs_region year)
egen exptot=sum(value) if export_import=="Exports", by(customs_region year)
egen exphuiles=sum(value) if (product_sitc_fr=="Huiles, graisses et cires d'origine animale et végétale" & export_import=="Exports"), by(customs_region year)
collapse reexp expcol expind exptot exphuiles, by(customs_region year)
gen sharereexp=reexp/exptot
gen shareimpcol=expcol/exptot
gen shareexpind=expind/exptot
gen shareexphuile=exphuiles/exptot
gen war=1 if year<=1715
replace war=1 if (year>=1744&year<=1748)
replace war=1 if (year>=1756&year<=1763)
replace war=1 if (year>=1775&year<=1781)
replace war=0 if war==.
egen panel_id=group(customs_region)
xtset panel_id year
xtreg shareexpind sharereexp war year c.year#c.year c.year#i.panel_id, fe cluster(panel_id)
xtreg shareexphuile sharereexp war year c.year#c.year c.year#i.panel_id, fe cluster(panel_id)
xtreg shareexpind shareimpcol war year c.year#c.year c.year#i.panel_id, fe cluster(panel_id)
foreach var of varlist sharereexp shareimpcol shareexpind shareexphuile {
bysort customs_region : gen `var'lag=`var'[_n-1] if year[_n-1]==year[_n]-1
}
foreach var of varlist sharereexp shareimpcol shareexpind shareexphuile {
bysort customs_region : gen `var'lag2=`var'[_n-2] if year[_n-2]==year[_n]-2
}


xtivreg shareexpind (sharereexp=sharereexplag sharereexplag2) war year c.year#c.year c.year#i.panel_id, fe
xtivreg shareexphuile (sharereexp=sharereexplag sharereexplag2) war year c.year#c.year c.year#i.panel_id, fe
xtivreg shareexpind (shareimpcol=shareimpcollag shareimpcollag2) war year c.year#c.year c.year#i.panel_id, fe
