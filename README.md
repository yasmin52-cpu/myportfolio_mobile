# MyPortfolio Mobile — Portofolio Pribadi

## Deskripsi

Aplikasi mobile portofolio pribadi berbasis **Flutter** untuk mata kuliah **Pemrograman Berbasis Platform (CSGE602022)**, Fakultas Ilmu Komputer Universitas Indonesia, Semester Gasal 2026/2027.

Aplikasi ini merupakan pengembangan mobile dari proyek portofolio pribadi yang sebelumnya dibangun menggunakan Django. Pengembangan Flutter dimulai pada Tutorial 08 dengan mempelajari struktur proyek, widget, Material Design, dan penyusunan antarmuka menggunakan `StatelessWidget`.

Pada Individual Assignment 7, aplikasi dikembangkan dengan menampilkan informasi profil pribadi menggunakan `InfoCard` serta tiga tombol menu portofolio menggunakan `ItemCard`. Setiap tombol memiliki ikon dan warna berbeda, serta dapat menampilkan notifikasi `SnackBar` ketika ditekan.

Aplikasi mobile ini masih berfokus pada antarmuka dan interaksi dasar Flutter. Integrasi dengan backend Django, navigasi ke halaman portofolio, dan autentikasi mobile belum diimplementasikan.

* **Nama:** Yasmin
* **NPM:** 2506606124
* **Kelas:** PBP B

## Teknologi

* **Flutter** — Framework untuk mengembangkan aplikasi multiplatform.
* **Dart** — Bahasa pemrograman aplikasi Flutter.
* **Material Design 3** — Sistem desain antarmuka melalui `MaterialApp` dan `ThemeData`.
* **StatelessWidget** — Membuat komponen antarmuka yang tidak mengelola state internal yang berubah.
* **Scaffold, AppBar, Row, Column, GridView** — Mengatur struktur dan tata letak halaman.
* **Card, Material, InkWell** — Membuat kartu informasi dan tombol interaktif.
* **ScaffoldMessenger dan SnackBar** — Menampilkan feedback saat tombol ditekan.
* **Git dan GitHub** — Version control dan penyimpanan source code.

## Struktur Proyek

```
myportfolio_mobile/
├── android/                 # Konfigurasi dan source code Android
├── ios/                     # Konfigurasi dan source code iOS
├── linux/                   # Konfigurasi aplikasi Linux
├── macos/                   # Konfigurasi aplikasi macOS
├── windows/                 # Konfigurasi aplikasi Windows
├── web/                     # Konfigurasi aplikasi web
│   ├── icons/               # Ikon aplikasi web
│   ├── favicon.png          # Ikon pada tab browser
│   ├── index.html           # Entry point HTML untuk Flutter Web
│   └── manifest.json        # Metadata aplikasi web
├── lib/                     # Source code utama aplikasi Flutter
│   ├── main.dart            # Entry point dan konfigurasi MaterialApp
│   └── menu.dart            # MyHomePage, InfoCard, ItemCard, ItemHomepage
├── test/                    # Pengujian aplikasi
│   └── widget_test.dart     # File pengujian widget Flutter
├── .gitignore               # Daftar file/folder yang diabaikan Git
├── .metadata                # Metadata proyek Flutter
├── analysis_options.yaml    # Konfigurasi static analysis Dart
├── pubspec.yaml             # Konfigurasi proyek dan dependencies
├── pubspec.lock             # Versi dependencies yang digunakan
└── README.md                # Dokumentasi proyek dan AI disclosure
```

Penjelasan file utama:

* `lib/main.dart`: Entry point aplikasi, berisi `main()`, `MyApp`, dan konfigurasi `MaterialApp`.
* `lib/menu.dart`: Berisi halaman `MyHomePage`, model `ItemHomepage`, serta komponen `InfoCard` dan `ItemCard`.
* `pubspec.yaml`: Mengelola informasi proyek dan dependency Flutter.
* `analysis_options.yaml`: Mengatur aturan static analysis untuk kode Dart.
* `README.md`: Berisi dokumentasi proyek, refleksi tugas, dan AI disclosure.

## Cara Menjalankan

1. Pastikan Flutter SDK dan environment pengembangan sudah terpasang.
2. Clone repositori GitHub proyek Flutter dan masuk ke direktori proyek.
3. Install dependency:

```bash
flutter pub get
```

4. Periksa perangkat atau emulator yang tersedia:

```bash
flutter devices
```

5. Jalankan aplikasi:

```bash
flutter run
```

Untuk menjalankan aplikasi melalui Chrome:

```bash
flutter run -d chrome
```

6. Periksa kualitas kode dengan static analyzer:

```bash
flutter analyze
```

Target hasil analisis adalah `No issues found!`.

## Fitur

### Informasi Profil

Menampilkan tiga kartu informasi menggunakan custom widget `InfoCard`:

* **NPM:** 2506606124
* **Name:** Yasmin
* **Class:** PBP B

### Menu Portofolio

Menampilkan tiga tombol menggunakan custom widget `ItemCard`:

* **Lihat Proyek** — Ikon folder.
* **Tambah Proyek** — Ikon add circle.
* **Logout** — Ikon logout.

Setiap tombol menggunakan warna yang ditentukan melalui atribut `color` pada model `ItemHomepage`, sehingga tidak diperlukan percabangan untuk menentukan warna masing-masing tombol.

### Interaktivitas SnackBar

Setiap `ItemCard` menggunakan `InkWell` untuk menangani interaksi pengguna. Ketika tombol ditekan, aplikasi menampilkan pesan:

`Kamu telah menekan tombol [Nama Tombol]!`

Pesan ditampilkan melalui `ScaffoldMessenger` dan menyesuaikan nama tombol yang ditekan.

---

# Dokumentasi Tugas

### Tugas 7

**1. Widget Tree dan Hubungan Parent-Child**

Di Flutter, semua komponen seperti tombol dan teks adalah widget. **Widget tree** adalah struktur pohon yang menggambarkan hubungan antar-widget dalam aplikasi Flutter.

Hubungan parent-child bekerja seperti ini:
- Widget **parent** membungkus widget **child**.
- Parent dapat mengatur layout dan memberikan konfigurasi untuk child-nya.

**2. Widget yang Digunakan dalam Proyek MyPortfolio Mobile**

Dalam proyek MyPortfolio Mobile, saya menggunakan beberapa widget bawaan Flutter dan custom widget, yaitu:

| Widget | Fungsi |
|---|---|
| `MyApp` | Widget utama untuk mengatur konfigurasi aplikasi. |
| `MaterialApp` | Mengatur tema dan halaman utama aplikasi menggunakan Material Design. |
| `MyHomePage` | Custom widget yang menampilkan halaman utama portofolio. |
| `Scaffold` | Menyediakan struktur dasar halaman, seperti AppBar dan body. |
| `AppBar` | Menampilkan judul aplikasi pada bagian atas layar. |
| `Text` | Menampilkan teks seperti informasi profil, pesan sambutan, dan nama tombol. |
| `Padding` | Memberikan jarak antara widget dengan area di sekitarnya. |
| `Column` | Menyusun beberapa widget secara vertikal. |
| `Row` | Menyusun tiga `InfoCard` secara horizontal. |
| `Center` | Memposisikan child widget di tengah. |
| `SizedBox` | Memberikan jarak kosong antar-widget. |
| `GridView` | Menyusun tombol menu portofolio dalam bentuk grid tiga kolom. |
| `InfoCard` | Custom widget untuk menampilkan NPM, nama, dan kelas. |
| `Card` | Membuat tampilan kartu informasi profil. |
| `Container` | Mengatur ukuran dan padding pada elemen antarmuka. |
| `ItemCard` | Custom widget untuk menampilkan tombol menu portofolio. |
| `Material` | Memberikan warna latar dan bentuk pada tombol menu. |
| `InkWell` | Mendeteksi interaksi tap dan memberikan efek visual ketika tombol ditekan. |
| `Icon` | Menampilkan ikon sesuai fungsi setiap tombol. |
| `SnackBar` | Menampilkan notifikasi singkat ketika pengguna menekan tombol. |

Selain widget tersebut, saya menggunakan class `ItemHomepage` sebagai model data yang menyimpan nama, ikon, dan warna setiap tombol.

**3. Fungsi `MaterialApp`**

Di sini, `MaterialApp` mempunyai tiga properti penting:
- `title`: Menentukan judul aplikasi pada level sistem.
- `theme`: Menentukan konfigurasi tema aplikasi. Saya memakai seed color indigo dan secondary amber.
- `home`: Menentukan halaman pertama yang ditampilkan, yaitu `MyHomePage`.

**Alasan umum dijadikan root:** widget Material membutuhkan ancestor seperti `Theme` dan `Navigator` di atasnya di dalam tree. Dengan menaruh `MaterialApp` di puncak, semua widget di bawahnya otomatis bisa mengakses tema, navigasi, dan konfigurasi global lewat `BuildContext`.

Pada proyek MyPortfolio Mobile, `MaterialApp` tidak menjadi root widget secara langsung karena dibungkus oleh custom widget `MyApp`. `MyApp` merupakan root widget yang diberikan kepada `runApp()`, sedangkan `MaterialApp` menjadi widget utama yang mengatur konfigurasi aplikasi melalui properti `title`, `theme`, dan `home`.

**4. StatelessWidget vs StatefulWidget**

| Aspek | StatelessWidget | StatefulWidget |
|---|---|---|
| State | Tidak punya state yang berubah | Punya state yang bisa berubah |
| Tampilan | Hanya bergantung pada konfigurasi (parameter) yang diberikan | Bergantung pada konfigurasi dan state internal |
| Rebuild | Hanya jika parent memberi konfigurasi baru | Juga bisa lewat `setState()` |
| Struktur | Satu kelas dengan `build()` | Dua kelas: widget dan `State`, dengan `initState()`, `dispose()`, dll. |

Pada proyek MyPortfolio Mobile, saya menggunakan `StatelessWidget` pada `MyApp`, `MyHomePage`, `InfoCard`, dan `ItemCard` karena komponen-komponen tersebut tidak perlu mengelola state internal yang berubah. Walaupun `ItemCard` dapat menampilkan `SnackBar` ketika ditekan, widget tersebut tetap dapat menggunakan `StatelessWidget` karena tampilan `SnackBar` dikelola oleh `ScaffoldMessenger`.

`StatefulWidget` lebih tepat digunakan ketika aplikasi membutuhkan pengelolaan state lokal, misalnya penghitung angka, checkbox, atau form yang tampilannya berubah sesuai input pengguna.

**5. BuildContext**

`BuildContext` merepresentasikan lokasi sebuah widget dalam widget tree.

Flutter menggunakan context untuk menemukan informasi atau layanan yang disediakan oleh widget ancestor. Sebagai contoh, `ScaffoldMessenger.of(context)` mencari `ScaffoldMessenger` terdekat yang tersedia melalui widget tree untuk menampilkan `SnackBar`.

**6. Hot Reload vs Hot Restart**

**Hot reload**
- Menyuntikkan kode yang sudah diubah ke Dart VM yang sedang berjalan, lalu membangun ulang widget tree.
- State dipertahankan (misalnya nilai counter tetap).
- Sangat cepat, cocok untuk mengubah UI, warna, teks, atau layout.

**Hot restart**
- Memuat ulang seluruh kode dan menjalankan ulang aplikasi dari `main()`.
- State direset ke kondisi awal.
- Lebih lambat dari hot reload, tetapi jauh lebih cepat dari full restart.

**Kapan hot reload saja tidak cukup (perlu hot restart):**
- Mengubah nilai awal state atau variabel global/static (misalnya `int _count = 0` diubah ke `10`): state lama tetap, jadi perlu hot restart.
- Mengubah isi `main()`, `initState()`, atau kode inisialisasi lain yang hanya jalan sekali.
- Mengubah enum, atau mengubah kelas (misalnya dari `StatelessWidget` ke `StatefulWidget`, atau sebaliknya).
- Mengubah tipe generik atau struktur kelas tertentu yang tidak bisa disuntikkan.

**Kapan perlu full restart (stop lalu run ulang):**
- Menambah atau mengubah dependency di `pubspec.yaml` (setelah `flutter pub get`).
- Menambah asset, font, atau mengubah konfigurasi asset.
- Mengubah kode native: Android (`build.gradle`, `AndroidManifest.xml`, Kotlin/Java) atau iOS (`Info.plist`, Swift/Obj-C), termasuk menambah plugin yang memiliki kode native.
- Mengubah konfigurasi platform seperti permission, ikon aplikasi, atau splash screen.
- Hot reload/restart bermasalah atau aplikasi dalam keadaan error.

---

# AI Disclosure — Individual Assignment 7

## AI Tools Used

| Tool | Tujuan Penggunaan | Jenis Bantuan |
|---|---|---|
| **ChatGPT (OpenAI, GPT-6)** | Membantu memahami materi Flutter Tutorial 08 dan mengerjakan Individual Assignment 7 secara bertahap | Penjelasan konsep, panduan implementasi, code review, debugging, penjelasan source code, dan dokumentasi |

## AI Usage & Prompting Strategy

ChatGPT digunakan sebagai learning assistant dan code reviewer selama pengerjaan IA7. Pendekatan prompting dilakukan secara bertahap berdasarkan instruksi tugas, rubrik penilaian, dan source code proyek yang sudah ada.

Pada tahap awal, AI diminta menjabarkan requirement IA7 menjadi beberapa milestone implementasi, termasuk personalisasi profil, kustomisasi warna tombol, interaktivitas `SnackBar`, pertanyaan reflektif, dan persiapan pengumpulan melalui GitHub.

Selanjutnya, saya memberikan source code aktual dari `main.dart` dan `menu.dart` agar penjelasan dan saran implementasi sesuai dengan struktur proyek yang sudah dikerjakan pada Tutorial 08. Pendekatan ini digunakan untuk menghindari penggantian kode yang tidak diperlukan.

Strategi prompting yang diterapkan meliputi:

1. **Requirement decomposition:** Meminta AI membagi instruksi IA7 menjadi tahapan pengerjaan yang dapat diikuti secara berurutan.
2. **Context-aware code review:** Memberikan source code yang sudah ada dan meminta AI menunjukkan bagian spesifik yang perlu diubah.
3. **Minimal-change implementation:** Memprioritaskan perubahan kecil pada implementasi Tutorial 08 daripada mengganti seluruh class.
4. **Conceptual explanation:** Meminta penjelasan mengenai widget tree, parent-child relationship, `StatelessWidget`, `StatefulWidget`, `MaterialApp`, dan `BuildContext`.
5. **Documentation assistance:** Meminta bantuan menyusun jawaban pertanyaan reflektif dan AI disclosure berdasarkan implementasi proyek.
6. **Rubric-oriented review:** Menggunakan rubrik tugas untuk mengidentifikasi aspek dokumentasi dan kualitas kode yang perlu diperhatikan.

Percakapan AI:

* **ChatGPT — IA7:** [link chat](https://chatgpt.com/share/6af99d48-d788-83ec-b5ee-9e128110a97c)

## Parts Assisted by AI

| Bagian | Bantuan AI | Verifikasi/Perbaikan Manual |
|---|---|---|
| Perencanaan IA7 | Memecah requirement menjadi milestone serta memberikan panduan implementasi dan commit Git | Membandingkan setiap milestone dengan instruksi tugas |
| Struktur Flutter | Menjelaskan hubungan `main.dart`, `menu.dart`, `MyApp`, `MaterialApp`, dan `MyHomePage` | Mempertahankan pemisahan file dan struktur dari Tutorial 08 |
| Model `ItemHomepage` | Menjelaskan penambahan atribut `Color color` dan penggunaan constructor untuk setiap menu | Menggunakan model yang menyimpan `name`, `icon`, dan `color` |
| Kustomisasi `ItemCard` | Mengidentifikasi bahwa `Theme.of(context).colorScheme.secondary` menyebabkan semua tombol menggunakan warna yang sama | Mengubah sumber warna menjadi `item.color` tanpa mengganti keseluruhan class |
| Interaktivitas `SnackBar` | Menjelaskan penggunaan `InkWell`, `onTap`, `ScaffoldMessenger`, dan interpolasi String | Mempertahankan implementasi SnackBar dari kode Tutorial 08 yang sudah sesuai requirement |
| Pemahaman widget | Menjelaskan cara membedakan widget, properti, model data, dan objek konfigurasi Flutter | Mengidentifikasi widget berdasarkan kode aktual `main.dart` dan `menu.dart` |
| Pertanyaan reflektif | Membantu menjelaskan konsep widget tree, MaterialApp, state, BuildContext, dan hot reload | Menyesuaikan penjelasan dengan implementasi MyPortfolio Mobile |
| Dokumentasi README | Membantu menyusun deskripsi proyek, teknologi, struktur file, panduan menjalankan aplikasi, dan AI disclosure | Menyesuaikan dokumentasi dengan cakupan fitur Flutter yang benar-benar diimplementasikan |

## Critical Reflection on AI Limitations

Penggunaan AI membantu mempercepat pemahaman konsep Flutter, tetapi saran yang dihasilkan tidak selalu perlu diterapkan secara keseluruhan.

Salah satu contohnya terjadi ketika AI memberikan implementasi lengkap `ItemCard` untuk memenuhi requirement warna tombol yang berbeda. Setelah source code aktual diberikan, terlihat bahwa class `ItemHomepage` sudah memiliki atribut `Color color` dan constructor yang menerima warna, sedangkan `ItemCard` sudah memiliki implementasi `InkWell` dan `SnackBar`.

Masalah sebenarnya hanya terletak pada properti warna di widget `Material`:

```dart
color: Theme.of(context).colorScheme.secondary,
```

Kode tersebut menyebabkan semua tombol mengambil warna sekunder yang sama dari tema aplikasi, meskipun setiap objek `ItemHomepage` sudah menyimpan warna berbeda.

Perubahan yang diperlukan cukup mengganti properti tersebut menjadi:

```dart
color: item.color,
```

Pengalaman ini menunjukkan bahwa solusi AI yang terlalu generik berpotensi menghasilkan perubahan berlebihan, menghilangkan bagian kode yang sudah benar, atau mengurangi konsistensi dengan implementasi sebelumnya.

Selain itu, AI dapat menjelaskan konsep framework tanpa langsung memperlihatkan hubungan konsep tersebut dengan source code aktual. Sebagai contoh, penjelasan bahwa `MaterialApp` umumnya merupakan root widget perlu diperjelas dalam konteks proyek ini. Secara teknis, widget yang diberikan kepada `runApp()` adalah `MyApp`, sedangkan `MaterialApp` merupakan widget utama yang dikembalikan oleh metode `build()` pada `MyApp`.

AI juga tidak dapat membuktikan bahwa aplikasi berhasil dijalankan hanya dengan membaca source code. Pemeriksaan statis, perilaku runtime, respons tombol, dan tampilan pada perangkat tetap membutuhkan pengujian di environment pengembangan.

Oleh karena itu, hasil AI digunakan sebagai referensi untuk belajar dan melakukan review, bukan sebagai pengganti pemahaman kode maupun verifikasi implementasi.

## Manual Improvements & Verification

Penyesuaian manual yang telah dilakukan atau dibahas dalam pengembangan IA7 meliputi:

* mempertahankan struktur `main.dart` dan `menu.dart` dari Tutorial 08;
* menggunakan identitas pribadi sebagai pengganti data contoh Burhan;
* mempertahankan `MyHomePage`, `InfoCard`, dan `ItemCard` sebagai `StatelessWidget`;
* menggunakan class `ItemHomepage` untuk menyimpan data nama, ikon, dan warna tombol;
* menyesuaikan `Material` agar menggunakan `item.color`, bukan satu warna sekunder dari tema;
* mempertahankan implementasi `ScaffoldMessenger` dan interpolasi `${item.name}` pada SnackBar;
* menghindari penulisan ulang seluruh class `ItemCard` karena sebagian besar implementasinya sudah sesuai;
* memeriksa hubungan antara widget dan class model data untuk memahami struktur widget tree;
* membandingkan penjelasan AI mengenai `MaterialApp` dengan pemanggilan `runApp(const MyApp())` pada proyek;
* menyesuaikan dokumentasi dengan fitur yang benar-benar tersedia pada aplikasi Flutter.

Pengujian akhir yang perlu dilakukan sebelum pengumpulan meliputi pemeriksaan `flutter analyze`, menjalankan aplikasi, menguji ketiga tombol, memeriksa tampilan antarmuka, dan memastikan perubahan terakhir telah di-push ke GitHub.

Hasil pengujian dicatat berdasarkan output aktual dari environment Flutter, bukan berdasarkan prediksi AI.

## AI Prompting Log — Individual Assignment 7

| Tahap | AI | Tujuan | Strategi Prompt | Hasil |
|---|---|---|---|---|
| Perencanaan IA7 | ChatGPT | Memahami keseluruhan tugas | Memberikan instruksi dan rubrik IA7 serta meminta panduan step-by-step | Requirement dipecah menjadi beberapa milestone |
| Implementasi `ItemCard` | ChatGPT | Menyesuaikan warna tombol | Memberikan isi aktual `menu.dart` dan meminta klarifikasi perubahan yang diperlukan | Teridentifikasi bahwa perubahan utama cukup pada properti `color` |
| Review `main.dart` | ChatGPT | Memeriksa struktur root widget | Memberikan kode `main.dart` aktual | Hubungan `MyApp`, `MaterialApp`, dan `MyHomePage` dijelaskan |
| Konsep widget | ChatGPT | Memahami cara mengidentifikasi widget | Meminta penjelasan berdasarkan kode proyek | Perbedaan widget, properti, model data, dan objek konfigurasi dijelaskan |
| Konsep `MaterialApp` | ChatGPT | Memahami penggunaan root widget | Mempertanyakan perbedaan root widget teknis dan pola umum Flutter | Peran `MyApp` sebagai root langsung dan `MaterialApp` sebagai konfigurasi utama diperjelas |
| Refleksi IA7 | ChatGPT | Menjawab pertanyaan konseptual | Memberikan `main.dart` dan `menu.dart` untuk menyesuaikan jawaban | Jawaban reflektif disusun berdasarkan implementasi proyek |
| Dokumentasi IA7 | ChatGPT | Menyusun AI disclosure sesuai rubrik | Memberikan rubrik penilaian dan contoh AI disclosure IA5 | Dokumentasi penggunaan AI, keterbatasan, dan perbaikan manual disusun |

## Kesimpulan Penggunaan AI

AI digunakan untuk membantu memahami konsep Flutter, meninjau kode, mengidentifikasi perubahan yang diperlukan, dan menyusun dokumentasi secara terstruktur.

Pendekatan yang diprioritaskan adalah memberikan source code dan requirement yang jelas, meminta penjelasan sebelum melakukan perubahan, serta mempertahankan implementasi yang sudah benar.

Pengalaman pada IA7 memperlihatkan bahwa penggunaan AI lebih efektif ketika hasilnya dievaluasi berdasarkan kode aktual. Saran AI tidak selalu membutuhkan implementasi ulang; terkadang perubahan pada satu properti sudah cukup untuk memenuhi requirement.

Keputusan akhir mengenai struktur kode, penyesuaian implementasi, dan kesesuaian dengan rubrik tetap didasarkan pada source code proyek dan hasil pengujian manual.