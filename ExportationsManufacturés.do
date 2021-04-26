cd "C:\Users\leong\Desktop\MEMOIRE\Données"
use Database, clear
keep if product_re_aggregate=="Objets manufacturés"
egen exptot = sum(value), by(customs_region year export_import product_sitc_fr)
collapse exptot, by(customs_region year export_import product_sitc_fr)
tab customs_region
sort customs_region year export_import product_sitc_fr
