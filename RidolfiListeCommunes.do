cd "C:\Users\leong\Desktop\MEMOIRE\Données"
use Ridolfi3.dta, clear
keep if _merge==3
destring com, replace
tab com, matrow(comlist)
matrix list comlist
svmat comlist, names(comlist)
