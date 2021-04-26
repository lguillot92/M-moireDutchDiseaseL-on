<<<<<<< HEAD
use Ridolfi.dta, clear
tab occupation, gen(o)
tab gender, gen(g)
tab food, gen(f)
tab season, gen(s)
gen lwage=log(dailywagesous)
reg lwage year o1-o66 g1 f1-f3 s1 s3-s6
predict wagehat
reg lwage year if(occupation=="Maçon" & gender=="homme" & food=="non nourri")
predict wagehat2 
graph twoway scatter lwage year if(occupation=="Maçon" & gender=="homme" & food=="non nourri")
graph twoway line wagehat year if(occupation=="Maçon" & gender=="homme" & food=="non nourri" & season=="NA")
=======
use Ridolfi.dta, clear
tab occupation, gen(o)
tab gender, gen(g)
tab food, gen(f)
tab season, gen(s)
gen lwage=log(dailywagesous)
reg lwage year o1-o66 g1 f1-f3 s1 s3-s6
predict wagehat
reg lwage year if(occupation=="Maçon" & gender=="homme" & food=="non nourri")
predict wagehat2 
graph twoway scatter lwage year if(occupation=="Maçon" & gender=="homme" & food=="non nourri")
graph twoway line wagehat year if(occupation=="Maçon" & gender=="homme" & food=="non nourri" & season=="NA")
>>>>>>> 196725a800e1ac19ea48443d74415319f1b2161f
