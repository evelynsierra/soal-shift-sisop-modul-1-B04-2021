#**SISOP Modul 1**

NRP | NAMA
------------- | -------------
05111940000111  | Evelyn Sierra
05111940000059  | Dido Fabian Fayed
05111940000139  | Zahrotul Adillah

##**SOAL 1**

##**SOAL 2**

##**SOAL 3
###3A**
Pada soal diminta untuk mengunduh 23 gambar kucing dari link `https://loremflickr.com/320/240/kitten` dengan syarat tidak ada gambar yang sama
```count=1
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
done```
Variabel 'count' merupakan variabel untuk menandai berapa gambar yang telah diunduh tanpa duplikasi.
Jalannya kode diawali oleh perulangan `for` dari 1 sampai 23 lalu menggunakan `wget` untuk mengunduh file, `-a` untuk menyimpan log foto yang telah diunduh ke file `Foto.log`, dan `-O` untuk mengubah nama file.
Setelah mengunduh gambar, akan dicek dari gambar pertama sampai gambar sebelum sekarang apakah ada duplikasi dengan menggunakan `comm`. Untuk `&>/dev/null` merupakan singkatan untuk `>/dev/null 2>&1` yang berfungsi mengarahkan file deskriptor 2 (STDERR) dan deskriptor 1 (STDOUT) ke `/dev/null` atau dibuang. Setelah dibandingkan, ketika gambar sama, maka gambar yang terbaru akan diremove menggunakan 'rm' dan tentu saja 'count' akan dikurangi. Setiap 'iterasi i', variabel 'count' akan ditambahkan.
Karena pada soal diminta untuk menggunakan format file 'Koleksi_XX', dilakukan perulangan dari 1-9 seperti di bawah ini
```for ((i=1; i<10; i=i+1))
do
	if [ -f Koleksi_$i.jpg ]
	then
		mv Koleksi_$i.jpg Koleksi_0$i.jpg
	fi
done```
Pada tiap iterasi akan dicek terlebih dahulu apakah file tersedia menggunakan `-f`, jika iya maka nama file akan diganti sesuai format menggunakan 'rm'.






