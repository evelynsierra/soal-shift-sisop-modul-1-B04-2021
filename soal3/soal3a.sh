#!/bin/bash

count=1
for ((i=1; i<=23; i=i+1))
do
	wget -a Foto.log https://loremflickr.com/320/240/kitten -O "Koleksi_$count.jpg"
	for ((j=1; j<$count; j=j+1))
	do
		if comm Koleksi_$j.jpg Koleksi_$count.jpg &> /dev/null
		then
			rm Koleksi_$count.jpg
			let count=$count-1
			break
		fi
	done
	let count=$count+1
done

for ((i=1; i<10; i=i+1))
do
	if [ -f Koleksi_$i.jpg ]
	then
		mv Koleksi_$i.jpg Koleksi_0$i.jpg
	fi
done

