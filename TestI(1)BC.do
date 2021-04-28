cd "C:\Users\leong\Desktop\MEMOIRE\Données"
use ExportationsManufacturés2, clear
sort customs_region year export_import
by customs_region : gen lagBC=BalCom[_n-2] if year[_n]==year[_n-2]+1
drop if BalCom==.
drop if lagBC==.
gen diffBC=BalCom-lagBC
reg diffBC year lagBC
reg BalCom lagBC year
