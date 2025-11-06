# Prosedur Praktik Virtualisasi Menggunakan VirtualBox

## Contents:

* [A. Instalasi VirtualBox di Windows](#a-instalasi-virtualbox-di-windows)
* [B. Mengunduh ISO Debian 12](#b-mengunduh-iso-debian-12)
* [C. Membuat Mesin Virtual Baru](#c-membuat-mesin-virtual-baru)
* [D. Instalasi Debian 12 di VirtualBox](#d-instalasi-debian-12-di-virtualbox)
* [E. Konfigurasi Jaringan VM](#e-konfigurasi-jaringan-vm)
* [F. (Opsional) Snapshot dan Cloning VM](#f-opsional-snapshot-dan-cloning-vm)

---

## A. Instalasi VirtualBox di Windows

**VirtualBox** adalah hypervisor **Type 2** yang berjalan di atas sistem operasi utama (Windows/Linux/macOS) dan memungkinkan kita membuat serta mengelola mesin virtual.

### 1. Unduh VirtualBox

Kunjungi situs resmi VirtualBox:
👉 [https://www.virtualbox.org/wiki/Downloads](https://www.virtualbox.org/wiki/Downloads)

Pilih versi **Windows hosts** dan unduh instalernya.

### 2. Jalankan Installer

Klik dua kali file `.exe` yang telah diunduh, lalu ikuti wizard instalasi.
Biarkan opsi default, kemudian klik **Install**.

### 3. Tambahkan Extension Pack (Opsional)

Extension Pack menambah fitur seperti:

* Dukungan USB 3.0
* Remote Display (VRDP)
* PXE boot

Unduh dari halaman yang sama dan buka file `.vbox-extpack` untuk memasangnya.

---

## B. Mengunduh ISO Debian 12

Debian 12 (Bookworm) adalah sistem operasi server open-source yang ringan dan stabil.

1. Buka situs resmi Debian:
   👉 [https://www.debian.org/distrib/netinst](https://www.debian.org/distrib/netinst)

2. Pilih versi **64-bit PC netinst ISO**.
   File yang diunduh bernama misalnya:

   ```
   debian-12.5.0-amd64-netinst.iso
   ```

3. Simpan file ISO di lokasi mudah diakses, misalnya:

   ```
   C:\Users\<NamaAnda>\Downloads\debian.iso
   ```

---

## C. Membuat Mesin Virtual Baru

Langkah ini membuat wadah kosong tempat Debian 12 akan diinstal.

### 1. Buka VirtualBox → Klik **New**

Isi data sebagai berikut:

| Field   | Nilai             |
| ------- | ----------------- |
| Name    | `Debian12-Server` |
| Type    | `Linux`           |
| Version | `Debian (64-bit)` |

### 2. Alokasi Resource

| Komponen     | Rekomendasi                        |
| ------------ | ---------------------------------- |
| Memory (RAM) | 2048 MB (2 GB) atau lebih          |
| CPU          | 2 Core                             |
| Hard Disk    | 20 GB (VDI, Dynamically allocated) |

### 3. Tambahkan ISO Debian

Buka tab **Settings → Storage**
Klik ikon CD → **Choose a disk file...**
Pilih file `debian-12.5.0-amd64-netinst.iso` yang sudah diunduh sebelumnya.

---

## D. Instalasi Debian 12 di VirtualBox

### 1. Jalankan VM

Klik **Start** untuk mem-boot Debian dari ISO.

### 2. Pilih Bahasa dan Lokasi

Ikuti wizard instalasi Debian:

* Language: **English**
* Location: **Other → Asia → Indonesia**
* Keyboard: **American English**

### 3. Konfigurasi Jaringan

* Hostname: `debian-server`
* Domain name: biarkan kosong atau isi `local`

### 4. Atur Password Root dan User

* Root password: `toor` *(hanya untuk lab)*
* Full name: `admin`
* Username: `admin`
* User password: `admin123`

### 5. Partisi Disk

Pilih:

```
Guided - use entire disk
All files in one partition
Finish partitioning and write changes to disk
```

### 6. Pilih Paket yang Diinstal

Centang:

* [x] SSH server
* [x] standard system utilities

Hapus pilihan Desktop Environment agar ringan.

### 7. Instalasi Bootloader

Pilih **Yes** untuk install GRUB ke MBR.
Pilih disk utama `/dev/sda`.

Setelah selesai, sistem akan reboot dan Debian siap digunakan.

---

## E. Konfigurasi Jaringan VM

Setelah Debian berhasil booting, kita perlu memastikan VM bisa berkomunikasi.

### 1. Periksa Mode Jaringan

Klik kanan pada VM → **Settings → Network**

* **Adapter 1:** NAT (untuk akses internet)
* **Adapter 2:** Host-Only Adapter (untuk komunikasi dengan PC host)

### 2. Periksa IP Address di Debian

Masuk ke terminal Debian (login sebagai `root`):

```bash
ip a
```

Output contoh:

```bash
2: enp0s3: inet 10.0.2.15/24
3: enp0s8: inet 192.168.56.101/24
```

### 3. Uji Koneksi Internet

```bash
ping -c 4 google.com
```

Jika berhasil, jaringan NAT berfungsi.

### 4. Uji Koneksi ke Host

Dari Windows, buka Command Prompt:

```powershell
ping 192.168.56.101
```

Jika balas, koneksi host–guest sudah aktif.

---
