   import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const CryptoApp());
}

class CryptoApp extends StatelessWidget {
  const CryptoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cryptocurrency UT',
      theme: ThemeData(
        primaryColor: const Color(0xFF003F88), // UT Blue
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF003F88),
          primary: const Color(0xFF003F88),
          secondary: const Color(0xFFFFD700), // UT Gold/Yellow
        ),
        useMaterial3: true,
      ),
      home: const CryptoPage(),
    );
  }
}

class CryptoPage extends StatefulWidget {
  const CryptoPage({super.key});

  @override
  State<CryptoPage> createState() => _CryptoPageState();
}

class _CryptoPageState extends State<CryptoPage> {
  List cryptoList = [];
  bool isLoading = true;
  String errorMessage = '';

  // Map kode mata uang berdasarkan simbol crypto
  static const Map<String, String> currencyCodeMap = {
    'BTC': 'XBT',
    'ETH': 'ETH',
    'USDT': 'USDT',
    'BNB': 'BNB',
    'XRP': 'XRP',
    'ADA': 'ADA',
    'SOL': 'SOL',
    'DOGE': 'DOGE',
    'DOT': 'DOT',
    'MATIC': 'MATIC',
    'LTC': 'LTC',
    'SHIB': 'SHIB',
    'AVAX': 'AVAX',
    'TRX': 'TRX',
    'LINK': 'LINK',
    'UNI': 'UNI',
    'ATOM': 'ATOM',
    'XLM': 'XLM',
    'ETC': 'ETC',
    'BCH': 'BCH',
    'ALGO': 'ALGO',
    'VET': 'VET',
    'ICP': 'ICP',
    'FIL': 'FIL',
    'HBAR': 'HBAR',
    'MANA': 'MANA',
    'SAND': 'SAND',
    'AXS': 'AXS',
    'THETA': 'THETA',
    'XTZ': 'XTZ',
  };

  // Warna untuk CircleAvatar berdasarkan rank
  Color getRankColor(int rank) {
    if (rank == 1) return const Color(0xFFFFD700); // Gold
    if (rank == 2) return const Color(0xFFC0C0C0); // Silver
    if (rank == 3) return const Color(0xFFCD7F32); // Bronze
    if (rank <= 10) return const Color(0xFF003F88); // UT Blue
    if (rank <= 20) return const Color(0xFF1565C0); // Light Blue
    return const Color(0xFF1976D2); // Default Blue
  }

  String getCurrencyCode(String symbol) {
    return currencyCodeMap[symbol.toUpperCase()] ?? symbol.toUpperCase();
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      final response = await http
          .get(
            Uri.parse('https://api.coinlore.net/api/tickers/'),
            headers: {'Accept': 'application/json'},
          )
          .timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          cryptoList = data['data'];
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = 'Gagal memuat data. Status: ${response.statusCode}';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Koneksi gagal. Periksa internet Anda.\n$e';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ─── AppBar dengan warna UT Biru ─────────────────────────────────
      appBar: AppBar(
        backgroundColor: const Color(0xFF003F88),
        foregroundColor: Colors.white,
        // Header: Header info tugas + judul
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Baris info tugas
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: const Color(0xFFFFD700),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                'Tugas 3  |  Rizky  |  048738125',
                style: TextStyle(
                  color: Color(0xFF003F88),
                  fontWeight: FontWeight.w800,
                  fontSize: 11,
                  letterSpacing: 0.3,
                ),
              ),
            ),
            const SizedBox(height: 3),
            // Judul utama
            Row(
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFD700),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Center(
                    child: Text(
                      'UT',
                      style: TextStyle(
                        color: Color(0xFF003F88),
                        fontWeight: FontWeight.w900,
                        fontSize: 11,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  'Daftar Cryptocurrency',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
        centerTitle: false,
        toolbarHeight: 72,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            tooltip: 'Refresh Data',
            onPressed: fetchData,
          ),
        ],
      ),

      // ─── Body dengan background bergaya UT Biru ──────────────────────
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFE3EEF8), // biru sangat muda
              Color(0xFFF0F4FF), // putih kebiruan
              Color(0xFFE8F0FE), // biru muda
            ],
          ),
        ),
        child: isLoading
            ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: Color(0xFF003F88),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Memuat data cryptocurrency...',
                      style: TextStyle(
                        color: Color(0xFF003F88),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              )
            : errorMessage.isNotEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.error_outline,
                              color: Colors.red, size: 56),
                          const SizedBox(height: 16),
                          Text(
                            errorMessage,
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.red),
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF003F88),
                              foregroundColor: Colors.white,
                            ),
                            onPressed: fetchData,
                            icon: const Icon(Icons.refresh),
                            label: const Text('Coba Lagi'),
                          ),
                        ],
                      ),
                    ),
                  )
                : RefreshIndicator(
                    color: const Color(0xFF003F88),
                    onRefresh: fetchData,
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      itemCount: cryptoList.length,
                      itemBuilder: (context, index) {
                        final crypto = cryptoList[index];
                        final int rank =
                            int.tryParse(crypto['rank'].toString()) ??
                                (index + 1);
                        final String symbol =
                            crypto['symbol']?.toString() ?? '-';
                        final String currencyCode = getCurrencyCode(symbol);
                        final String priceUsd =
                            crypto['price_usd']?.toString() ?? '0';

                        return Card(
                          margin: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 2),
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: const BorderSide(
                              color: Color(0xFFBBD6F5),
                              width: 0.8,
                            ),
                          ),
                          color: Colors.white.withOpacity(0.90),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 8),
                            // ─── Avatar Rank ─────────────────────────
                            leading: CircleAvatar(
                              backgroundColor: getRankColor(rank),
                              radius: 22,
                              child: Text(
                                rank.toString(),
                                style: TextStyle(
                                  fontSize: rank > 99 ? 10 : 12,
                                  fontWeight: FontWeight.bold,
                                  color: rank <= 3
                                      ? Colors.black87
                                      : Colors.white,
                                ),
                              ),
                            ),
                            // ─── Nama Crypto ─────────────────────────
                            title: Text(
                              crypto['name']?.toString() ?? '-',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Color(0xFF0D2B5E),
                              ),
                            ),
                            // ─── Detail: Symbol, Kode, Harga ─────────
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    // Badge simbol – biru UT
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF003F88),
                                        borderRadius:
                                            BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        symbol,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    // Badge kode mata uang – kuning emas
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFFFD700),
                                        borderRadius:
                                            BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        'Kode: $currencyCode',
                                        style: const TextStyle(
                                          color: Color(0xFF0D2B5E),
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Harga USD : \$$priceUsd',
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: Color(0xFF1A3A6B),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
      ),

      // ─── FAB Refresh ─────────────────────────────────────────────────
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFF003F88),
        foregroundColor: Colors.white,
        onPressed: fetchData,
        icon: const Icon(Icons.refresh),
        label: const Text('Refresh'),
      ),
    );
  }
}
