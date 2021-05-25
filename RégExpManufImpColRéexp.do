cd "C:\Users\leong\Desktop\MEMOIRE\Données"
use Database, clear
keep if source_type=="Local"
keep if (partner_grouping=="Amériques")
egen impcol=sum(value), by(export_import year customs_region)
collapse impcol, by(customs_region year export_import)
keep if export_import=="Imports"
drop export_import
merge 1:m customs_region year using ExportationsManufacturés2
drop if export_import=="Imports"
drop export_import
drop if _merge !=3
drop _merge
merge 1:m customs_region year using RéexportationsFD
gen war=1 if year<=1715
replace war=1 if (year>=1740&year<=1748)
replace war=1 if (year>=1756&year<=1763)
replace war=1 if (year>=1775&year<=1781)
replace war=0 if war==.
gen war2=1 if (year>=1756&year<=1763)
replace war2=1 if (year>=1775&year<=1781)
replace war2=0 if war2==.
egen panel_id=group(customs_region)
xtset panel_id year

xtreg exptot impcol war year, fe
gen limpcol=log(impcol)
gen lexp=log(exptot)
gen lreexp=log(reexp)

eststo : xtreg lexp limpcol war year, fe
eststo : xtreg lexp lreexp war year, fe
eststo : xtivreg lexp (limpcol=war2) war year, fe
eststo : xtivreg lexp (lreexp=war2) war year, fe

bysort customs_region : gen impcollag=impcol[_n-1] if year[_n-1]==year[_n]-1
bysort customs_region : gen exptotlag=exptot[_n-1] if year[_n-1]==year[_n]-1
gen fdimpcol = impcol-impcollag
gen fdexptot = exptot-exptotlag
xtreg fdexptot fdimpcol war year, fe


gen limpcollag=log(impcollag)
gen lexplag=log(exptotlag)
gen lreexplag=log(lagreexptot)
drop if limpcollag==.
gen fdlimpcol=limpcol-limpcollag
gen fdlexptot=lexp-lexplag
gen fdlreexp=lreexp-lreexplag

eststo : xtreg fdlexptot fdlimpcol war year, fe
eststo : xtreg fdlexptot fdlreexp war year, fe

