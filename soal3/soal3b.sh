#!/bin/bash
 
namafile=$(date +"%d-%m-%Y")
mkdir $namafile

bash /home/zahrotuladillah/Documents/Sisop/Modul1/Praktikum/no3/soal3a.sh
mv Koleksi_*.jpg $namafile
mv Foto.log $namafile
