<<<<<<< HEAD
clear all
import excel "C:\Users\leong\Desktop\MEMOIRE\Données\Résumé du Markovitch.xlsx", sheet("Feuil1") firstrow

ren A Région
ren B Généralité
ren C Ville
ren Piècesdéb103 Piècesdéb
ren Piècesfin Piècesfin
foreach var of varlist Piècesdéb Superfdéb {
generate `var'hab = (`var'/Popdeb)*10^3
}
foreach var of varlist Piècesfin Superffin {
generate `var'hab = (`var'/Popfin)*10^3
}
foreach var of varlist Piècesdéb Piècesfin Superfdéb Superffin Valeursdéb Valeursfin Prixdéb Prixfin Piècesdébhab Superfdébhab Piècesfinhab Superffinhab {
generate log`var' = log(`var')
}
drop Colonial
gen col = (Ville=="Rouen"|Ville=="Montpellier"|Ville=="Poitiers"|Ville=="Rennes"|Ville=="La Rochelle"|Ville=="Bordeaux"|Ville=="Aix")
gen diffPièces=Piècesfin-Piècesdéb
gen col2 = (Ville=="Rouen"|Ville=="Montpellier"|Ville=="Rennes"|Ville=="La Rochelle"|Ville=="Bordeaux"|Ville=="Aix")
gen diffPièceshab=Piècesfinhab-Piècesdébhab
gen col3 = (Ville=="Rouen"|Ville=="Montpellier"|Ville=="Rennes"|Ville=="La Rochelle"|Ville=="Bordeaux"|Ville=="Aix"|Ville=="Paris")

gen lPièceshab = logPiècesfinhab - logPiècesdébhab
gen lSuperfhab = logSuperffinhab - logSuperfdébhab
gen lPrix = logPrixfin-logPrixdéb
gen lPièces = logPiècesfin - logPiècesdéb
gen lSuperf = logSuperffin - logSuperfdéb

reg diffPièces col2
reg lPièceshab col2
reg lSuperfhab col2
reg lPrix col2
reg lPrix col3
reg lPrix col


replace Ville="Marseille" if Ville=="Aix"
replace Ville="Bayonne" if Ville=="Pau"
ren Ville customs_region

merge 1:1 customs_region using Explicative 
sort Région

foreach var of varlist growth_rate_exports_qty growth_rate_exports_val growth_rate_imports_val growth_rate_imports_qty growth_rate_reexp_qty growth_rate_reexp_val {
replace `var'=0 if _merge==1
}
reg lPièceshab growth_rate_imports_qty
reg lSuperfhab growth_rate_imports_qty
reg lSuperfhab growth_rate_exports_val
reg lSuperf growth_rate_imports
reg lPièces growth_rate_imports
reg lPièces growth_rate_exports
=======
clear all
import excel "C:\Users\leong\Desktop\MEMOIRE\Données\Résumé du Markovitch.xlsx", sheet("Feuil1") firstrow

ren A Région
ren B Généralité
ren C Ville
ren Piècesdéb103 Piècesdéb
ren Piècesfin Piècesfin
foreach var of varlist Piècesdéb Superfdéb {
generate `var'hab = (`var'/Popdeb)*10^3
}
foreach var of varlist Piècesfin Superffin {
generate `var'hab = (`var'/Popfin)*10^3
}
foreach var of varlist Piècesdéb Piècesfin Superfdéb Superffin Valeursdéb Valeursfin Prixdéb Prixfin Piècesdébhab Superfdébhab Piècesfinhab Superffinhab {
generate log`var' = log(`var')
}
drop Colonial
gen col = (Ville=="Rouen"|Ville=="Montpellier"|Ville=="Poitiers"|Ville=="Rennes"|Ville=="La Rochelle"|Ville=="Bordeaux"|Ville=="Aix")
gen diffPièces=Piècesfin-Piècesdéb
gen col2 = (Ville=="Rouen"|Ville=="Montpellier"|Ville=="Rennes"|Ville=="La Rochelle"|Ville=="Bordeaux"|Ville=="Aix")
gen diffPièceshab=Piècesfinhab-Piècesdébhab
gen col3 = (Ville=="Rouen"|Ville=="Montpellier"|Ville=="Rennes"|Ville=="La Rochelle"|Ville=="Bordeaux"|Ville=="Aix"|Ville=="Paris")

gen lPièceshab = logPiècesfinhab - logPiècesdébhab
gen lSuperfhab = logSuperffinhab - logSuperfdébhab
gen lPrix = logPrixfin-logPrixdéb
gen lPièces = logPiècesfin - logPiècesdéb
gen lSuperf = logSuperffin - logSuperfdéb

reg diffPièces col2
reg lPièceshab col2
reg lSuperfhab col2
reg lPrix col2
reg lPrix col3
reg lPrix col


replace Ville="Marseille" if Ville=="Aix"
replace Ville="Bayonne" if Ville=="Pau"
ren Ville customs_region

merge 1:1 customs_region using Explicative 
sort Région

foreach var of varlist growth_rate_exports_qty growth_rate_exports_val growth_rate_imports_val growth_rate_imports_qty growth_rate_reexp_qty growth_rate_reexp_val {
replace `var'=0 if _merge==1
}
reg lPièceshab growth_rate_imports_qty
reg lSuperfhab growth_rate_imports_qty
reg lSuperfhab growth_rate_exports_val
reg lSuperf growth_rate_imports
reg lPièces growth_rate_imports
reg lPièces growth_rate_exports
>>>>>>> 196725a800e1ac19ea48443d74415319f1b2161f
