/*replace Portleplusproche="Bordeaux" if inseesup==33063
replace Portleplusproche="La Rochelle" if inseesup==17300
replace Portleplusproche="Rouen" if inseesup==76540
replace Portleplusproche="Nantes" if inseesup==44109
replace Portleplusproche="Bayonne" if inseesup==64371
replace Portleplusproche="Montpellier" if inseesup==34172
replace Portleplusproche="Rennes" if inseesup==35288*/

use "C:\Users\leong\Desktop\MEMOIRE\Données\RidolfiMergedRéexpBilateral.dta", clear
gen InvDis=1 if trsptot==0
replace InvDis=1/trsptot if trsptot !=0

ren Portleplusproche customs_region

tab occupation, gen(o)
tab gender, gen(g)
tab season, gen(s)
tab food, gen(f)

gen lwage=log(dailywagesous)
gen lreexp=log(reexptot)
foreach var of varlist lreexp year lwage {
egen mean`var' = mean(`var'), by(City)
}

reg lwage meanlwage year meanyear o1-o25 g1 s1-s5 f1-f2 lreexp meanlreexp trsptot c.lreexp#c.InvDis c.meanlreexp#c.InvDis
