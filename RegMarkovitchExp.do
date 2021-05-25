use "C:\Users\leong\Desktop\MEMOIRE\Données\Markovitch.dta", clear
sort Place year
tab Place
gen Closest_port=""
gen Dis_to_closest_port=0
gen lPieces=log(Pieces)
replace Closest_port="Rouen" if Place=="ALENCON"
replace Dis_to_closest_port=1/156 if Place=="ALENCON"
replace Closest_port="Rouen" if Place=="AMIENS"
replace Dis_to_closest_port=1/179 if Place=="AMIENS"
replace Closest_port="Marseille" if Place=="BOURGOGNE"
replace Dis_to_closest_port=1/504 if Place=="BOURGOGNE"
replace Closest_port="Rouen" if Place=="CHALONS"
replace Dis_to_closest_port=1/398 if Place=="CHALONS"
replace Closest_port="Montpellier" if Place=="GEVAUDAN"
replace Dis_to_closest_port=1/243 if Place=="GEVAUDAN"
replace Closest_port="Bordeaux" if Place=="LIMOGES"
replace Dis_to_closest_port=1/221 if Place=="LIMOGES"
replace Closest_port="Nantes" if Place=="MAINE"
replace Closest_port="Bordeaux" if Place=="MONTAUBAN"
replace Closest_port="Montpellier" if Place=="MONTPELLIER"
replace Closest_port="Montpellier" if Place=="NIMES"
replace Closest_port="Nantes" if Place=="ORLEANS"
replace Closest_port="Rouen" if Place=="ROUEN"
replace Closest_port="Bordeaux" if Place=="TOULOUSE"
replace Dis_to_closest_port=1/244 if Place=="TOULOUSE"
replace Dis_to_closest_port=1 if Place=="ROUEN"
replace Dis_to_closest_port=1/335 if Place=="ORLEANS"
replace Dis_to_closest_port=1 if Place=="MONTPELLIER"
replace Dis_to_closest_port=1/215 if Place=="MONTAUBAN"
replace Dis_to_closest_port=1/57 if Place=="NIMES"
replace Dis_to_closest_port=1/158 if Place=="MAINE"

ren Closest_port customs_region
gen war=1 if year<=1715
replace war=1 if (year>=1740&year<=1748)
replace war=1 if (year>=1756&year<=1763)
replace war=1 if (year>=1775&year<=1781)
replace war=0 if war==.

gen war2=1 if (year>=1756&year<=1763)
replace war2=1 if (year>=1775&year<=1781)
replace war2=0 if war2==.

merge m:1 customs_region year using RéexportationsFD
drop if _merge !=3
egen panel_id=group(Place)
gen lreexp=log(reexptot)
xtset panel_id year
eststo : xtreg lPieces lreexp c.lreexp#c.Dis_to_closest_port year war, fe cluster(panel_id)
eststo : xtivreg lPieces (lreexp=war2) c.lreexp#c.Dis_to_closest_port year war, fe
