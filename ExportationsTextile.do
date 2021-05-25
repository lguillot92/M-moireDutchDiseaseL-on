cd "C:\Users\leong\Desktop\MEMOIRE\Données"
use Database, clear
keep if source_type=="Local"
drop if product_type_textile==""
egen exptot = sum(value), by(customs_region year export_import product_luxe_dans_type)
collapse exptot, by(customs_region year export_import product_luxe_dans_type)
tab customs_region
sort customs_region year product_luxe_dans_type export_import
