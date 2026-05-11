import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: LatihanWidgetPage(),
  ));
}

class LatihanWidgetPage extends StatelessWidget {
  const LatihanWidgetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Eksperimen Widget Dasar'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView( // Agar tidak error jika layar penuh
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              // --- LATIHAN 1: Text & Styling ---
              const Text(
                'Hello Flutter!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                  letterSpacing: 2, // Eksperimen letterSpacing
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Ini teks biasa dengan ukuran kecil',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),

              const SizedBox(height: 30),

              // --- LATIHAN 2: Container & Decoration ---
              Center(
                child: Container(
                  width: 200,
                  height: 200,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black, width: 4), // Eksperimen Border
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withOpacity(0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Text(
                      'Box',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // --- LATIHAN 3: Row & MainAxisAlignment ---
              const Text('Eksperimen Layout Row:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Container(
                color: Colors.grey.shade200,
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Ganti-ganti di sini
                  children: [
                    Container(width: 40, height: 40, color: Colors.red),
                    Container(width: 40, height: 40, color: Colors.green),
                    Container(width: 40, height: 40, color: Colors.blue),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // --- LATIHAN 4: Icon & Mock-up Menu ---
              const Text('Ikon & Warna (Latihan 4):',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(Icons.home, color: Colors.red, size: 48),
                  Icon(Icons.receipt_long, color: Colors.green, size: 48),
                  Icon(Icons.notifications, color: Colors.purple, size: 48),
                  Icon(Icons.person, color: Colors.blue, size: 48),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}