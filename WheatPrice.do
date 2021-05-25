use "C:\Users\leong\Desktop\MEMOIRE\Données\WheatPricesMerged+ImpGrain.dta", clear
tab Province, gen(p)
tab panel_id, gen(pp)
xtset panel_id year
gen limpgrain=log(impgrain)
foreach var of varlist lreexp year lPrice {
egen mean`var' = mean(`var'), by(panel_id)
}
egen meanlimpgrain=mean(limpgrain), by(panel_id)
gen war=1 if year<=1715
replace war=1 if (year>=1744&year<=1748)
replace war=1 if (year>=1756&year<=1763)
replace war=1 if (year>=1775&year<=1781)
replace war=0 if war==.
reg lPrice year meanyear trsptot war limpgrain meanlimpgrain meanlPrice lreexp meanlreexp c.lreexp#c.InvDis c.meanlreexp#c.InvDis
reg lPrice year p1-p17 lreexp trsptot war limpgrain c.lreexp#c.InvDis
