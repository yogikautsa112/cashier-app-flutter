import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReceiptPage extends StatelessWidget {
  const ReceiptPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> dummyItems = [
      {
        'name': 'Cokelat Susu',
        'price': 10000,
        'quantity': 2,
      },
      {
        'name': 'Baso',
        'price': 15000,
        'quantity': 1,
      },
      {
        'name': 'Pempek Palembang',
        'price': 30000,
        'quantity': 3,
      },
    ];
    
    final int totalHarga = dummyItems.fold(0, (sum, item) => sum + (item['price'] * item['quantity'] as int));
    final DateTime dateTime = DateTime.now();
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Struk Pembayaran', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.grey[200], // Latar belakang lebih terang
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 450), // Sedikit lebih kecil untuk keterbacaan
          child: Card(
            margin: const EdgeInsets.all(20),
            elevation: 8, // Bayangan lebih jelas
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24), // Padding lebih besar
              child: Column(
                children: [
                  _buildReceiptHeader(dateTime),
                  const SizedBox(height: 24),
                  _buildItemsList(dummyItems),
                  const Divider(thickness: 2), // Garis pemisah lebih tebal
                  _buildTotalSection(totalHarga),
                  const SizedBox(height: 32),
                  _buildThankYouSection(),
                  const SizedBox(height: 24),
                  _buildActionButtons(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildReceiptHeader(dateTime) {
    return Column(
      children: [
        const Text(
          'CASHIER APP',
          style: TextStyle(
            fontSize: 28, // Ukuran font lebih besar
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2, // Jarak antar huruf
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Jl. Kangen No. 123, Kota Dia',
          style: TextStyle(fontSize: 16), // Ukuran font lebih besar
        ),
        const SizedBox(height: 6),
        const Text(
          'Telp: 0812-8967-6464',
          style: TextStyle(fontSize: 16), // Ukuran font lebih besar
        ),
        const SizedBox(height: 12),
        const Divider(thickness: 2), // Garis pemisah lebih tebal
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Tanggal: ${DateFormat('dd/MM/yyyy').format(dateTime)}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500), // Lebih tebal
            ),
            Text(
              'Waktu: ${DateFormat('HH:mm:ss').format(dateTime)}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500), // Lebih tebal
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const Text(
              'No. Struk: ',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500), // Lebih tebal
            ),
            Text(
              'INV-${DateFormat('yyyyMMdd-HHmmss').format(dateTime)}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500), // Lebih tebal
            ),
          ],
        ),
        const SizedBox(height: 12),
        const Divider(thickness: 2), // Garis pemisah lebih tebal
      ],
    );
  }

  Widget _buildItemsList(List<Map<String, dynamic>> purchasedItems) {
    return Column(
      children: [
        Row(
          children: const [
            Expanded(
              flex: 3,
              child: Text(
                'Item',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18), // Lebih besar
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                'Qty',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18), // Lebih besar
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                'Harga',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18), // Lebih besar
                textAlign: TextAlign.right,
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                'Subtotal',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18), // Lebih besar
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: purchasedItems.length,
          itemBuilder: (context, index) {
            final item = purchasedItems[index];
            final quantity = item['quantity'] as int;
            final price = item['price'] as int;
            final subtotal = quantity * price;

            return Padding(
              padding: const EdgeInsets.only(bottom: 12), // Jarak antar item lebih besar
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      item['name'],
                      style: const TextStyle(fontSize: 16), // Lebih besar
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      quantity.toString(),
                      style: const TextStyle(fontSize: 16), // Lebih besar
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      _formatCurrency(price),
                      style: const TextStyle(fontSize: 16), // Lebih besar
                      textAlign: TextAlign.right,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      _formatCurrency(subtotal),
                      style: const TextStyle(fontSize: 16), // Lebih besar
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildTotalSection(totalHarga) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16), // Padding lebih besar
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'TOTAL',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20, // Lebih besar
            ),
          ),
          Text(
            _formatCurrency(totalHarga),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20, // Lebih besar
              color: Colors.blue, // Warna untuk menekankan
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThankYouSection() {
    return Column(
      children: const [
        Text(
          'Terima Kasih',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20, // Lebih besar
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Silahkan datang kembali',
          style: TextStyle(fontSize: 16), // Lebih besar
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton.icon(
          onPressed: () {
            // Implementasi cetak struk
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Fitur cetak belum tersedia')),
            );
          },
          icon: const Icon(Icons.print, size: 24), // Ikon lebih besar
          label: const Text('Cetak', style: TextStyle(fontSize: 16)), // Teks lebih besar
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12), // Padding lebih besar
          ),
        ),
        ElevatedButton.icon(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, size: 24), // Ikon lebih besar
          label: const Text('Kembali', style: TextStyle(fontSize: 16)), // Teks lebih besar
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12), // Padding lebih besar
          ),
        ),
      ],
    );
  }

  String _formatCurrency(int value) {
    return 'Rp ${value.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]}.',
        )}';
  }
}