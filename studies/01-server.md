---
theme: seriph
background: https://reverus.com/wp-content/uploads/2020/10/picture-of-a-server_October1.jpg
class: text-center
info: |
  ## Presentasi Server dan Virtualisasi
  Dibuat dengan Slidev

transition: slide-left
mdc: true

---

# Server & Virtualisasi

Membuka Jendela ke Dunia Komputasi Modern

---
transition: fade-out
---

# Arsitektur Jaringan

Ada dua model utama dalam arsitektur jaringan komputer:

<div class="grid grid-cols-2 gap-8 mt-8">
  <div> 
    <v-click>
      <h3 class="text-2xl font-bold text-cyan-500">Peer-to-Peer (P2P)</h3>
      <p class="mt-2">Setiap komputer memiliki kedudukan yang sama, dapat bertindak sebagai klien maupun server.</p>
      <div class="mt-4">
```mermaid {theme: 'neutral', scale: 0.8}
graph TD
    A[Computer 1] -- Data --- B[Computer 2]
    B -- Data --- A
    A -- Data --- C[Computer 3]
    C -- Data --- A
    B -- Data --- C
    C -- Data --- B
```
      </div>
    </v-click>
  </div>
  <div>
    <v-click>
      <h3 class="text-2xl font-bold text-lime-500">Client-Server</h3>
      <p class="mt-2">Terdapat server pusat yang menyediakan layanan dan klien yang meminta layanan tersebut.</p>
      <div class="mt-4">
```mermaid {theme: 'neutral', scale: 0.8}
graph TD
    subgraph " "
        direction LR
        A[Client 1]
        B[Client 2]
        C[Client 3]
    end
    S[Server]
    A -- Request --> S
    B -- Request --> S
    C -- Request --> S
    S -- Response --> A
    S -- Response --> B
    S -- Response --> C
```
      </div>
    </v-click>
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

# Apa itu Server?

<div class="grid grid-cols-2 gap-8 items-center">
  <div>
    <p class="text-xl">
      Secara sederhana, <strong>server</strong> adalah komputer atau program yang menyediakan layanan untuk komputer lain (klien) dalam sebuah jaringan.
    </p>
    <ul class="mt-4 list-disc pl-6 text-left">
      <li>Menyimpan, mengelola, dan mengirimkan data.</li>
      <li>Menjalankan aplikasi dan layanan.</li>
      <li>Mengatur akses dan keamanan jaringan.</li>
    </ul>
  </div>
  <div>
    <img src="https://images.unsplash.com/photo-1548544027-1a96c4c24c7a?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" class="rounded-lg shadow-lg">
  </div>
</div>

---
layout: two-cols
---

# Fungsi Utama Server

Server memiliki beragam fungsi sesuai dengan kebutuhannya.

<ul>
  <li><v-click>Web Server: Menyajikan halaman web ke browser. (Contoh: Apache, Nginx) </v-click></li>
  <li><v-click>File Server: Menyimpan dan berbagi file dalam jaringan. </v-click></li>
  <li><v-click>Database Server: Mengelola dan menyediakan akses ke database. (Contoh: MySQL, PostgreSQL) </v-click></li>
  <li><v-click>Mail Server: Mengelola pengiriman dan penerimaan email. </v-click></li>
  <li><v-click>DNS Server: Menyimpan daftar nama domain dan alamat IP yang sesuai. </v-click></li>
</ul>

::right::

<v-click>
<div class="p-4 rounded-lg bg-gray-800">
```mermaid
graph LR
    subgraph "Internet"
        U[User]
    end
    subgraph "Server"
        W[Web Server]
        D[Database Server]
        F[File Server]
    end
    U -- HTTPS --> W
    W -- SQL Query --> D
    W -- File Request --> F
```
</div>
<p class="text-sm mt-2 text-center">Interaksi antara berbagai jenis server.</p>
</v-click>

---
transition: zoom-in
---

# Virtualisasi: Kekuatan Super di Dunia Server

<div class="text-center">
  <p class="text-2xl mt-4">
    Virtualisasi adalah teknologi yang memungkinkan kita untuk membuat beberapa lingkungan simulasi atau sumber daya khusus dari satu sistem perangkat keras fisik.
  </p>
  <div class="mt-8">
```mermaid {theme: 'forest', scale: 0.9}
graph TD
    subgraph "Hardware Fisik"
        H[CPU, RAM, Storage]
    end
    subgraph "Hypervisor (Lapisan Virtualisasi)"
        V[VMware, KVM, Hyper-V]
    end
    subgraph "Mesin Virtual (VM)"
        VM1[VM 1: Web Server]
        VM2[VM 2: Database Server]
        VM3[VM 3: Mail Server]
    end
    H --> V
    V --> VM1
    V --> VM2
    V --> VM3
```
  </div>
</div>

---
transition: slide-left
layout: image-right
---

# Analogi Virtualisasi

Bayangkan sebuah warnet

- **Gedung Apartemen (Hardware Fisik):** Satu bangunan fisik dengan semua sumber daya dasarnya (struktur, listrik, air).
- **Setiap Unit Apartemen (Mesin Virtual):** Setiap unit adalah ruang yang terisolasi dan mandiri. Penghuni dapat mendekorasi dan menggunakannya sesuka mereka, tanpa mempengaruhi unit lain.
- **Manajemen Gedung (Hypervisor):** Mengelola alokasi sumber daya (listrik, air) ke setiap unit dan memastikan semuanya berjalan lancar.

---
transition: slide-left
layout: two-cols
---

# Tipe Virtualisasi

<div>
<v-click>
<h5>Type 1 Virtualisasi</h5>

- Hypervisor diinstal langsung di hardware fisik
- Tidak butuh sistem operasi utama untuk berjalan.
- Performa sangat cepat dan Punya akses langsung ke sumber daya server
- Contoh: Proxmox, WMWare ESXi

</v-click>
</div>

<div>
<v-click>
<h5>Type 2 Virtualisasi</h5>

- Hypervisor diinstal dan berjalan sebagai aplikasi biasa.
- Butuh sistem operasi utama seperti Windows, MacOS atau Linux
- Performa lebih lambat dan Akses ke hardware tidak langsung
- Contoh: VirtualBox VMWare Workstation

</v-click>
</div>

::right::

<v-click>

<img src="https://tecadmin.net/wp-content/uploads/2023/09/type-1-vs-type-2-virtualization.png" />

Perbedaan Type 1 Virtualisasi vs Type 2 Virtualisasi

</v-click>

---
transition: fade

---

# Mengapa Menggunakan Virtualisasi?

Virtualisasi menawarkan banyak keuntungan signifikan.

<div class="grid grid-cols-2 gap-6 mt-6">
  <v-click>
    <div class="p-4 bg-teal-900 rounded-lg">
      <h3 class="text-xl font-bold text-teal-300">Efisiensi Biaya</h3>
      <p>Mengurangi jumlah server fisik yang dibutuhkan, menghemat biaya perangkat keras, listrik, dan pendinginan.</p>
    </div>
  </v-click>
  <v-click>
    <div class="p-4 bg-sky-900 rounded-lg">
      <h3 class="text-xl font-bold text-sky-300">Pemanfaatan Sumber Daya</h3>
      <p>Memaksimalkan penggunaan kapasitas hardware yang seringkali tidak terpakai penuh.</p>
    </div>
  </v-click>
  <v-click>
    <div class="p-4 bg-indigo-900 rounded-lg">
      <h3 class="text-xl font-bold text-indigo-300">Isolasi & Keamanan</h3>
      <p>Setiap mesin virtual terisolasi. Jika satu VM mengalami masalah, VM lain tidak akan terpengaruh.</p>
    </div>
  </v-click>
  <v-click>
    <div class="p-4 bg-purple-900 rounded-lg">
      <h3 class="text-xl font-bold text-purple-300">Fleksibilitas & Skalabilitas</h3>
      <p>Mudah untuk membuat, memindahkan, dan mengubah ukuran server virtual sesuai kebutuhan.</p>
    </div>
  </v-click>
</div>

---
layout: center
class: text-center
---

# Terima Kasih!

Ada pertanyaan?

<PoweredBySlidev mt-10 />