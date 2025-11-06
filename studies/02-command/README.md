# Prosedur Praktik Perintah Dasar Linux (Debian 12)

## Contents:

* [A. Persiapan Lingkungan](#a-persiapan-lingkungan)
* [B. Navigasi Dasar File System](#b-navigasi-dasar-file-system)
* [C. Membuat dan Mengelola File & Folder](#c-membuat-dan-mengelola-file--folder)
* [D. Membaca dan Mengedit File Teks](#d-membaca-dan-mengedit-file-teks)
* [E. Menghapus, Memindah, dan Mengubah Nama File](#e-menghapus-memindah-dan-mengubah-nama-file)
* [F. Pemeriksaan Koneksi Jaringan](#f-pemeriksaan-koneksi-jaringan)
* [G. Mengelola Repository & Update Sistem](#g-mengelola-repository--update-sistem)

---

## A. Persiapan Lingkungan

Sebelum memulai, pastikan Anda memiliki:

* Sistem operasi **Debian 12 (Bookworm)**, baik di VirtualBox atau server fisik.
* Akses login sebagai **user biasa** atau **root**.
* Koneksi internet aktif (untuk bagian repository).

Masuk ke terminal:

```bash
# Jika login sebagai user biasa
siswa@debian:~$

# Jika login sebagai root
root@debian:~#
```

---

## B. Navigasi Dasar File System

Tujuan: memahami struktur direktori dan berpindah antar-folder.

### 1. Mengetahui Posisi Saat Ini

```bash
pwd
```

Output contoh:

```
/home/siswa
```

### 2. Melihat Isi Folder

```bash
ls
```

### 3. Membuat Folder Baru

```bash
mkdir latihan_cli
```

### 4. Masuk ke Folder Tersebut

```bash
cd latihan_cli
```

### 5. Kembali ke Folder Sebelumnya

```bash
cd ..
```

### 6. Menampilkan Folder Secara Detail

```bash
ls -l
```

---

## C. Membuat dan Mengelola File & Folder

Tujuan: belajar membuat dan mengatur file di dalam sistem Linux.

### 1. Membuat File Kosong

```bash
touch data_siswa.txt
```

### 2. Melihat Isi Folder

```bash
ls
```

Output yang diharapkan:

```
data_siswa.txt
```

### 3. Membuat Beberapa File Sekaligus

```bash
touch catatan1.txt catatan2.txt catatan3.txt
```

### 4. Membuat Folder Tambahan

```bash
mkdir dokumen
```

---

## D. Membaca dan Mengedit File Teks

### 1. Membuka File Menggunakan `nano`

```bash
nano data_siswa.txt
```

Tulislah isi berikut:

```
Nama: Rina
Kelas: XII TKJ 1
Alamat: Pasuruan
```

Simpan dengan:

* `Ctrl + O` → Enter
* `Ctrl + X` untuk keluar.

### 2. Melihat Isi File

```bash
cat data_siswa.txt
```

Output:

```
Nama: Rina
Kelas: XII TKJ 1
Alamat: Pasuruan
```

### 3. Menggabungkan Isi Beberapa File

```bash
cat catatan1.txt catatan2.txt > gabungan.txt
```

---

## E. Menghapus, Memindah, dan Mengubah Nama File

### 1. Menghapus File

```bash
rm catatan3.txt
```

### 2. Mengubah Nama File

```bash
mv data_siswa.txt biodata.txt
```

### 3. Memindahkan File ke Folder Lain

```bash
mv biodata.txt dokumen/
```

Verifikasi:

```bash
ls dokumen/
```

---

## F. Pemeriksaan Koneksi Jaringan

Tujuan: memastikan server Debian dapat terhubung ke jaringan dan internet.

### 1. Menampilkan Informasi IP

```bash
ip a
```

Perhatikan baris `inet`, contoh:

```
inet 192.168.10.5/24 brd 192.168.10.255 scope global dynamic eth0
```

### 2. Menguji Koneksi ke Gateway

```bash
ping 192.168.10.1
```

Tekan `Ctrl + C` untuk menghentikan.

### 3. Menguji Koneksi ke Internet

```bash
ping 8.8.8.8
```

### 4. Menguji DNS (Nama Domain)

```bash
ping google.com
```

> 💡 Jika `ping 8.8.8.8` berhasil tetapi `ping google.com` gagal, kemungkinan DNS belum dikonfigurasi dengan benar.
> Cek file berikut:

```bash
cat /etc/resolv.conf
```

---

## G. Mengelola Repository & Update Sistem

### 1. Melihat Daftar Repository Aktif

```bash
cat /etc/apt/sources.list
```

### 2. Menambahkan Repository Indonesia (opsional)

Edit file:

```bash
nano /etc/apt/sources.list
```

Tambahkan:

```
deb http://kartolo.sby.datautama.net.id/debian/ bookworm main contrib non-free
deb http://security.debian.org/debian-security bookworm-security main contrib non-free
deb http://kartolo.sby.datautama.net.id/debian/ bookworm-updates main contrib non-free
```

Simpan dan keluar (`Ctrl + O`, Enter, `Ctrl + X`).

### 3. Memperbarui Daftar Paket

```bash
apt update
```

### 4. Menginstal Paket Dasar Jaringan

```bash
apt install net-tools traceroute -y
```

### 5. Verifikasi Instalasi

```bash
ifconfig
traceroute google.com
```

