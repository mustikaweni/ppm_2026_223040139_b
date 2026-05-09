import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Latihan Widget - Pertemuan 1'),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
        body: SingleChildScrollView( // Agar bisa di-scroll kalau layar penuh
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 30),

                // LATIHAN 1 & 4: Text Styling & Icons
                const Icon(Icons.flutter_dash, size: 80, color: Colors.blue), // Icon (Latihan 4)
                const SizedBox(height: 16),
                const Text(
                  'Halo, MUSTIKA WENI!',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5, // Eksperimen letterSpacing (Latihan 1)
                    color: Colors.blueAccent,
                  ),
                ),
                const Text(
                  'Teknik Informatika - UNPAS',
                  style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                ),

                const SizedBox(height: 30),

                // LATIHAN 2: Container Decoration (Shadow & Radius)
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20), // Border Radius (Latihan 2)
                    border: Border.all(color: Colors.blue.shade100),
                    boxShadow: [ // Shadow (Latihan 2)
                      BoxShadow(
                        color: Colors.blue.withOpacity(0.2),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // LATIHAN 3: Row (Menyusun menyamping)
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.badge, color: Colors.blue),
                          SizedBox(width: 15),
                          Text('NIM: 223040139', style: TextStyle(fontSize: 17)),
                        ],
                      ),
                      const Divider(height: 25), // Garis pembatas
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.star, color: Colors.orange),
                          SizedBox(width: 15),
                          Text('Semester: 6', style: TextStyle(fontSize: 17)),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // LATIHAN 3: Row dengan Space Evenly
                const Text('Eksperimen Layout Row:', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(children: [Icon(Icons.code), Text('Coding')]),
                    Column(children: [Icon(Icons.palette), Text('Design')]),
                    Column(children: [Icon(Icons.games), Text('Gaming')]),
                  ],
                ),

                const SizedBox(height: 40),

                // Tombol Interaktif
                ElevatedButton.icon(
                  onPressed: () {
                    print('Semangat Semester 6!');
                  },
                  icon: const Icon(Icons.send),
                  label: const Text('Kirim Tugas'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}