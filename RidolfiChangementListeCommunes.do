cd "C:\Users\leong\Desktop\MEMOIRE\Données"
use ComList.dta, clear
tostring comlist1, replace
ren comlist1 com
gen com2=com
replace com2="01053" if com2=="1053"
replace com2="02408" if (com2=="2530"|com2=="2722")
replace com2="03190" if com2=="3190"
replace com2="05061" if com2=="5061"
replace com2="06088" if com2=="6088"
replace com2="07028" if com2=="7028"
replace com2="07185" if com2=="7185"
replace com2="08105" if com2=="8105"
replace com2="07019" if com2=="07028"
replace com2="07019" if com2=="07185"
replace com2="14118" if (com2=="14052"|com2=="14146"|com2=="14499")
replace com2="15014" if com2=="15020"
replace com2="16015" if com2=="16001"
replace com2="16015" if com2=="16392"
replace com2="18033" if com2=="18141"
replace com2="21231" if (com2=="21052"|com2=="21287"|com2=="21436")
replace com2="22278" if com2=="22201"
replace com2="27229" if (com2=="27176"|com2=="27417")
replace com2="29232" if com2=="29039"
replace com2="31555" if com2=="31341"
replace com2="32013" if com2=="32237"
replace com2="33063" if (com2=="33001"|com2=="33318")
replace com2="34172" if com2=="34027"
replace com2="35238" if com2=="35198"
replace com2="36044" if (com2=="36015"|com2=="36166"|com2=="36176")
replace com2="38185" if com2=="38033"
replace com2="40192" if com2=="40048"
replace com2="41018" if com2=="41094"
replace com2="43157" if com2=="43021"
replace com2="45234" if com2=="45106"
replace com2="47001" if (com2=="47062"|com2=="47110")
replace com2="50502" if com2=="50041"
replace com2="51108" if com2=="51045"
replace com2="53130" if (com2=="53078"|com2=="53184")
replace com2="58194" if com2=="58026"
replace com2="59350" if (com2=="59153"|com2=="59183"|com2=="59268"|com2=="59273"|com2=="59400")
replace com2="60057" if com2=="60409"
replace com2="61001" if com2=="61034"
replace com2="63113" if com2=="63031"
replace com2="64445" if (com2=="64102"|com2=="64483")
replace com2="67482" if com2=="67131"
replace com2="68066" if com2=="68224"
replace com2="70550" if com2=="70450"
replace com2="73065" if com2=="73214"
replace com2="75101" if com2=="75056"
replace com2="76540" if strpos(com2,"76")==1
replace com2="77288" if com2=="77375"
replace com2="79191" if com2=="79186"
replace com2="80021" if strpos(com2,"80")==1
replace com2="82121" if strpos(com2,"82")==1
replace com2="84007" if strpos(com2,"84")==1
replace com2="87085" if com2=="87003"
replace com2="89024" if com2=="89183"
replace com2="91200" if com2=="91103"
drop if com2=="94034"
