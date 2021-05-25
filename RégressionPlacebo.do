use "C:\Users\leong\Desktop\MEMOIRE\Données\Database.dta", clear
keep if source_type=="Local"
tab product_sitc_fr if product_reexportations=="Réexportation"
*keep if product_sitc_fr=="Produits du bois, liège, jonc"
keep if product_sitc_fr=="Huiles, graisses et cires d'origine animale et végétale"
*drop if product_grains=="Pas grain (0)"
*keep if (product_sitc_fr=="Boissons et tabac" & product_reexportation=="Pas réexportation")
keep if export_import=="Exports"
egen exphuiles=sum(value), by(customs_region year)
collapse exphuiles, by(customs_region year)
merge 1:1 customs_region year using RéexportationsFD
*merge 1:1 customs_region year using ImpCol
*ren impcol reexptot
drop if _merge==2
drop _merge
gen war=1 if year<=1715
replace war=1 if (year>=1744&year<=1748)
replace war=1 if (year>=1756&year<=1763)
replace war=1 if (year>=1775&year<=1781)
replace war=0 if war==.
egen panel_id=group(customs_region)
xtset panel_id year
bysort customs_region : gen lagexphuiles=exphuiles[_n-1] if year[_n]==year[_n-1]+1
*bysort customs_region : gen lagreexptot=reexptot[_n-1] if year[_n]==year[_n-1]+1
gen loghuiles=log(exphuiles)
gen logreexp=log(reexptot)
gen logreexplag=log(lagreexptot)
xtreg loghuiles logreexp year i.panel_id#c.year, fe cluster(panel_id)
xtreg loghuiles logreexp war year i.panel_id#c.year, fe cluster(panel_id)
gen loglaghuiles=log(lagexphuiles)
gen fdlogreexp=logreexp-logreexplag
gen fdloghuiles=loghuiles-loglaghuiles
drop if fdlogreexp==.
drop if fdloghuiles==.
xtreg fdloghuiles fdlogreexp war year i.panel_id#c.year, fe cluster(panel_id)
