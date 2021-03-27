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