cd "C:\Users\leong\Desktop\MEMOIRE\Données"
use Database, clear
keep if (partner_grouping=="Amériques"|partner_grouping=="Levant et Barbarie")
egen expcol=sum(value), by(export_import year customs_region)
collapse expcol, by(customs_region year export_import)
keep if export_import=="Exports"
drop export_import
merge 1:m customs_region year using ExportationsManufacturés2
drop if export_import=="Imports"
drop export_import
drop if _merge !=3
egen panel_id=group(customs_region)
xtset panel_id year
xtreg exptot expcol year, fe
bysort customs_region : gen expcollag=expcol[_n-1] if year[_n-1]==year[_n]-1
bysort customs_region : gen exptotlag=exptot[_n-1] if year[_n-1]==year[_n]-1
gen fdexpcol = expcol-expcollag
gen fdexptot = exptot-exptotlag
xtreg fdexptot fdexpcol year, fe
