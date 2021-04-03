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
file="syslog.log"
filename="user_statistic.csv"

echo Username,INFO,ERROR >> "$filename"

#Mendapatkan total log dari masing-masing username
grep -E -o '.* (\(.*\))' "$file" | sed  's/.*(\(.*\))/\1/' | sort | uniq -c | while read count username
do 
#dapatkan jumlah INFO dan ERROR dari masing-masing user
    countinfo=`grep -E -o ".* (INFO) .* (\($name\))" "$file" | sed  's/.*(\(.*\))/\1/' | wc -l | sed 's/^[ \t]*//'`
    counterror=`grep -E -o ".* (ERROR) .* (\($name\))" "$file" | sed  's/.*(\(.*\))/\1/' | wc -l | sed 's/^[ \t]*//'`
    echo $username,$countinfo,$counterror >> "$filename"
done 

