#!/bin/bash

count=1
rand=$((RANDOM%2))
#1 kucing dulu
#0 kelinci dulu
for ((i=1; i<=23; i=i+1))
do
	if [ $rand -eq 1 ]
	then
		if [ $((i%2)) -eq 1 ]
		then
			wget -a Foto.log https://loremflickr.com/320/240/kitten -O "Kucing_$count.jpg"
        	else 
			wget -a Foto.log https://loremflickr.com/320/240/bunny -O "Kelinci_$count.jpg"
		fi
	else
		if [ $((i%2)) -eq 1 ]
                then
                        wget -a Foto.log https://loremflickr.com/320/240/bunny -O "Kelinci_$count.jpg"
                else
                        wget -a Foto.log https://loremflickr.com/320/240/kitten -O "Kucing_$count.jpg"
                fi
	fi

        let count=$count+1
done

namafile=$(date +"%d-%m-%Y")
mkdir Kucing_$namafile
mkdir Kelinci_$namafile

for ((i=1; i<=23; i=i+1))
do
        	if [ $rand -eq 1 ]
        	then
                	if [ $((i%2)) -eq 1 ]
                	then
                		mv Kucing_$i.jpg Kucing_$namafile
                	else
                        	mv Kelinci_$i.jpg Kelinci_$namafile
                	fi
        	else
                	if [ $((i%2)) -eq 1 ]
                	then
                        	mv Kelinci_$i.jpg Kelinci_$namafile
                	else
                        	mv Kucing_$i.jpg Kucing_$namafile
			fi
                fi
	#fi
done
