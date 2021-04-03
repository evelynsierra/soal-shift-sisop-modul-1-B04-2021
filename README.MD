# SISOP Modul 1 #
## Anggota Kelompok ##

NRP | NAMA
------------- | -------------
05111940000111  | Evelyn Sierra
05111940000059  | Dido Fabian Fayed
05111940000139  | Zahrotul Adillah

## SOAL 1 ##
Soal 1 diminta untuk membuat 2 laporan yaitu daftar peringkat pesan error (error_message.csv) dan pengguna user (user_statistic.csv). Untuk membuat laporan tersebut maka diperlukan informasi dari log aplikasi yang terdapat pada file `syslog.log`. Informasi yang diperlukan antara lain : jenis log (ERROR/INFO), pesan log dan username pada tiap baris dan menampilkan semua pesan error yang muncul beserta jumlah kemunculannya. Serta harus dapat menampilkan jumlah kemunculan log ERROR dan INFO untuk setiap usernya
### 1D ###

Untuk mengerjakan poin mendapatkan jenis pesan error serta jumlah kemunculannya, gunakan grep untuk mendapatkan baris yang mengandung kata `ERROR`, disort dan dihitung kemunculannya

```
grep -P -o "(?<=ERROR ).*(?=\()" syslog.log |sort|uniq -c|sort -nr
```

Setelah mendapatkan semua baris yang mengandung kata `ERROR`, maka dilakukan looping per barisnya dan menulis format yang diinginkan
```
grep -P -o "(?<=ERROR ).*(?=\()" syslog.log |sort|uniq -c|sort -nr|while read text
do
 ambil_text $text;
done
```

Gunakan function `ambil_text()` untuk mendapatkan angka count yang ada di depannya($1), serta `{@:2}` menandakan untuk mengambil kalimat setelah spasi pertama
```
ambil_text(){
    result="";
    for i in "{@:2}"
    do
    result="$result $i"
    done
    echo "$result,$1" > > "error_message.csv"
}
```

Sehingga hasil akhir coding adalah
```
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
```

### 1E ###
Pada soal 1e, kita membutuhkan semua informasi yang dapat menampiilkan jumlah kemunculan log `ERROR` dan `INFO` untuk setiap user-nya. Sehingga, langkah pertama yang dilakukan adalah menghitung berapa banyak kemunculan user yang sama dan disort secara ascending
```
grep -E -o '.* (\(.*\))' "$file" | sed  's/.*(\(.*\))/\1/' | sort | uniq -c 
```

Setelah mendapatkan jumlah kemunculan user, maka dari setiap user di loop untuk mendapatkan jumlah log `ERROR` dan `INFO`.
```
grep -E -o '.* (\(.*\))' "$file" | sed  's/.*(\(.*\))/\1/' | sort | uniq -c | while read count username
do
    countinfo=`grep -E -o ".* (INFO) .* (\($name\))" "$file" | sed  's/.*(\(.*\))/\1/' | wc -l | sed 's/^[ \t]*//'`
    counterror=`grep -E -o ".* (ERROR) .* (\($name\))" "$file" | sed  's/.*(\(.*\))/\1/' | wc -l | sed 's/^[ \t]*//'`
    echo $username,$countinfo,$counterror >> "$filename"
done 
```

Data yang diperoleh akan dimasukkin ke dalam file `user_statistic.csv`
```
file="syslog.log"
filename="user_statistic.csv"

echo Username,INFO,ERROR >> "$filename"

grep -E -o '.* (\(.*\))' "$file" | sed  's/.*(\(.*\))/\1/' | sort | uniq -c | while read count username
do
    countinfo=`grep -E -o ".* (INFO) .* (\($name\))" "$file" | sed  's/.*(\(.*\))/\1/' | wc -l | sed 's/^[ \t]*//'`
    counterror=`grep -E -o ".* (ERROR) .* (\($name\))" "$file" | sed  's/.*(\(.*\))/\1/' | wc -l | sed 's/^[ \t]*//'`
    echo $username,$countinfo,$counterror >> "$filename"
done 
```

## SOAL 2 ##
Pada soal nomor 2 ini kita diminta untuk mengunduh file dari link <https://drive.google.com/file/d/16GuWWg3tZpzO7lTKmyVF6I9JPFYJQFJ8/view?usp=sharing> terlebih dahulu agar bisa mengerjakan soal ini. Untuk memproses file yang memiliki banyak data seperti soal no 2 ini maka diunakanlah `awk` dalam penyelesaianya.
### 2A ###
Permasalahan pada soal 2A adalah kita diminta untuk menghitung persentase keuntungan terbesar berdasarkan file tsv yang sudah kita unduh sebelumnya.
```
export LC_ALLL=C
awk ' 
BEGIN{FS="\t"}
```
`LC_ALL=C` ini digunakan sebagai untuk membaca data yang dengan titik (.) agar terbaca sebagai desimal. Digunakan karena data-data (angka) pada file tsv Toko ShiSop menggunakan titik.
Variabel `BEGIN` sebagai special rule dalam awk dan `FS="\t"` sebagai file separator dengan menggunakan tab karena sesuai pada format file Toko ShiSop yaitu tsv (Tab Separator Value) yang dipisahkan oleh tab pada setiap datanya.
```
{
    ProfitPercentage=($21/($18-$21))*100 
}
```
Pada section `BEGIN` ini melakukan perhitungan untuk mencari data yang memiliki persentase keuntungan terbesar.
Untuk mencari persentase keuntungan terbesar, sesuai pada soal maka digunakanlah rumus berikut `ProfitPercentage=($21/($18-$21))*100 `. Yaitu PROFIT PERCENTAGE=PROFIT COST PRICE X100%. Profit Cost Price sendiri didapatkan dari `$18-$21` yaitu data pada kolom Profit dikurangi dengan Penjualan. 
```
{if (max_pp<=ProfitPercentage){
    max_pp=ProfitPercentage
    RowID=$1
}}
```
Selanjutnya diinisiasi variabel baru yaitu `max_pp` sebagai pembanding. `max_pp<= ProfitPercentage` digunakan untuk membandingkan setiap datanya harus selalu lebih besar dari `max_pp` agar datanya dapat terupdate. `max-pp=ProfitPercentage` adalah syntax untuk menyimpan nilai persentase profit terbesar yang didapatkan setelah perhitungan.
Pada `END` section digunakan untuk print hasil Persentase Terbesar. `/Users/didofabianfayed/Downloads/Laporan-TokoShiSop.tsv` merupuakan direktori file Toko ShiSop sebagai input dari soal 2 ini.
### 2B ###
```
export LC_ALL=
awk '
BEGIN {FS="\t"}
{if ($10=="Albuquerque" && $2~"2017") {name[$7]++}}
END {
printf "\nDaftar nama customer di Albuquerque pada tahun 2017 antara lain:\n"
for (cust in name) {
   printf "%s\n", cust
}} ' /Users/didofabianfayed/Downloads/Laporan-TokoShiSop.tsv >> hasil.txt
```
Pada permasalahan di soal B ini kita diminta untuk menampilkan daftar nama customer yang melakukan transaksi di Albuquerque pada tahun 2017. Sama dengan soal A, pada soal ini tetap menggunakan `awk` dalam memproses data dan `FS="\t"` sebagai file separator. 
```
{if ($10=="Albuquerque" && $2~"2017") {name[$7]++}}
```
Pada `BEGIN` dilakukan pemrosesan untuk mencari daftar nama yang melakukan transaksi di Albuquerque pada 2017. `$10` mengambil data `City` pada file Toko ShiSop, `$2` adalah kolom `Order ID` yang mengandung tahun transaksi sedangkan `$2` mengambil data pada kolom `Customer Name`.
`$10=="Albuquerque"`memanggil data `Albuquerque` di kolom `City` dan `$2~"2017"` digunakan untuk mendapatkan data yang mengandung string yang sama yaitu `2017`.
`name [$7]++` merupakan associative array dimana setiap menemukan data transaksi di kota Albuquerque paa 2017 yang di print adalah indexnya sehingga tidak diprint nama yang sama meskipun melakukan transaksi lebih dari 1 kali.
```
for (cust in name)
   ```
Pada `END` ini akan melakukan iterasi pada setiap elemen `cust` yang selanjutnya akan di print sesuai dengan format ketentuan pada soal.
### 2C ###
Selanjutnya, pada soal C ini kita diminta untuk menampilkan tipe segmen customer yang memiliki penjualan paling sedikit.
```
export LC_ALL=C
awk 'BEGIN {FS="\t"}
{
    if(1!=NR){
        seg_cust[$8]+=1
    }}
```
Pada `BEGIN` terdapat kondisi `if(1!=NR)` dimana `1!=NR` untuk membaca setiap baris dengan mengabaikan baris pertama pada tabel di file Toko ShiSop (dianggap bukan data), data akan dibaca mulai baris kedua.
`$8` data dari kolom `Segment` yang berisi `Home Office`, `Corporate` dan `Customer`. Array `seg_cust[$8]` bermaksud sebagai index dan penghitung transaksi sebagai valuenya. 
```
END{
    sales_min=999999
    for (type in seg_cust){
        if (seg_cust[type] < sales_min  )
        {
            sales_min = seg_cust[type]
            min_seg = type
        }}
```
Untuk mencari tipe segmen mana yang memiliki penjualan terkecil maka dilakukan lah proses pada section `END` ini. 
`sales_min=999999` adalah variabel pembanding yang valuenya harus dipastikan tidak lebih kecil dari total penjualan setiap segmenya (`seg_cust[type]< sales_min`).
Akan melakukan iterasi pada `for` untuk mengecek element pada setiap segment yang selanjutnya akan menyimpan array `seg_cust[type]` dan index `type` pada variabel `sales_min` dan `min_seg`.
Selanjutnya hasil pemrosesan data akan di print sesuai dengan ketentuan pada soal.
```
printf "\nTipe segmen customer yang penjualannya paling sedikit adalah %s dengan %d transaksi.\n", min_seg, sales_min
```
### 2D ###
Pada soal D kita diminta untuk mencari wilayah region yang memiliki jumlah keuntungan paling sedikit. Data yang digunakan pada soal ini adalah data pada kolom `$13` yakni kolom `Region` yang berisi `West`, `East`, `South` dan `Central`.
Sama seperti soal-soal sebelumnya, soal D ini tetap menggunakan `awk` dnegan `BEGIN` dan `END` sebagai special rule.
```
awk '
BEGIN {FS="\t"}
{
    if (1!=NR)
    {
        region[$13]+=$21
    }}
```
Mirip seperti soal C, soal ini juga mempertimbangkan kondisi `if (1!=NR)` untuk membaca semua baris kecuali baris pertama (header=bukan data).
Selanjutnya `region[$13]+=$21` dengan aray `region[&13]` sebagai index dan `$21` merujuk pada kolom `Profit` sebagai valuenya. Syntax ini akan menjumlahkan .

### 2E ###


## SOAL 3 ##
### 3A ###
Pada soal diminta untuk mengunduh 23 gambar kucing dari link <https://loremflickr.com/320/240/kitten> dengan syarat tidak ada gambar yang sama
```bash
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
```
Variabel `count` merupakan variabel untuk menandai berapa gambar yang telah diunduh tanpa duplikasi.
Jalannya kode diawali oleh perulangan `for` dari 1 sampai 23 lalu menggunakan `wget` untuk mengunduh file, `-a` untuk menyimpan log foto yang telah diunduh ke file `Foto.log`, dan `-O` untuk mengubah nama file.
Setelah mengunduh gambar, akan dicek dari gambar pertama sampai gambar sebelum sekarang apakah ada duplikasi dengan menggunakan `comm`. Untuk `&>/dev/null` merupakan singkatan untuk `>/dev/null 2>&1` yang berfungsi mengarahkan file deskriptor 2 (STDERR) dan deskriptor 1 (STDOUT) ke `/dev/null` atau dibuang. Setelah dibandingkan, ketika gambar sama, maka gambar yang terbaru akan diremove menggunakan `-rm` dan tentu saja `count` akan dikurangi. Setiap `iterasi i`, variabel `count` akan ditambahkan.
Karena pada soal diminta untuk menggunakan format file `Koleksi_XX`, dilakukan perulangan dari 1-9 seperti di bawah ini
```bash
for ((i=1; i<10; i=i+1))
do
	if [ -f Koleksi_$i.jpg ]
	then
		mv Koleksi_$i.jpg Koleksi_0$i.jpg
	fi
done
```
Pada tiap iterasi akan dicek terlebih dahulu apakah file tersedia menggunakan `-f`, jika iya maka nama file akan diganti sesuai format menggunakan `mv`.

### 3B ###
Pada soal ini diminta untuk menjalankan script `soal3a.sh` sehari sekali pada jam 8 malam untuk tanggal-tanggal tertentu setiap bulan, yaitu dari tanggal 1 tujuh hari sekali (1,8,...), serta dari tanggal 2 empat hari sekali(2,6,...). Supaya lebih rapi, gambar yang telah diunduh beserta log-nya, dipindahkan ke folder dengan nama tanggal unduhnya dengan format "DD-MM-YYYY"
```bash
namafile=$(date +"%d-%m-%Y")
mkdir $namafile

bash /home/zahrotuladillah/Documents/Sisop/Modul1/Praktikum/no3/soal3a.sh
mv Koleksi_*.jpg $namafile
mv Foto.log $namafile
```
Di sini digunakan `mkdir` untuk membuat folder baru dengan nama sesuai format dan memindahkan gambar yang telah diunduh beserta lognya pada script `soal3a.sh` dengan `mv`.
Script dijalankan dengan crontab berikut
```bash
* 20 1-31/7 * * /bin/bash /home/zahrotuladillah/Documents/Sisop/Modul1/Praktikum/no3/soal3b.sh
* 20 2-31/4 * * /bin/bash /home/zahrotuladillah/Documents/Sisop/Modul1/Praktikum/no3/soal3b.sh
```

### 3C ###
Berbeda dengan soal sebelumnya, selain gambar kucing, pada soal ini diminta untuk mengunduh gambar kelinci pada <https://loremflickr.com/320/240/bunny> lalu mengunduhnya gambar kucing dan kelinci secara bergantian.
```bash
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
```
Di sini digunakan variabel `rand` untuk fungsi randomize angka 0 dan 1. jika keluar angka 1, maka akan mengunduh kucing terlebih dahulu, jika 0 maka kelinci terlebih dahulu. Setelah itu akan dilakukan pengunduhan secara bergantian menggunakan looping dengan menggunakan bantuan cek iterasi ganjil-genap.
Selain itu, file gambar yang telah diunduh dikelompokkan menjadi folder kucing dan kelinci untuk membedakannya.
```bash
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
```
Folder kucing dan kelinci dibuat terlebih dahulu menggunakan `mkdir`, lalu iterasi dari 1-23 untuk mengecek apakah gambar tersebut kucing atau kelinci dengan menggunakan cara yang sama dan memindahkannya ke folder yang sesuai.

### 3D ###
Pada soal ini, folder-folder yang telah dibuat diminta untuk dipindahkan ke zip bernama `Koleksi.zip` dan menguncinya dengan password berupa tanggal saat ini dengan format "MMDDYYYY".
```bash
pass=$(date +"%m%d%Y")
zip -mqr Koleksi.zip ./Kelinci* ./Kucing* -P $pass
```
Digunakan `mqr` yang dapat dijabarkan `-m` untuk move folder ke zip dan otomatis menghapus folder di OS, `-q` yang merupakan quiet berfungsi untuk menyembunyikan pesan saat operasi berlangsung, `-r` untuk zip file-file yang ada dalam direktori/folder secara rekursif, dan `-P` yang berfungsi untuk set password.

### 3E ###
Pada soal terakhir ini diminta untuk **zip** folder pada jam 7 pagi sampai 6 sore hari senin-jumat, selain itu folder akan di**unzip** tanpa sisa zip file.
```bash
#zip
0 7 * * 1-5 /bin/bash /home/zahrotuladillah/Documents/Sisop/Modul1/Praktikum/no3/soal3d.sh
```
Perintah **zip** dijalankan dimulai dari jam 7 pagi pada hari senin-jumat dengan menjalankan script `soal3d` yang berfungsi untuk zip folder. 
```bash
#unzip
0 18 * * 1-5 cd /home/zahrotuladillah/Documents/Sisop/Modul1/Praktikum/no3 && pass=$(date +"%m%d%Y") && unzip -P $pass Koleksi.zip && rm Koleksi.zip
```
Perintah **unzip** dijalankan dimulai dari jam 6 sore dengan `unzip` diikuti `rm` untuk menghilangkan zip file.

## Kendala ##
- Cara menjalankan cron jobs
- Cara menggunakan regex yang tepat
