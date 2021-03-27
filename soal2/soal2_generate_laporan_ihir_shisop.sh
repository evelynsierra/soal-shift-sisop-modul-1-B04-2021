#2a
#
#!/bin/bash
export LC_ALLL=C
awk ' 
BEGIN{FS="\t"}
{
    ProfitPercentage=($21/($18-$21))*100
}
{if (max_pp<=ProfitPercentage){
    max_pp=ProfitPercentage
    RowID=$1
}}
END{
    printf("Transaksi terakhir dengan profit persentase terbesar yaitu %d dengan persentase %d%\n", RowID, max_pp)
} ' /Users/didofabianfayed/Downloads/Laporan-TokoShiSop.tsv > hasil.txt

#no2b
export LC_ALL=
awk '
BEGIN {FS="\t"}
{if ($10=="Albuquerque" && $2~"2017") {name[$7]++}}
END{
printf "\nDaftar nama customer di Albuquerque pada tahun 2017 antara lain:\n"
for (cust in name) {
   printf "%s\n", cust
}} ' /Users/didofabianfayed/Downloads/Laporan-TokoShiSop.tsv > hasil.txt

#soal2c
#$8 == segment "consumer" "corporate" "home office"
export LC_ALL=C
awk 'BEGIN {FS="\t"}
{
    if(1!=NR){
        seg_cust[$8]+=1
    }}
END{
    sales_min=999999
    for (type in seg_cust){
        if (seg_cust[type] < sales_min  )
        {
            sales_min = seg_cust[type]
            min_seg = type
        }}
    printf "\nTipe segmen customer yang penjualannya paling sedikit adalah %s dengan %d transaksi.\n", min_seg, sales_min
} ' /Users/didofabianfayed/Downloads/Laporan-TokoShiSop.tsv >> hasil.txt 

#soal2d
#$13==region "West" "East" "South" "Center")
export LC_ALL=C
awk '
BEGIN {FS="\t"}
{
    if (1!=NR)
    {
        region[$13]+=$21
    }}
END{
    min_prof=999999
    for(reg in region)
    {   
        if(region[reg]<min_prof)
    {
        min_prof = region[reg]
        min_reg = reg
    }}
    printf "\nWilayah bagian (region) yang memiliki total keuntungan (profit) yang paling sedikit adalah %s dengan total keuntungan %.2f\n", min_reg, min_prof
} ' /Users/didofabianfayed/Downloads/Laporan-TokoShiSop.tsv >> hasil.txt 