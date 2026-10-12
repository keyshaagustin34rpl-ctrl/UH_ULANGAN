
import 'package:flutter/material.dart';

void main() {
  runApp(const TechExpressApp());
}

const pink = Color(0xFFE91E63);
const lightPink = Color(0xFFFFE4EF);
const palePink = Color(0xFFFFF5F8);

class TechExpressApp extends StatefulWidget {
  const TechExpressApp({super.key});

  @override
  State<TechExpressApp> createState() => _TechExpressAppState();
}

class _TechExpressAppState extends State<TechExpressApp> {
  int halaman = 0;
  String nama = '';
  String voucher = '-';
  int produkDipilih = 0;

  final List<Map<String, dynamic>> produk = [
    {
      'nama': 'Smartphone',
      'harga': 2500000,
      'icon': Icons.phone_android,
    },
    {
      'nama': 'Laptop',
      'harga': 6500000,
      'icon': Icons.laptop_mac,
    },
    {
      'nama': 'Smartwatch',
      'harga': 850000,
      'icon': Icons.watch,
    },
    {
      'nama': 'Headphone',
      'harga': 350000,
      'icon': Icons.headphones,
    },
  ];

  String rupiah(int harga) {
    return 'Rp ${harga.toString().replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
      (match) => '${match[1]}.',
    )}';
  }

  void bukaHalaman(int index) {
    setState(() => halaman = index);
  }

  void pilihProduk(int index) {
    setState(() {
      produkDipilih = index;
      halaman = 3;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TechExpress',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: palePink,
        colorScheme: ColorScheme.fromSeed(seedColor: pink),
        appBarTheme: const AppBarTheme(
          backgroundColor: pink,
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
      ),
      home: halaman == 0
          ? halamanLogin()
          : halaman == 1
              ? halamanKatalog()
              : halaman == 2
                  ? halamanProfil()
                  : halaman == 3
                      ? halamanDetail()
                      : halamanVoucher(),
    );
  }

  // HALAMAN 1: LOGIN
  Widget halamanLogin() {
    final controller = TextEditingController(text: nama);

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [lightPink, Colors.white, Color(0xFFFFB6D0)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(28),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.shopping_bag_rounded,
                    size: 100,
                    color: pink,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'TechExpress',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: pink,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '♡ Selamat Datang di TechExpress ♡',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 35),
                  TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      labelText: 'Masukkan nama kamu',
                      prefixIcon: const Icon(
                        Icons.person,
                        color: pink,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                  ),
                  const SizedBox(height: 22),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: pink,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        if (controller.text.trim().isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Masukkan nama terlebih dahulu!'),
                            ),
                          );
                          return;
                        }
                        setState(() {
                          nama = controller.text.trim();
                          halaman = 1;
                        });
                      },
                      child: const Text(
                        'LOGIN ♡',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    '♡ Belanja Gadget Jadi Lebih Menyenangkan ♡',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: pink),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // HALAMAN 2: KATALOG
  Widget halamanKatalog() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TechExpress - Katalog'),
        actions: [
          IconButton(
            onPressed: () => bukaHalaman(2),
            icon: const Icon(Icons.account_circle),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [pink, Color(0xFFFF80AB)],
              ),
              borderRadius: BorderRadius.circular(22),
            ),
            child: Text(
              'Hai, $nama! ♡\nTemukan gadget favoritmu!',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            '♡ Katalog Gadget ♡',
            style: TextStyle(
              color: pink,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          ...List.generate(produk.length, (index) {
            final item = produk[index];
            return Card(
              color: Colors.white,
              margin: const EdgeInsets.only(bottom: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.all(12),
                leading: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: lightPink,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    item['icon'] as IconData,
                    color: pink,
                    size: 32,
                  ),
                ),
                title: Text(
                  item['nama'] as String,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  rupiah(item['harga'] as int),
                  style: const TextStyle(
                    color: pink,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: pink,
                  size: 18,
                ),
                onTap: () => pilihProduk(index),
              ),
            );
          }),
          const SizedBox(height: 12),
          const Center(
            child: Text(
              'Made with ♡ TechExpress',
              style: TextStyle(color: pink),
            ),
          ),
        ],
      ),
      bottomNavigationBar: navigasiBawah(1),
    );
  }

  // HALAMAN 3: PROFIL
  Widget halamanProfil() {
    return Scaffold(
      appBar: AppBar(title: const Text('TechExpress - Profil')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(25),
                decoration: const BoxDecoration(
                  color: lightPink,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.person_rounded,
                  size: 90,
                  color: pink,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Profil Pengguna',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: pink,
                ),
              ),
              const SizedBox(height: 20),
              Card(
                color: Colors.white,
                child: ListTile(
                  leading: const Icon(Icons.person, color: pink),
                  title: const Text('Nama Pengguna'),
                  subtitle: Text(nama),
                ),
              ),
              Card(
                color: Colors.white,
                child: const ListTile(
                  leading: Icon(Icons.store, color: pink),
                  title: Text('Nama Toko'),
                  subtitle: Text('TechExpress'),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () => bukaHalaman(1),
                icon: const Icon(Icons.storefront),
                label: const Text('Kembali ke Katalog'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: pink,
                  foregroundColor: Colors.white,
                ),
              ),
              const SizedBox(height: 12),
              TextButton.icon(
                onPressed: () {
                  setState(() {
                    nama = '';
                    voucher = '-';
                    halaman = 0;
                  });
                },
                icon: const Icon(Icons.logout),
                label: const Text('Keluar'),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: navigasiBawah(2),
    );
  }

  // HALAMAN 4: DETAIL GADGET
  Widget halamanDetail() {
    final item = produk[produkDipilih];
    final harga = item['harga'] as int;
    final diskon = voucher == 'Diskon 10%'
        ? 0.10
        : voucher == 'Diskon 20%'
            ? 0.20
            : 0.0;
    final hargaAkhir = (harga * (1 - diskon)).round();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Gadget'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => bukaHalaman(1),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            height: 210,
            decoration: BoxDecoration(
              color: lightPink,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Icon(
              item['icon'] as IconData,
              size: 115,
              color: pink,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            item['nama'] as String,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: pink,
            ),
          ),
          const SizedBox(height: 16),
          detailBaris('Nama', item['nama'] as String),
          detailBaris('Harga', rupiah(harga)),
          detailBaris('Voucher', voucher),
          if (diskon > 0) ...[
            detailBaris(
              'Diskon',
              '${(diskon * 100).toInt()}%',
            ),
            detailBaris('Total Bayar', rupiah(hargaAkhir)),
          ],
          const SizedBox(height: 25),
          SizedBox(
            height: 52,
            child: ElevatedButton.icon(
              onPressed: () => bukaHalaman(4),
              icon: const Icon(Icons.local_offer),
              label: const Text('Klaim Voucher Diskon'),
              style: ElevatedButton.styleFrom(
                backgroundColor: pink,
                foregroundColor: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 15),
          OutlinedButton.icon(
            onPressed: () => bukaHalaman(1),
            icon: const Icon(Icons.storefront),
            label: const Text('Kembali ke Katalog'),
            style: OutlinedButton.styleFrom(
              foregroundColor: pink,
            ),
          ),
        ],
      ),
    );
  }

  Widget detailBaris(String judul, String isi) {
    return Card(
      color: Colors.white,
      child: ListTile(
        title: Text(judul),
        trailing: Text(
          isi,
          style: const TextStyle(
            color: pink,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // HALAMAN 5: PILIH VOUCHER
  Widget halamanVoucher() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pilih Voucher'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => bukaHalaman(3),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Icon(
            Icons.card_giftcard,
            size: 85,
            color: pink,
          ),
          const SizedBox(height: 12),
          const Text(
            'Pilih Diskon Voucher Anda ♡',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: pink,
            ),
          ),
          const SizedBox(height: 25),
          kartuVoucher(
            'Diskon 10%',
            'Hemat 10% dari harga gadget',
            Icons.local_offer,
          ),
          const SizedBox(height: 16),
          kartuVoucher(
            'Diskon 20%',
            'Hemat 20% dari harga gadget',
            Icons.discount,
          ),
          const SizedBox(height: 20),
          OutlinedButton(
            onPressed: () {
              setState(() {
                voucher = '-';
                halaman = 3;
              });
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: pink,
            ),
            child: const Text('Tidak menggunakan voucher'),
          ),
          const SizedBox(height: 10),
          const Center(
            child: Text(
              '♡ Happy Shopping ♡',
              style: TextStyle(color: pink, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget kartuVoucher(String namaVoucher, String deskripsi, IconData ikon) {
    final terpilih = voucher == namaVoucher;

    return Card(
      color: terpilih ? lightPink : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: terpilih ? pink : lightPink,
          width: terpilih ? 2 : 1,
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Icon(ikon, size: 38, color: pink),
        title: Text(
          namaVoucher,
          style: const TextStyle(
            color: pink,
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(deskripsi),
        trailing: Icon(
          terpilih ? Icons.check_circle : Icons.circle_outlined,
          color: pink,
        ),
        onTap: () {
          setState(() {
            voucher = namaVoucher;
            halaman = 3;
          });
        },
      ),
    );
  }

  // NAVIGASI BAWAH
  Widget navigasiBawah(int aktif) {
    return BottomNavigationBar(
      currentIndex: aktif == 2 ? 1 : 0,
      selectedItemColor: pink,
      unselectedItemColor: Colors.grey,
      backgroundColor: Colors.white,
      onTap: (index) {
        bukaHalaman(index == 0 ? 1 : 2);
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.storefront),
          label: 'Katalog',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profil',
        ),
      ],
    );
  }
}