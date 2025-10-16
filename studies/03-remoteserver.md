---
theme: seriph
background: https://images.unsplash.com/photo-1510511459019-5dda7724fd87?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D
class: text-center
info: |
  ## Administrasi Sistem Jaringan
  Konfigurasi dan Pengujian Remote Server
  Dibuat dengan Slidev untuk SMKN 1 Purwosari

css: slides.css
transition: slide-left
mdc: true
---

# Administrasi Sistem Jaringan

### Konfigurasi dan Pengujian Remote Server

<div class="pt-12">
  <span @click="$slidev.nav.next" class="px-2 py-1 rounded cursor-pointer" hover="bg-white bg-opacity-10">
    Mulai <carbon:arrow-right class="inline"/>
  </span>
</div>

---
transition: fade-out
---

# Tujuan Pembelajaran 

<div>
<ul>
<li>Peserta didik mampu memahami (C2) konsep dasar remote server dan manfaatnya dalam administrasi jaringan.</li>
<li>Peserta didik mampu memahami (C2) cara mengakses server lokal secara remote.</li>
<li>Peserta didik mampu mengkonfigurasi (C3) server lokal untuk diakses secara remote.</li>
<li>Peserta didik mampu mengoperasikan (C3) remote access server menggunakan SSH.</li>
<li>Peserta didik mampu menguraikan (C4) proses koneksi remote server menggunakan SSH.</li>
</ul>
</div>

---
transition: fade-out
---

# Apa itu Remote Server Access?

<div class="grid grid-cols-2 gap-8 items-center">
  <div>
    <p class="text-xl">
      <strong>Remote Server Access</strong> adalah kemampuan untuk mengakses dan mengelola sebuah server dari lokasi yang berbeda (jarak jauh) melalui jaringan.
    </p>
    <br>
    <p class="text-xl">
      Ini memungkinkan administrator untuk melakukan konfigurasi, pemeliharaan, dan pengawasan tanpa harus berada di lokasi fisik server.
    </p>
  </div>
  <div>
```mermaid
graph LR
    Admin["🧑‍💻 Administrator"] -->|Jaringan Internet| Server["💾 Server Fisik"];
```
  </div>
</div>

<style>
h1, h2, h3 {
  background-image: linear-gradient(45deg, #4EC5D4 10%, #146b8c 20%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
}
</style>

---
transition: slide-up
---

# Mengapa Remote Access Penting?

Analogi: Mengelola Toko dari Rumah

<div class="grid grid-cols-2 gap-8 mt-8">
  <div> 
    <v-click>
      <h3 class="text-2xl font-bold text-cyan-500">Tanpa Remote Access (Datang ke Toko)</h3>
      <p class="mt-2">
        Setiap kali perlu mengecek stok, mengatur ulang etalase, atau memperbaiki kasir, Anda harus datang langsung ke toko. Tidak efisien jika Anda punya banyak cabang atau rumah Anda jauh.
      </p>
    </v-click>
  </div>
  <div>
    <v-click>
      <h3 class="text-2xl font-bold text-lime-500">Dengan Remote Access (CCTV & Telepon)</h3>
      <p class="mt-2">
        Anda bisa melihat kondisi toko lewat CCTV (pengawasan), dan memberi instruksi kepada staf lewat telepon (konfigurasi). Jauh lebih efisien, cepat, dan hemat biaya.
      </p>
    </v-click>
  </div>
</div>

---
layout: two-cols
---

# Cara Kerja Remote Server

<style>
  /* reset list spacing */
  ul.no-gap {
    margin: 0;
    padding: 0;
    font-size: 0;
  }

  /* hilangkan gap antar li */
  ul.no-gap li {
    margin: 0;
    padding: 0;
    font-size: 1rem;
  }

  /* buat v-click sebagai blok supaya tidak ada spasi internal,
     dan beri padding kecil untuk kenyamanan klik */
  v-click {
    display: block;
    padding: 0.25rem 0; /* ubah sesuai keinginan */
    cursor: pointer;
  }

  v-click b { display: block; line-height: 1.1; }
  v-click p { margin: 0; font-size: 0.95rem; color: #333; }

  ul.no-gap li + li v-click {
    border-top: 1px solid rgba(0,0,0,0.06);
  }
</style>

Secara sederhana, prosesnya seperti ini:
<ul class="no-gap">
  <li><v-click><b>Client Mengirim Permintaan</b><br>Administrator (client) memulai koneksi ke server.</v-click></li>
  <br>
  <li><v-click><b>Verifikasi & Autentikasi</b><br>Server memeriksa apakah client memiliki izin untuk masuk (username & password, atau kunci digital).</v-click></li>
  <br>
  <li><v-click><b>Koneksi Aman Terbentuk</b><br>Setelah berhasil, sebuah "terowongan" terenkripsi dibuat untuk melindungi data yang dikirim.</v-click></li>
  <br>
  <li><v-click><b>Eksekusi Perintah</b><br>Client dapat mengirimkan perintah, dan server akan menjalankannya seolah-olah perintah itu diketik langsung di server.</v-click></li>
</ul>

::right::

<v-click>
<div class="ml-5 p-10 rounded-lg bg-gray-800">
```mermaid
sequenceDiagram
    participant Client
    participant Server
    Client->>Server: Minta koneksi (misal: SSH)
    Server-->>Client: Minta bukti identitas (autentikasi)
    Client->>Server: Kirim username & password/kunci
    alt Identitas Valid
        Server-->>Client: OK, koneksi diterima!
        Note over Client,Server: Terowongan Terenkripsi Aktif
        Client->>Server: Jalankan perintah `sudo apt update`
        Server-->>Client: Hasil perintah
    else Identitas Tidak Valid
        Server-->>Client: Koneksi ditolak!
    end
```
</div>
<p class="text-sm mt-2 text-center">Diagram alur koneksi remote.</p>
</v-click>

---
layout: two-cols
---

# Ragam Protokol & Sistem Operasi
<style>
  /* reset list spacing */
  ul.no-gap {`
    margin: 0;
    padding: 0;
    font-size: 0;
  }

  /* hilangkan gap antar li */
  ul.no-gap li {
    margin: 0;
    padding: 0;
    font-size: 1rem;
  }

  /* buat v-click sebagai blok supaya tidak ada spasi internal,
     dan beri padding kecil untuk kenyamanan klik */
  v-click {
    display: block;
    padding: 0.25rem 0; /* ubah sesuai keinginan */
    cursor: pointer;
  }

  v-click b { display: block; line-height: 1.1; }
  v-click p { margin: 0; font-size: 0.95rem; color: #333; }

  ul.no-gap li + li v-click {
    border-top: 1px solid rgba(0,0,0,0.06);
  }
</style>
Ada berbagai "bahasa" (protokol) dan "tipe server" (Sistem Operasi) yang digunakan.

<ul class="no-gap">
  <li><v-click><b>Sistem Operasi Server</b>
    <ul>
      <li><b>Linux Server (Ubuntu, CentOS, Debian):</b> Paling umum digunakan, bersifat open-source, dan sangat andal. Biasanya diakses menggunakan SSH.</li>
      <li><b>Windows Server:</b> Sistem operasi dari Microsoft. Biasanya diakses menggunakan RDP.</li>
    </ul>
  </v-click>
  </li>
  <br>
  <li><v-click><b>Protokol Remote Access</b>
    <ul>
      <li><b>SSH (Secure Shell):</b> "Bahasa" berbasis teks yang sangat aman karena terenkripsi. Standar untuk server Linux.</li>
      <li><b>RDP (Remote Desktop Protocol):</b> "Bahasa" berbasis grafis (GUI) untuk Windows. Seolah-olah kita melihat langsung layar monitor server.</li>
    </ul>
  </v-click>
  </li>
</ul>

::right::

<v-click>
<div class="p-4 rounded-lg bg-gray-800">
```mermaid
graph TD
subgraph "Sistem Operasi"
    Linux[("Linux<br>(Ubuntu, Debian)")]
    Windows[("Windows Server")]
end

subgraph "Protokol"
    SSH[("SSH<br>Secure Shell")]
    RDP[("RDP<br>Remote Desktop Protocol")]
end

Admin((<i class="fa fa-user"></i> Admin)) -- Menggunakan --> SSH
Admin -- Menggunakan --> RDP

SSH -- Terhubung ke --> Linux
RDP -- Terhubung ke --> Windows
```
</div>
</v-click>

---
transition: zoom-in
---

# Konfigurasi Dasar Server SSH

Beberapa hal penting yang perlu diatur untuk keamanan:

<div class="grid grid-cols-2 gap-6 mt-6">
  <v-click>
    <div class="p-4 bg-teal-900 rounded-lg">
      <h3 class="text-xl font-bold text-teal-300">Instalasi Layanan</h3>
      <p>Memasang "pintu" SSH di server agar bisa menerima koneksi. <br><code>sudo apt install openssh-server</code></p>
    </div>
  </v-click>
  <v-click>
    <div class="p-4 bg-sky-900 rounded-lg">
      <h3 class="text-xl font-bold text-sky-300">Autentikasi Pengguna</h3>
      <p>Siapa saja yang boleh masuk? Diatur dengan username, password, atau lebih aman lagi dengan SSH Key.</p>
    </div>
  </v-click>
  <v-click>
    <div class="p-4 bg-indigo-900 rounded-lg">
      <h3 class="text-xl font-bold text-indigo-300">Pengaturan Port</h3>
      <p>Mengganti nomor "pintu" (port) default (22) ke nomor lain agar tidak mudah ditemukan penyusup.</p>
    </div>
  </v-click>
    <v-click>
    <div class="p-4 bg-rose-900 rounded-lg">
      <h3 class="text-xl font-bold text-rose-300">Firewall</h3>
      <p>Membuat aturan keamanan, misalnya hanya mengizinkan koneksi dari alamat IP tertentu (misal: IP kantor).</p>
    </div>
  </v-click>
</div>

---
layout: center
class: text-center
transition: zoom-in
---

# Studi Kasus

Mari kita analisis beberapa skenario nyata.

---
transition: zoom-in
---
# Studi Kasus 1

Sebuah perusahaan startup memiliki satu server fisik di kantor pusat mereka di Malang yang digunakan untuk data internal. Perusahaan ini baru saja membuka kantor cabang di Jakarta. Seorang administrator jaringan yang berbasis di Jakarta ditugaskan untuk mengelola server tersebut secara penuh, termasuk melakukan pembaruan sistem, manajemen pengguna, dan pemeliharaan rutin. 

<v-click>
<b>Pertanyaan:</b>
Teknologi dan langkah-langkah apa yang harus disiapkan oleh perusahaan agar administrator di Jakarta dapat mengelola server di Malang secara aman dan efisien tanpa harus datang langsung?
</v-click>
---
transition: zoom-in
---
# Studi Kasus 2

Seorang administrator baru di sebuah sekolah menemukan konfigurasi SSH server yang ada saat ini mengizinkan login root secara langsung (`PermitRootLogin yes`) dan masih menggunakan port default 22. Selain itu, tidak ada pembatasan akses berdasarkan alamat IP. 

<v-click>
<b>Pertanyaan:</b>  
Analisislah tiga risiko keamanan utama yang muncul dari konfigurasi tersebut! Untuk setiap risiko, jelaskan potensi dampaknya jika dieksploitasi oleh pihak yang tidak bertanggung jawab.
</v-click>

---
layout: center
class: text-center
---

# Terima Kasih!

Ada pertanyaan?

<PoweredBySlidev mt-10 />
