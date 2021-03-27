#2a
#
#!/bin/bash
export LC_ALLL=C
awk ' 
BEGIN{FS="\t"}
{
    ProfitPercentage=($21/($18-$21)*100)
}
{if (maxPP<=ProfitPercentage){
    maxPP=ProfitPercentage
    RowID=$1
}}
END {
    printf("Transaksi terakhir dengan profit percentage terbesar yaitu %d dengan persentase %d%\n", Row_ID, maxPP)
}' /Users/didofabianfayed/Downloads/Laporan-TokoShiSop.tsv > hasil.txt

#no2b
export LC_ALL=
awk '
BEGIN {FS="\t"}
{if ($10=="Albuquerque" && $2~"2017") {iter[$7]++}}
END {
printf "\nDaftar nama customer di Albuquerque pada tahun 2017 antara lain:\n"
for (nama in iter) {
   printf "%s\n", nama
}} ' /Users/didofabianfayed/Downloads/Laporan-TokoShiSop.tsv > hasil.txt