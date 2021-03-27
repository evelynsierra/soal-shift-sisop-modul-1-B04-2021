#!/bin/bash

#soal 1d
ambil_text(){
    result="";
    for i in "{@:2}"
    do
    result="$result $i"
    done
    echo "$result,$1" > > "error_message.csv"
}

#file error_message.csv
echo "ERROR,COUNT" > "error_message.csv"

#dapatkan jenis pesan error dan jumlahnya
grep -P -o "(?<=ERROR ).*(?=\()" syslog.log |sort|uniq -c|sort -nr|while read text
do
 ambil_text $text;
done

#soal 1e
#buat file user_statistic.csv
echo "Username,INFO,ERROR\n" > "user_statistic.csv"
#filter dari error, info
grep -P -o "(ERROR|INFO)(.*)" syslog.log|sort|uniq | while read text
do
#dapatkan username,info,error
username=($(grep -w "(?<=\().*(?=\))" "$text"|sort|uniq))
info=($(grep -w "(INFO)" "$text"|sort|uniq -c))
error=($(grep -w "(ERROR)" "$text"|sort|uniq -c))
done

printf "%s,%d,%d" "$username" "$info" "$error" >> "user_statistic.csv"

