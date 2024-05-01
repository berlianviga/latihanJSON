import 'dart:convert'; // mengimport library dart:convert untuk mengolah data JSON

//class untuk mewakili mata kuliah yang diambil oleh mahasiswa
class MataKuliah {
  final String kodeMK; //kode mata kuliah
  final String namaMK; //nama mata kuliah
  final int sks; // jumlah sks
  final String nilai; // nilai mahasiswa

  // konstruktor MataKuliah
  MataKuliah({
    required this.kodeMK, // Menyimpan kode mata kuliah, diperlukan saat membuat objek MataKuliah
    required this.namaMK, // menyimpan nama mata kuliah, diperlukan saat membuat objek MataKuliah
    required this.sks, // menyimpan sks mata kuliah, diperlukan saat membuat objek MataKuliah
    required this.nilai, // menyimpan nilai mata kuliah, diperlukan saat membuat objek MataKuliah
  });
}

// class untuk data mahasiswa dan mata kuliah yang diambil
class Mahasiswa {
  final String namaMhs; // nama mahasiswa
  final String nim; // nim mahasiswa
  final String prodi; // program studi mahasiswa
  final List<MataKuliah> mataKuliah; // daftar mata kuliah yang diambil

  // konstruktor mahasiswa
  Mahasiswa({
    required this.namaMhs, // menyimpan nama mahasiswa, diperlukan saat membuat objek Mahasiswa
    required this.nim, // menyimpan nim mahasiswa, diperlukan saat membuat objek Mahasiswa
    required this.prodi, // menyimpan prodi mahasiswa, diperlukan saat membuat objek Mahasiswa
    required this.mataKuliah, // menyimpan daftar mata kuliah, diperlukan saat membuat objek Mahasiswa
  });

  //metode untuk menghitung IPK mahasiswa
  double hitungIPK() {
    double totalSKS = 0; //total sks yang diambil
    double totalKredit = 0; // total kredit yang diperoleh

    // meghitung total SKS dan total kredit berdasarkan nilai mata kuliah 
    for (var matkul in mataKuliah) {
      var kredit = nilaiToKredit(matkul.nilai); // mengonversi nilai menjadi kredit
      totalSKS += matkul.sks; // menambah sks ke total sks
      totalKredit += kredit * matkul.sks; // menambah kredit ke total kredit, di kalikan dengan jumlah sks
    }

    return totalKredit / totalSKS; // mengembalikan IPK
  }

  // Metode untuk mengonversi nilai menjadi kredit 
  double nilaiToKredit(String nilai) {
    switch (nilai) {
      case 'A':
        return 4.0; // Jika nilai A, kembalikan 4 kredit
      case 'A-':
        return 3.75; // jika nilai A-, Kembalikan 3.75 kredit
      case 'B+':
        return 3.5; // jika nilai B+, Kembalikan 3.5 kredit
      case 'B':
        return 3.0; // jika nilai B, Kembalikan 3.0 kredit
      case 'B-':
        return 2.75; // jika nilai B-, Kembalikan 2.75 kredit
      case 'C+':
        return 2.3; // jika nilai C+, Kembalikan 2.3 kredit
      case 'C':
        return 2.0; // jika nilai C, Kembalikan 2.0 kredit
      case 'C-':
        return 1.7; // jika nilai C-, Kembalikan 1.7 kredit
      case 'D':
        return 1.0; // jika nilai D, Kembalikan 1.0 kredit
      default:
        return 0.0; // mengembalikan 0.0 jika nilai tidak dikenali
    }
  }
}

void main() {
  // String JSON yang berisi informasi mahasiswa meliputi nama, nim, prodi, dan daftar mata kuliah
  var jsonString = ''' 
{
  "mahasiswa": {
    "namaMhs": "Berlian Viga Septiani",
    "nim": "22082010050",
    "prodi": "Sistem Informasi",
    "mata_kuliah": [
      {
        "kodeMK": "SI231129",
        "namaMK": "E-BUSINESS",
        "sks": 3,
        "nilai": "A"
      },
      {
        "kodeMK": "SI231117",
        "namaMK": "STATISTIK KOMPUTASI",
        "sks": 3,
        "nilai": "A"
      },
      {
        "kodeMK": "SI231101",
        "namaMK": "KECAKAPAN PRIBADI",
        "sks": 3,
        "nilai": "A"
      },
      {
        "kodeMK": "SI231121",
        "namaMK": "PEMROGRAMAN WEB",
        "sks": 3,
        "nilai": "A"
      },
      {
        "kodeMK": "SI231126",
        "namaMK": "PEMROGRAMAN MOBILE",
        "sks": 3,
        "nilai": "A"
      }
    ]
  }
}
''';

  var data = jsonDecode(jsonString)['mahasiswa']; // mendapatkan data mahasiswa dari JSON
  var mahasiswa = Mahasiswa(  // Membuat objek Mahasiswa berdasarkan data JSON
    namaMhs: data['namaMhs'], // Mendapatkan nama mahasiswa
    nim: data['nim'], // mendapatkan nim mahasiswa
    prodi: data['prodi'], //mendapatkan program studi mahasiswa
    mataKuliah: (data['mata_kuliah'] as List).map((m)=> MataKuliah( // mendapatkan daftar mata kuliah mahasiswa
      kodeMK: m['kodeMK'], // mendapatkan kode mata kuliah
      namaMK: m['namaMK'], //mendapatkan nama mata kuliah
      sks: m['sks'], // mendapatkan SKS mata kuliah
      nilai: m['nilai'], // mendapatkan nilai mata kuliah
      )).toList(),
  );

  //mencetak informasi mahasiswa dan IPK nya
  print('Mahasiswa: ${mahasiswa.namaMhs}'); // mencetak nama mahasiswa
  print('NIM: ${mahasiswa.nim}'); // mencetak nim mahasiswa
  print('Prodi: ${mahasiswa.prodi}'); // mencetak prodi mahasiswa
  print('IPK: ${mahasiswa.hitungIPK().toStringAsFixed(2)}'); // mencetak hasil hitung IPK mahasiswa
}
