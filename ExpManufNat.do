cd "C:\Users\leong\Desktop\MEMOIRE\Données"
use Database, clear
keep if product_re_aggregate=="Objets manufacturés"
egen exptot = sum(value), by(year export_import)
collapse exptot, by(year export_import)
sort year export_import
gen imptot=exptot[_n+1] if (year[_n+1]==year[_n])
gen BalCom=exptot-imptot
keep if export_import=="Exports"
