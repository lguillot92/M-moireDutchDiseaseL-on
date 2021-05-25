clear
import excel "C:\Users\leong\Desktop\MEMOIRE\Données\Données Mémoire.xlsx", sheet("Feuil1") firstrow
rename A year
rename AunesROUEN AunageROUEN
rename AunesALENCON AunageALENCON
rename PiecesBourgogne PiecesBOURGOGNE
reshape long Aunage Pieces Valeurs, i(year) j(Place, string)
egen hasmiss2=rowmiss(Pieces Aunage Valeurs)
drop if hasmiss2==3
