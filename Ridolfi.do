/*import excel "C:\Users\leong\Desktop\MEMOIRE\Données\Salaires_XVIII.xlsx", sheet("Dataset") firstrow clear
ren city City
merge m:1 City using Répertoire
sort _merge
graph box dailywagesousday
drop if dailywagesousday > 100
extremes dailywagesous, iqr(2)
egen stdwage=std(dailywagesous)
tabulate Province
tabulate Généralité
replace Province="Flandres" if Province=="Flandre"
replace Généralité="Rouen" if Généralité=="Rouen " */
use Ridolfi, clear
drop if (Généralité=="Besançon"|Généralité=="Bourges"|Généralité=="Châlons"|Généralité=="Dijon"|Généralité=="Grenoble"|Généralité=="Orléans"|Généralité=="Perpignan"|Généralité=="Poitiers"|Généralité=="Riom"|Généralité=="Tours"|Généralité=="Soissons"|Généralité=="Valenciennes")
drop if Province=="Savoie"
gen lwage=log(dailywagesous)
egen group=group(Généralité)
egen group2=group(Province)
tab occupation, gen(o)
tab gender, gen(g)
tab food, gen(f)
tab season, gen(s)
tab Province, gen(p)
tab Généralité, gen(ge)
reg lwage year (p1-p16)#c.year o1-o64 g1 f1-f3 s1 s3-s6 p1-p16
gen growth_rate_wages=0
forvalues i=1(1)16 {
replace growth_rate_wages=_b[1.p`i'#c.year] if group==`i'
}
replace growth_rate_wages=growth_rate_wages+_b[year]
collapse growth_rate_wages, by(Province)

/*ren Généralité customs_region
replace customs_region="Marseille" if customs_region=="Aix"
replace customs_region="Bayonne" if customs_region=="Pau"
collapse growth_rate_wages, by(customs_region)*/

merge 1:m Province using Memoire
drop if _merge !=3
*drop if customs_region=="Lille"
gen diffpop=Popfin-Popdeb
reg growth_rate_wages growth_rate_reexp_val diffpop
reg growth_rate_wages growth_rate_reexp_qty
reg growth_rate_wages growth_rate_exports_val diffpop
reg lSuperf growth_rate_exports_val growth_rate_wages diffpop
reg lPièces growth_rate_exports_val growth_rate_wages diffpop
