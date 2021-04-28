use "C:\Users\leong\Desktop\MEMOIRE\Données\WheatPrices.dta", clear
/*ds Year, not
foreach i in `r(varlist)' {
ren `i' Market`i'
}
gen id=_n
reshape long Market, i(id) j(Place, string)
ren Market Price
drop id
sort Place Year
egen miss = rowmiss(Year Price)
drop if miss==1
drop miss*/
gen lPrice=log(Price)
tab Province, gen(p)
reg lPrice Year p1-p18 (p1-p18)#c.Year
