cd "C:\Users\leong\Desktop\MEMOIRE\Données"
use Database, clear
keep if product_re_aggregate=="Objets manufacturés"
egen exptot = sum(value), by(customs_region year export_import)
collapse exptot, by(customs_region year export_import)
tab customs_region
sort customs_region year export_import
by customs_region : gen imptot=exptot[_n+1] if (year[_n+1]==year[_n])
gen BalCom=exptot-imptot
