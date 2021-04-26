cd "C:\Users\leong\Desktop\MEMOIRE\Données"
use Database, clear
keep if product_sitc_fr=="Filés ou tissés de laine et de poil"
egen exptot = sum(value), by(customs_region year export_import product_luxe_dans_type)
collapse exptot, by(customs_region year export_import product_luxe_dans_type)
tab customs_region
sort customs_region year export_import product_luxe_dans_type
