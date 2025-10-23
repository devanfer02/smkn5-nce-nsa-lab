
# Prosedur Praktik SSH Remote Server

## Contents:

- [Installasi OpenSSH Server](#a-installasi-openssh-server)
- [Mengaktifkan Login Root (Berisiko)](#b-mengaktifkan-login-root-berisiko)
- [Mengakses SSH dari Klien Windows](#c-mengakses-ssh-dari-klien-windows)
- [Mengganti Port Default SSH](#d-mengganti-port-default-ssh)
- [Konfigurasi Autentikasi SSH Key (Aman)](#e-konfigurasi-autentikasi-ssh-key-aman)

---

## A. Installasi OpenSSH Server

**Secure Shell (SSH)** adalah protokol jaringan kriptografik yang memungkinkan kita mengelola server secara aman dari jarak jauh. Langkah pertama adalah memastikan layanan SSH (OpenSSH Server) terpasang dan berjalan di server kita.

### 1. Perbarui Daftar Paket

Selalu pastikan daftar paket Anda adalah yang terbaru sebelum melakukan instalasi.
```zsh
apt update
```

### 2\. Install OpenSSH Server

Install paket `openssh-server` menggunakan `apt`.

```zsh
apt install openssh-server
```

### 3\. Cek Status Layanan SSH

Setelah instalasi selesai, pastikan layanan `ssh` (atau `sshd`) aktif dan berjalan.

```zsh
systemctl status ssh
```

Keluaran yang diharapkan:

```zsh
● ssh.service - OpenBSD Secure Shell server
     Loaded: loaded (/lib/systemd/system/ssh.service; enabled; vendor preset: enabled)
     Active: active (running)
```

### 4\. Izinkan SSH di Firewall (Jika UFW Aktif)

Jika Anda menggunakan Uncomplicated Firewall (UFW), pastikan untuk mengizinkan lalu lintas SSH agar Anda tidak terkunci.

```zsh
ufw allow ssh
ufw enable
ufw status
```

Secara default, ini akan membuka port 22.

-----

## B. Mengaktifkan Login Root 

Secara default, banyak sistem modern menonaktifkan login SSH langsung sebagai pengguna `root` karena alasan keamanan. Bagian ini menunjukkan cara mengaktifkannya, namun **praktik ini sangat tidak disarankan untuk server produksi** karena meningkatkan risiko serangan *brute force*.

### 1\. Edit File Konfigurasi SSHD

Buka file konfigurasi utama SSH server menggunakan editor teks seperti `nano`.

```zsh
nano /etc/ssh/sshd_config
```

### 2\. Ubah Opsi `PermitRootLogin`

Cari baris yang bertuliskan `PermitRootLogin`. Biasanya, baris ini diatur ke `prohibit-password` atau `no`.

```nginx
# Authentication:

#LoginGraceTime 2m
#PermitRootLogin prohibit-password
#StrictModes yes
#MaxAuthTries 6
```

Ubah baris `PermitRootLogin` (atau tambahkan jika tidak ada) menjadi:

```nginx
PermitRootLogin yes
```

### 3\. (Opsional) Atur Password Root

Jika pengguna `root` Anda belum memiliki password, Anda harus mengaturnya terlebih dahulu.

```zsh
passwd root
```

Anda akan diminta memasukkan dan mengkonfirmasi password baru.

### 4\. Restart Layanan SSH

Agar perubahan konfigurasi diterapkan, restart layanan SSH.

```zsh
systemctl restart ssh
```

Sekarang, Anda seharusnya bisa login sebagai `root` menggunakan password.

-----

## C. Mengakses SSH dari Klien Windows

Setelah server siap, kita dapat mengaksesnya dari komputer klien. Windows 10 dan 11 sudah menyertakan klien OpenSSH bawaan yang bisa digunakan melalui Terminal, PowerShell, atau Command Prompt.

### 1\. Buka Windows Terminal atau PowerShell

Buka aplikasi terminal pilihan Anda di Windows.

### 2\. Jalankan Perintah SSH

Gunakan perintah `ssh` dengan format `ssh <username>@<alamat-ip-server>`.

```powershell
ssh root@192.168.1.10
```

Ganti `root` dengan user Anda (jika tidak menggunakan root) dan `192.168.1.10` dengan Alamat IP server Anda.

### 3\. Terima Fingerprint Server

Saat pertama kali terhubung, Anda akan melihat pesan peringatan keamanan.

```powershell
The authenticity of host '192.168.1.10 (192.168.1.10)' can't be established.
ED25519 key fingerprint is SHA256:AbCdEfGhIjKlMnOpQrStUvWxYz123456789.
Are you sure you want to continue connecting (yes/no/[fingerprint])?
```

Ketik `yes` dan tekan Enter. Ini akan menyimpan "sidik jari" server di komputer Anda.

### 4\. Masukkan Password

Anda akan diminta memasukkan password untuk pengguna `root` (atau user yang Anda gunakan).

```powershell
root@192.168.1.10's password:
```

Jika berhasil, Anda akan masuk ke shell server.

```zsh
Welcome to Ubuntu 22.04.3 LTS (GNU/Linux 5.15.0-88-generic x86_64)
...
root@server:~#
```

-----

## D. Mengganti Port Default SSH

Menjalankan SSH di port default (22) mengundang banyak bot otomatis yang mencoba melakukan *brute force*. Mengganti port adalah langkah keamanan dasar yang efektif.

### 1\. Edit File Konfigurasi SSHD

Buka kembali file konfigurasi.

```zsh
nano /etc/ssh/sshd_config
```

### 2\. Ubah Opsi `Port`

Cari baris `#Port 22`. Hapus tanda pagar (`#`) di depannya dan ganti `22` dengan nomor port baru yang Anda inginkan (misal: `2222`). Pastikan port tersebut tidak digunakan oleh layanan lain.

```nginx
#Port 22
Port 2222
```

### 3\. Izinkan Port Baru di Firewall

**Langkah Kritis:** Sebelum me-restart SSH, Anda *harus* mengizinkan port baru di firewall, atau Anda akan terkunci dari server.

```zsh
ufw allow 2222/tcp
```

Jika sudah, Anda bisa menghapus aturan lama untuk port 22.

```zsh
ufw delete allow ssh
```

### 4\. Restart Layanan SSH

Terapkan semua perubahan dengan me-restart layanan.

```zsh
systemctl restart ssh
```

### 5\. Akses SSH dengan Port Baru

Dari klien Windows, Anda sekarang harus menentukan port baru menggunakan opsi `-p`.

```powershell
ssh root@192.168.1.10 -p 2222
```

-----

## E. Konfigurasi Autentikasi SSH Key

Metode autentikasi teraman adalah menggunakan pasangan kunci SSH (SSH Key Pair). Ini jauh lebih aman daripada password. Terdiri dari **Private Key** (rahasia, disimpan di klien) dan **Public Key** (dibagikan, disimpan di server).

### 1\. Buat Key Pair (di Klien Windows)

Buka PowerShell di komputer Windows Anda dan jalankan perintah berikut.

```powershell
ssh-keygen -t rsa -b 4096
```

Tekan Enter untuk menerima lokasi file default (misal: `C:\Users\NamaAnda\.ssh\id_rsa`) dan biarkan passphrase kosong (tekan Enter dua kali) untuk login tanpa password.

### 2\. Salin Public Key ke Server

Setelah kunci dibuat, Anda perlu menyalin isi file *public key* (`id_rsa.pub`) ke server. Cara termudah adalah menggunakan `ssh-copy-id`.

```powershell
# Ganti port jika Anda sudah mengubahnya
ssh-copy-id -p 2222 root@192.168.1.10
```

Anda akan diminta memasukkan password `root` untuk *terakhir kalinya*. Perintah ini akan otomatis menyalin public key Anda ke file `/root/.ssh/authorized_keys` di server dengan izin yang benar.

### 3\. (Alternatif) Salin Kunci Manual

Jika `ssh-copy-id` tidak ada, lakukan secara manual:
**Di Klien Windows (PowerShell):**

```powershell
cat $env:USERPROFILE\.ssh\id_rsa.pub
```

Salin (copy) seluruh outputnya (dimulai dari `ssh-rsa ...`).

**Di Server (SSH):**

```zsh
# Buat folder .ssh jika belum ada
mkdir -p /root/.ssh
chmod 700 /root/.ssh

# Buka file authorized_keys
nano /root/.ssh/authorized_keys
```

Tempel (paste) public key yang tadi Anda salin ke dalam file ini. Simpan dan tutup.
Terakhir, atur izin file:

```zsh
chmod 600 /root/.ssh/authorized_keys
```

### 4\. Uji Coba Login dengan Key

Tutup sesi SSH Anda dan coba login kembali.

```powershell
ssh root@192.168.1.10 -p 2222
```

Jika berhasil, Anda akan langsung login ke server **tanpa diminta password**.

### 5\. Nonaktifkan Login Password (Sangat Direkomendasikan)

Setelah login via key berhasil, langkah terakhir adalah menonaktifkan login via password untuk keamanan maksimal.

```zsh
nano /etc/ssh/sshd_config
```

Cari baris `PasswordAuthentication` dan ubah nilainya menjadi `no`.

```nginx
PasswordAuthentication no
```

Jika Anda ingin root *hanya* bisa login dengan key (bukan password), ubah juga:

```nginx
PermitRootLogin prohibit-password
```

### 6\. Restart Layanan SSH

Terapkan perubahan final.

```zsh
systemctl restart ssh
```

Selamat\! Server Anda sekarang hanya bisa diakses menggunakan SSH Key yang aman.

```
```