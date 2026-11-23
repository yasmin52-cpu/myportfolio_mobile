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

---

# Dokumentasi Tugas

### Tugas 8

**1. Perbedaan `Navigator.push()`, `Navigator.pushReplacement()`, dan `Navigator.pop()` serta penerapannya pada MyPortfolio Mobile**

Flutter menggunakan `Navigator` untuk mengelola perpindahan halaman melalui mekanisme *navigation stack*, yaitu struktur data LIFO (*Last In, First Out*). Setiap halaman direpresentasikan sebagai sebuah *route*.

Ketiga metode navigasi memiliki fungsi yang berbeda:

| Metode | Fungsi | Pengaruh terhadap Navigation Stack |
|---|---|---|
| `Navigator.push()` | Membuka halaman baru dengan menambahkan route ke atas stack. | Route sebelumnya tetap tersimpan sehingga pengguna dapat kembali menggunakan tombol Back. |
| `Navigator.pushReplacement()` | Membuka halaman baru dengan menggantikan route yang sedang aktif. | Route sebelumnya digantikan sehingga tidak dapat dikunjungi kembali melalui `pop()` ke route tersebut. |
| `Navigator.pop()` | Menutup route yang sedang aktif. | Route paling atas dihapus dan pengguna kembali ke route sebelumnya, jika tersedia. |

Pada MyPortfolio Mobile, saya menggunakan `Navigator.push()` di dalam `ItemCard` untuk membuka halaman formulir melalui kartu aksi **Tambah Pengalaman**.

```dart
if (item.name == "Tambah Pengalaman") {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const ExperienceFormPage(),
    ),
  );
}
```

Penggunaan `push()` memungkinkan halaman Home tetap tersimpan pada navigation stack. Dengan demikian, pengguna dapat kembali ke halaman sebelumnya melalui tombol Back.

Sementara itu, pada `LeftDrawer`, saya menggunakan `Navigator.pushReplacement()` untuk navigasi antarhalaman, termasuk opsi Home.

```dart
ListTile(
  leading: const Icon(Icons.home_outlined),
  title: const Text('Home'),
  onTap: () {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MyHomePage(),
      ),
    );
  },
),
```

Ketika opsi Home dipilih dari halaman formulir, route yang sedang aktif digantikan dengan route `MyHomePage`, sehingga pengguna kembali ke halaman utama. Mekanisme ini juga dapat diuji melalui Chrome tanpa bergantung pada tombol Back bawaan perangkat.

Metode `Navigator.pop()` digunakan pada tombol OK dalam `AlertDialog` untuk menutup dialog ringkasan dan kembali ke formulir tanpa membuka halaman baru.

**2. Peran `Scaffold`, `AppBar`, dan `Drawer` dalam menjaga konsistensi struktur halaman**

`Scaffold`, `AppBar`, dan `Drawer` merupakan widget Material Design yang membantu membangun struktur antarmuka aplikasi secara konsisten.

- **`Scaffold`** menyediakan kerangka dasar halaman yang mengatur komponen seperti `appBar`, `drawer`, dan `body`.
- **`AppBar`** menampilkan bagian header halaman, termasuk judul dan akses menuju drawer.
- **`Drawer`** menyediakan menu navigasi yang memungkinkan pengguna berpindah antarhalaman melalui daftar opsi.

Pada MyPortfolio Mobile, halaman utama (`MyHomePage`), formulir proyek (`ProjectFormPage`), dan formulir pengalaman (`ExperienceFormPage`) menggunakan `Scaffold` dengan `AppBar` serta komponen `LeftDrawer` yang sama.

Komponen `LeftDrawer` dipisahkan ke dalam `lib/widgets/left_drawer.dart` agar dapat digunakan kembali (*reusable*) tanpa perlu menulis ulang daftar menu pada setiap halaman. Hal ini juga memudahkan pemeliharaan kode karena perubahan navigasi cukup dilakukan pada satu file.

Untuk menjaga konsistensi visual, saya menggunakan warna utama dari tema aplikasi yang didefinisikan melalui `ColorScheme.fromSeed()` pada `main.dart`.

```dart
theme: ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.indigo,
    secondary: Colors.amber[700],
  ),
  useMaterial3: true,
),
```

Contoh penerapannya adalah penggunaan:

```dart
backgroundColor: Theme.of(context).colorScheme.primary,
```

Properti tersebut digunakan pada `AppBar` halaman utama dan halaman Add Experience. Dengan mengambil warna melalui `Theme.of(context)`, kedua halaman menggunakan sumber konfigurasi warna yang sama. Pendekatan ini memudahkan perubahan tema secara terpusat dan menjaga konsistensi tampilan aplikasi.

**3. Alasan pemilihan tata letak formulir serta peran widget pengatur jarak dan penggulir**

Pada halaman Add Experience, saya menggunakan kombinasi `Form`, `SingleChildScrollView`, `Padding`, dan `Column` untuk menyusun input secara vertikal.

Struktur utamanya adalah:

```dart
Scaffold(
  body: Form(
    key: _formKey,
    child: SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Input formulir
          // Tombol Save Experience
        ],
      ),
    ),
  ),
)
```

Saya memilih susunan vertikal karena formulir memiliki beberapa jenis input, seperti nama organisasi, posisi, jenis pengalaman, tanggal mulai, tanggal selesai, checkbox, dan deskripsi. Dengan susunan ini, pengguna dapat mengisi data secara berurutan dari atas ke bawah.

Beberapa widget yang berperan dalam pengaturan layout adalah:

- **`Column`** menyusun seluruh input dan tombol secara vertikal agar alur pengisian mudah diikuti.
- **`Padding`** memberikan jarak antara konten formulir dan tepi layar sehingga tampilan tidak terlalu rapat.
- **`SizedBox`** memberikan jarak antar-input, misalnya `SizedBox(height: 16)`, agar setiap field terlihat terpisah dan mudah dibaca.
- **`SingleChildScrollView`** memungkinkan pengguna menggulir formulir ketika tinggi konten melebihi ruang layar yang tersedia.

Penggunaan `SingleChildScrollView` penting terutama ketika aplikasi dijalankan pada layar ponsel atau saat keyboard virtual muncul. Keyboard dapat mengurangi ruang vertikal yang tersedia, sehingga sebagian input atau tombol Save mungkin tidak terlihat.

Dengan widget penggulir, pengguna tetap dapat mengakses bagian bawah formulir tanpa mengalami *RenderFlex overflow* akibat konten yang terlalu tinggi.

Pada halaman utama, saya juga menyesuaikan jumlah kolom `GridView` berdasarkan lebar layar agar kartu aksi tetap nyaman digunakan pada perangkat dengan ukuran layar berbeda.

**4. Peran `GlobalKey<FormState>`, `validator`, dan `validate()` dalam proses validasi formulir**

Ketiga komponen tersebut bekerja sama untuk memastikan data yang dimasukkan pengguna memenuhi aturan sebelum ditampilkan dalam dialog ringkasan.

**a. `GlobalKey<FormState>`**

`GlobalKey<FormState>` digunakan untuk mengakses state dari widget `Form`.

Pada `ExperienceFormPage`, saya mendeklarasikan:

```dart
final _formKey = GlobalKey<FormState>();
```

Kemudian key tersebut dihubungkan ke widget `Form`:

```dart
Form(
  key: _formKey,
  child: SingleChildScrollView(
    // Input formulir
  ),
)
```

Dengan demikian, saya dapat mengakses metode validasi pada `FormState` melalui `_formKey.currentState`.

**b. `validator`**

`validator` merupakan fungsi yang memeriksa apakah nilai sebuah input memenuhi aturan yang ditentukan.

Fungsi validator mengembalikan `null` jika input valid dan mengembalikan `String` berisi pesan kesalahan jika input tidak valid.

Sebagai contoh, pada input Organization:

```dart
validator: (value) {
  if (value == null || value.trim().isEmpty) {
    return 'Organization cannot be empty!';
  }
  return null;
},
```

Penggunaan `trim()` memastikan bahwa input yang hanya berisi spasi, seperti `"   "`, tetap dianggap kosong dan ditolak.

Selain itu, pada input End Date, validasi digunakan untuk memastikan tanggal selesai tidak lebih awal daripada tanggal mulai:

```dart
if (_startDate != null &&
    _endDate!.isBefore(_startDate!)) {
  return 'End date cannot be before start date!';
}
```

**c. `validate()`**

Metode `validate()` digunakan untuk menjalankan seluruh validator pada field yang terdaftar dalam `Form`.

Pada tombol Save Experience, metode tersebut dipanggil melalui:

```dart
if (_formKey.currentState!.validate()) {
  showDialog(
    context: context,
    builder: (dialogContext) {
      return AlertDialog(
        // Ringkasan data pengalaman
      );
    },
  );
}
```

Jika seluruh input valid, `validate()` mengembalikan `true` dan aplikasi menampilkan `AlertDialog` berisi ringkasan pengalaman. Jika terdapat input tidak valid, metode tersebut mengembalikan `false`, pesan kesalahan ditampilkan pada field terkait, dan dialog tidak dibuka.

**Mengapa jenis input atau keyboard saja belum cukup?**

Pemilihan jenis input, seperti `TextFormField` dengan keyboard tertentu atau `showDatePicker()` untuk tanggal, membantu mempermudah pengisian data, tetapi tidak menjamin bahwa nilai yang dimasukkan sudah benar secara logis.

Sebagai contoh, keyboard teks tetap memungkinkan pengguna memasukkan karakter spasi tanpa informasi yang bermakna. Demikian pula, date picker dapat membatasi rentang tanggal yang tersedia, tetapi pemilihan tanggal mulai dan selesai tetap perlu dibandingkan untuk memastikan urutannya benar.

Oleh karena itu, validasi eksplisit melalui `validator` dan `validate()` diperlukan agar data yang diterima tidak hanya sesuai dengan jenis input, tetapi juga memenuhi aturan yang ditetapkan oleh aplikasi.

# AI Disclosure — Individual Assignment 8

## AI Tools Used

| Tool | Tujuan Penggunaan | Jenis Bantuan |
|---|---|---|
| **ChatGPT (OpenAI, GPT-6)** | Membantu memahami materi Flutter Tutorial 09 dan mengimplementasikan Individual Assignment 8 berdasarkan source code proyek yang sudah ada | Perencanaan implementasi, penjelasan konsep navigasi dan formulir, panduan penulisan kode, validasi input, debugging, code review, pengujian, dan dokumentasi |

## AI Usage & Prompting Strategy

ChatGPT digunakan sebagai *learning assistant* dan pendamping implementasi selama pengerjaan IA8. Pendekatan prompting dilakukan secara bertahap dengan memberikan instruksi tugas, rubrik penilaian, struktur direktori, dan source code aktual dari proyek MyPortfolio Mobile.

Pada tahap awal, AI diminta mengidentifikasi file yang diperlukan untuk melanjutkan implementasi Tutorial 09 tanpa membuat ulang aplikasi. File yang diberikan meliputi `main.dart`, `menu.dart`, `project_form.dart`, `left_drawer.dart`, dan `project_card.dart`.

Setelah struktur proyek dipahami, saya memilih untuk mengembangkan halaman **Add Experience**, menggantikan usulan awal AI berupa Add Certification, agar fitur baru lebih sesuai dengan kebutuhan portofolio pribadi.

Strategi prompting yang diterapkan meliputi:

1. **Requirement decomposition:** Meminta AI membagi instruksi IA8 menjadi checkpoint implementasi yang mencakup pembuatan formulir, validasi, navigasi, pengujian, dan dokumentasi.
2. **Context-aware implementation:** Memberikan source code Tutorial 09 agar implementasi baru mengikuti struktur proyek dan pola penulisan kode yang sudah digunakan.
3. **Iterative development:** Mengerjakan fitur secara bertahap, dimulai dari pembuatan `StatefulWidget`, pengelolaan state, input formulir, validasi, dan navigasi.
4. **Conceptual explanation:** Meminta penjelasan mengenai `GlobalKey<FormState>`, `FormField`, `setState()`, `showDatePicker()`, `Navigator`, dan `AlertDialog` untuk memahami alasan penggunaan setiap komponen.
5. **Debugging assistance:** Memberikan output terminal Flutter untuk mengidentifikasi masalah saat menjalankan aplikasi melalui Chrome dan Android Emulator.
6. **Rubric-oriented review:** Menggunakan checklist dan rubrik IA8 untuk memastikan fitur yang dibuat sesuai dengan ketentuan tugas.
7. **Documentation assistance:** Meminta bantuan menyusun AI disclosure berdasarkan proses pengerjaan, bantuan AI yang digunakan, serta hasil pengujian aktual.

Percakapan AI:

* **ChatGPT — IA8:** [link chat](https://chatgpt.com/share/6b03336b-bfe0-83ec-8986-45a4e9189106)

## Parts Assisted by AI

| Bagian | Bantuan AI | Verifikasi/Perbaikan Manual |
|---|---|---|
| Perencanaan IA8 | Mengidentifikasi file yang perlu diperiksa dan membagi pengerjaan menjadi beberapa checkpoint | Memilih Add Experience sebagai fitur yang akan dikembangkan |
| Struktur proyek | Menjelaskan hubungan `main.dart`, `menu.dart`, `project_form.dart`, `left_drawer.dart`, dan `project_card.dart` | Mempertahankan struktur direktori dari Tutorial 09 |
| `experience_form.dart` | Memberikan panduan pembuatan `StatefulWidget`, `Form`, dan `GlobalKey<FormState>` | Mengintegrasikan formulir baru ke dalam proyek Flutter |
| Input formulir | Membantu implementasi `TextFormField`, `DropdownButtonFormField`, `CheckboxListTile`, dan input tanggal | Menyesuaikan field dengan model pengalaman pada portofolio |
| Date picker | Menjelaskan penggunaan `showDatePicker()`, `DateTime?`, `async/await`, dan `setState()` | Menguji pemilihan tanggal dan perubahan tampilan formulir |
| Validasi | Membantu menyusun validator untuk input wajib, spasi kosong, serta urutan Start Date dan End Date | Menguji perilaku validasi ketika input tidak memenuhi ketentuan |
| Dialog ringkasan | Memberikan contoh penggunaan `showDialog()`, `AlertDialog`, dan `Navigator.pop()` | Memeriksa tampilan ringkasan setelah formulir berhasil divalidasi |
| Navigasi | Menjelaskan penggunaan `Navigator.push()` dan `Navigator.pushReplacement()` | Menguji akses formulir melalui kartu aksi dan drawer |
| Responsive layout | Menyarankan penggunaan `SingleChildScrollView` dan penyesuaian jumlah kolom `GridView` | Menjalankan aplikasi melalui Chrome untuk memeriksa antarmuka |
| Debugging Flutter | Menganalisis log `flutter run` dan mengidentifikasi kegagalan instalasi Android NDK | Menjalankan aplikasi melalui Chrome sebagai alternatif pengujian |
| Static analysis | Menjelaskan penggunaan `flutter analyze` | Menjalankan perintah dan memperoleh hasil `No issues found!` |
| Git | Memberikan rekomendasi pesan commit menggunakan format Conventional Commits | Mengelola perubahan dan commit melalui Git |
| Dokumentasi | Membantu menyusun AI disclosure berdasarkan riwayat pengerjaan IA8 | Menyesuaikan dokumentasi dengan implementasi dan hasil pengujian |

## Critical Reflection on AI Limitations

Penggunaan AI membantu mempercepat implementasi IA8, terutama dalam memahami hubungan antara navigasi, pengelolaan state, dan validasi formulir. Namun, terdapat beberapa keterbatasan yang perlu diperhatikan.

**1. Solusi AI tidak selalu sesuai dengan kebutuhan proyek.**

Pada tahap perencanaan, AI awalnya menyarankan pembuatan halaman Add Certification. Saya memutuskan menggantinya menjadi Add Experience karena bagian pengalaman lebih sesuai dengan kebutuhan portofolio yang ingin dikembangkan.

Hal ini menunjukkan bahwa rekomendasi AI perlu dievaluasi berdasarkan tujuan proyek, bukan langsung diterima sebagai keputusan akhir.

**2. Contoh kode AI perlu disesuaikan dengan struktur proyek aktual.**

AI dapat memberikan implementasi formulir secara lengkap, tetapi kode tersebut belum tentu langsung sesuai dengan struktur direktori, import, dan komponen yang sudah tersedia.

Oleh karena itu, source code Tutorial 09 diberikan sebagai konteks agar halaman baru dapat menggunakan komponen `LeftDrawer` yang sama dan mempertahankan pola navigasi yang sudah diterapkan.

**3. Validasi memerlukan pemeriksaan logika, bukan hanya pemilihan widget input.**

Penggunaan `TextFormField` atau date picker tidak secara otomatis menjamin bahwa data yang dimasukkan valid.

Sebagai contoh, pengguna masih dapat memasukkan teks yang hanya berisi spasi atau memilih End Date yang lebih awal daripada Start Date. Karena itu, validasi perlu diimplementasikan secara eksplisit melalui `validator` dan pemeriksaan nilai `DateTime`.

**4. AI tidak dapat memastikan keberhasilan runtime hanya dari source code.**

Ketika aplikasi dijalankan menggunakan `flutter run`, proses build Android gagal karena Android SDK tidak berhasil memasang NDK versi `28.2.13676358`.

AI membantu mengidentifikasi bahwa masalah tersebut berkaitan dengan konfigurasi Android, bukan secara langsung dengan logika formulir Flutter. Sebagai alternatif, aplikasi dijalankan melalui Chrome menggunakan:

```bash
flutter run -d chrome --web-port=8080
```

Pengalaman ini menunjukkan bahwa saran AI perlu dibedakan antara masalah source code dan masalah environment pengembangan.

**5. Keberhasilan static analysis tidak menjamin seluruh interaksi bebas bug.**

Hasil `flutter analyze` menunjukkan `No issues found!`, tetapi pemeriksaan statis tidak menggantikan pengujian interaksi pengguna.

Validasi input, navigasi, pemilihan tanggal, tampilan dialog, dan perilaku formulir pada layar sempit tetap perlu diperiksa ketika aplikasi berjalan.

## Manual Improvements & Verification

Penyesuaian dan pemeriksaan yang dilakukan selama pengerjaan IA8 meliputi:

- Memilih fitur Add Experience sebagai pengembangan baru dari portofolio pribadi.
- Mempertahankan struktur `lib/screens/` dan `lib/widgets/` yang telah dibuat pada Tutorial 09.
- Menggunakan `StatefulWidget` untuk mengelola perubahan input dan pilihan pengguna.
- Menggunakan `GlobalKey<FormState>` untuk menghubungkan tombol Save dengan validasi formulir.
- Menambahkan validasi input wajib agar nilai kosong atau hanya berisi spasi tidak diterima.
- Menggunakan date picker untuk memasukkan tanggal pengalaman.
- Memeriksa urutan Start Date dan End Date.
- Menggunakan checkbox Currently Working untuk menangani pengalaman yang masih berlangsung.
- Menggunakan `AlertDialog` untuk menampilkan ringkasan input setelah validasi berhasil.
- Mengintegrasikan halaman Add Experience ke dalam navigasi kartu aksi dan drawer.
- Menjalankan aplikasi menggunakan Chrome setelah build Android mengalami kendala NDK.
- Memeriksa akses halaman dan validasi input kosong melalui antarmuka aplikasi.
- Menjalankan `flutter analyze` dan memperoleh hasil `No issues found!`.

Pemeriksaan dilakukan berdasarkan implementasi dan output aktual dari environment Flutter. Hasil static analysis tidak dianggap sebagai pengganti seluruh pengujian fungsional.

## AI Prompting Log — Individual Assignment 8

| Tahap | AI | Tujuan | Strategi Prompt | Hasil |
|---|---|---|---|---|
| Analisis requirement | ChatGPT | Memahami IA8 dan file yang diperlukan | Memberikan instruksi tugas, rubrik, dan daftar direktori proyek | Teridentifikasi file utama yang perlu diperiksa |
| Review source code | ChatGPT | Menyesuaikan implementasi dengan Tutorial 09 | Memberikan isi `main.dart`, `menu.dart`, `project_form.dart`, `left_drawer.dart`, dan `project_card.dart` | Struktur proyek dan pola navigasi dipahami |
| Pemilihan fitur | ChatGPT | Menentukan formulir tambahan | Meminta mengganti usulan Certification menjadi Experience | Fitur Add Experience dipilih |
| Implementasi formulir | ChatGPT | Membuat halaman baru | Meminta panduan step-by-step beserta penjelasan konsep Flutter | Panduan pembuatan `experience_form.dart` diberikan |
| Validasi input | ChatGPT | Memastikan formulir menolak input tidak valid | Membahas penggunaan validator, date picker, dan checkbox | Logika validasi input dan tanggal dirancang |
| Navigasi | ChatGPT | Menghubungkan halaman baru dengan aplikasi | Meminta panduan perubahan pada kartu aksi dan drawer | Navigasi Add Experience diintegrasikan |
| Debugging runtime | ChatGPT | Menjalankan aplikasi untuk pengujian | Memberikan log `flutter run -d chrome` dan `flutter run` | Masalah Android NDK diidentifikasi dan Chrome digunakan |
| Pengujian | ChatGPT | Memeriksa kesesuaian implementasi | Mengikuti checklist pengujian dan menjalankan `flutter analyze` | Static analysis menghasilkan `No issues found!` |
| Git | ChatGPT | Menyiapkan riwayat commit yang deskriptif | Meminta rekomendasi commit message | Diperoleh rekomendasi Conventional Commits |
| Dokumentasi IA8 | ChatGPT | Menyusun AI disclosure | Memberikan README sebelumnya dan meminta disclosure IA8 | Dokumentasi penggunaan AI disusun berdasarkan proses pengerjaan |

## Kesimpulan Penggunaan AI

Pada Individual Assignment 8, AI digunakan sebagai alat bantu pembelajaran, perencanaan implementasi, debugging, dan dokumentasi.

Penggunaan AI paling membantu ketika instruksi tugas dan source code aktual diberikan sebagai konteks. Dengan pendekatan tersebut, implementasi baru dapat disesuaikan dengan struktur proyek yang sudah ada tanpa harus membuat ulang seluruh aplikasi.

Selain itu, proses pengerjaan menunjukkan pentingnya mengevaluasi rekomendasi AI secara kritis, khususnya dalam pemilihan fitur, penyesuaian kode, validasi input, dan interpretasi pesan error.

Keputusan mengenai fitur yang dikembangkan, integrasi ke dalam proyek, serta pemeriksaan hasil akhir tetap dilakukan dengan mengacu pada kebutuhan portofolio, instruksi IA8, dan pengujian langsung di environment Flutter.