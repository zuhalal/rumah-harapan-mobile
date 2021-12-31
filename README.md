
[![Pre-Release](https://github.com/zuhalal/rumah-harapan-mobile/actions/workflows/pre-release.yml/badge.svg)](https://github.com/zuhalal/rumah-harapan-mobile/actions/workflows/pre-release.yml)
[![Release](https://github.com/zuhalal/rumah-harapan-mobile/actions/workflows/release.yml/badge.svg)](https://github.com/zuhalal/rumah-harapan-mobile/actions/workflows/release.yml)

# Rumah Harapan 🏠

A PBP B08 Final project.

Berikut link apk kelompok kami https://github.com/zuhalal/rumah-harapan-mobile/releases

## Nama-nama anggota kelompok B08:

1. Andi Afifah Khairunnisa (2006531951)
2. Frigas Hanifyan Zalwi (2006596005)
3. Isabelle Yansim (2006534120)
4. Muhammad Damar Kusumo (2006532903)
5. Nabilah Faujiah (2006596844)
6. Regina Febrian Pehry (2006596882)
7. Zuhal ‘Alimul Hadi (2006531314)

## Cerita aplikasi yang diajukan serta kebermanfaatannya

Sudah lebih dari satu tahun COVID-19 telah melanda Indonesia. Banyak sekali perubahan masyarakat dalam menjalankan kesehariannya, mulai dari adanya WFH (Work From Home) yang menuntut segala hal dilakukan dengan daring dan sebagainya. Selain itu, banyak sekali informasi mengenai COVID-19 yang beredar di media online. Namun, tidak semua informasi yang ada di media sosial mengandung kebenaran. Banyak informasi yang hanya bersifat ikut-ikutan dengan trend yang ada dan malah membawa kebohongan. Untuk itu perlu adanya media yang mengandung segala informasi yang dapat dipertanggungjawabkan kebenarannya.

Dengan kekhawatiran itu, kelompok kami memutuskan membangun sebuah aplikasi web yang dapat menjawab keresahan itu.Aplikasi ini berisikan segala informasi mengenai COVID-19, mulai dari angka penyebaran, angka kematian, sembuh, dan kasus aktif, informasi vaksin, dan sebagainya. Aplikasi ini sangat bermanfaat karena berisikan informasi yang valid dan tercegah dari hoax yang beredar mengenai COVID-19. Selain itu, terdapat artikel-artikel menarik yang dapat ditulis oleh user untuk menyebarkan pengalaman pribadi atau menceritakan sesuatu mengenai COVID-19.

## Daftar modul yang akan diimplementasikan

1. **Home.**
    Halaman ini berisi tentang ringkasan status penyebaran COVID-19 di Indonesia serta beberapa artikel terbaru terkait COVID-19. Untuk mengakses halaman ini, diperlukan autentikasi pengguna, jika tidak, maka hanya akan tampil halaman selamat datang dan tombol untuk login atau register. Pengaplikasian form pada modul ini adalah pada bagian form login atau register.

2. **Donasi.**
    Berisi informasi tentang donasi yang sedang diadakan. Apabila sudah login, pengguna dapat menambahkan donasi yang ingin dia buat. Jika tidak, pengguna hanya bisa melihat donasi-donasi yang ada. 

3. **Artikel.**
    Berisi artikel artikel seputar COVID-19 yang bisa diakses semua pengguna. Namun, hanya pengguna yang sudah login yang dapat berkontribusi untuk menambahkan artikel baru.

4. **Tentang Vaksin.**
    Pada halaman ini diberikan informasi perkembangan vaksin saat ini serta forum diskusi untuk masyarakat membagikan info terkait vaksin seperti jenis, gejala setelah vaksin, KIPI, dan lainnya.

5. **Kontak dan Nomor Penting.**
    Pada halaman ini diberikan informasi kontak lembaga pemerintah, kesehatan, serta kemasyarakatan yang menangani COVID-19. Pengguna yang sudah login dapat menambahkan kontak atau nomor penting setelah melalui validasi oleh admin. 

6. **Update harian COVID-19 di provinsi-provinsi di Indonesia.**
    Pada halaman ini ditampilkan kasus harian COVID-19 pada provinsi di Indonesia. Selain itu ada kotak harapan yang berisi harapan dari pengguna untuk kasus COVID-19 di Indonesia. Untuk menuliskan harapan perlu login terlebih dahulu.

7. **Kritik dan Saran.**
    Pada halaman ini ditampilkan kritik dan saran terkait performa aplikasi yang dapat diakses oleh guest maupun pengguna yang telah melakukan login. Namun, akses untuk menyampaikan kritik dan saran hanya dimiliki oleh pengguna yang telah melakukan login.

## Integrasi dengan Web Service
1. Melengkapi end point pada web untuk tiap modul (baik untuk mengambil dan mengirim data)
2. Menambahkan middleware di Django agar API dapat diakses dari luar website
3. Membuat fungsi async untuk setiap proses yang berkaitan dengan mengambil, mengirim, ataupun mengubah data
4. Untuk mengambil data akan digunakan http.GET dari end point data di web yang hasil pemanggilannya akan digunakan untuk ditampilkan pada widget yang digunakan
5. Untuk mengirim data akan digunakan http.POST yang menuju ke end point untuk menyimpan data yang disimpan di database Django

## Persona 
    1. User Yang Tidak Login    
        - User 1
            - General Information
                1. Nama : Budi
                2. Usia : 28 tahun
                3. Pekerjaan : Karyawan Kantoran
            - Additional Information
                1. Goals : Mencari informasi terkait status COVID-19 di daerah tempat ia bekerja
                2. Motivation : Menghindari hal-hal yang bisa menyebabkan terkena COVID-19
                3. Frustration : Khawatir tertular COVID-19

    2. User Yang Sudah Login  
        - User 2
            - General Information
                1. Nama : Muhammad Uzumaki
                2. Usia : 30 tahun
                3. Pekerjaan : Penyintas COVID-19
            - Additional Information
                1. Goals : Membagikan pengalaman hidupnya ketika positif COVID-19
                2. Motivation : Memberitahu orang lain mengenai hal apa yang dapat dilakukan ketika terkena COVID-19
                3. Frustration : Tingkat positif COVID-19 tidak kunjung menurun

        - User 3
            - General information
                1. Nama : Albertus
                2. Usia : 24 tahun
                3. Pekerjaan : Freelancer
            - Additional Information
                1. Goals : Mendapat kontak rumah sakit terdekat
                2. Motivation : Mencari kontak rumah sakit karena dirinya terkena gejala COVID-19
                3. Frustration : Tidak memiliki daftar kontak penting untuk penanganan COVID-19
