import 'package:flutter/material.dart';
import 'gallery_widget.dart'; // Import file Gallery Widget

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Saya'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),

      // ==================================================================
      // DRAWER (Sesuai Eksperimen Modul Hal. 16-18)
      // ==================================================================
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            const ListTile(
              leading: Icon(Icons.home),
              title: Text('Beranda'),
            ),
            const ListTile(
              leading: Icon(Icons.settings),
              title: Text('Pengaturan'),
            ),
            // Navigasi ke Widget Gallery (Latihan Mandiri)
            ListTile(
              leading: const Icon(Icons.widgets),
              title: const Text('Widget Gallery'),
              onTap: () {
                Navigator.pop(context); // Tutup drawer
                // Pindah halaman ke GalleryHome (class di file gallery_widget.dart)
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const GalleryHome()),
                );
              },
            ),
          ],
        ),
      ),

      // ==================================================================
      // BODY PROFILE PAGE
      // ==================================================================
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // == HEADER PROFIL ==
            Center(
              child: Column(
                children: [
                  // PERBAIKAN: Menggunakan Foto Profil GitHub Asli
                  const CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey, // Warna background saat loading
                    backgroundImage: NetworkImage(
                      // Masukkan URL foto GitHub kamu di sini
                      'https://avatars.githubusercontent.com/u/150616180?v=4',
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Mustika Weni',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Mahasiswa Teknik Informatika - UNPAS',
                    style:
                    TextStyle(fontSize: 14, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // == STAT BOX (Latihan Mandiri - Layout Row) ==
            Row(
              children: const [
                Expanded(child: _StatBox(label: 'Post', value: '12')),
                Expanded(child: _StatBox(label: 'Teman', value: '128')),
                Expanded(child: _StatBox(label: 'Like', value: '1.2K')),
              ],
            ),
            const SizedBox(height: 24),

            // == SECTIONS (Latihan Mandiri - Section Info & Skills) ==
            const _SectionCard(
              icon: Icons.school,
              title: 'Pendidikan',
              content: 'Universitas Pasundan\nNPM: 223040139',
            ),
            const _SectionCard(
              icon: Icons.star,
              title: 'Skills',
              content: 'Flutter • Dart • Laravel • Tailwind CSS • UI Design',
            ),
            const _SectionCard(
              icon: Icons.favorite,
              title: 'Hobi',
              content: 'Gaming (Roblox) • Coding • Mobile Development',
            ),
            const _SectionCard(
              icon: Icons.email,
              title: 'Kontak',
              content: 'mustika.weni@unpas.ac.id\nGitHub: mustikaweni',
            ),

            const SizedBox(height: 80), // Biar tidak tertutup FAB
          ],
        ),
      ),

      // ==================================================================
      // FLOATING ACTION BUTTON (Sesuai Modul Hal. 21)
      // ==================================================================
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Menampilkan SnackBar saat FAB ditekan
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Fitur edit belum tersedia')),
          );
        },
        icon: const Icon(Icons.edit),
        label: const Text('Edit'),
      ),

      // ==================================================================
      // BOTTOM NAVIGATION BAR (Sesuai Modul Hal. 20)
      // ==================================================================
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1, // Set aktif di profil
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Pesan'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Setting'),
        ],
        onTap: (i) {},
      ),
    );
  }
}

// ==================================================================
// HELPER WIDGET - PROFILE PAGE
// ==================================================================
class _StatBox extends StatelessWidget {
  final String label;
  final String value;
  const _StatBox({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(color: Colors.grey.shade600)),
      ],
    );
  }
}

class _SectionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String content;
  const _SectionCard({
    required this.icon,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: Colors.blue, size: 28),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  Text(content, style: const TextStyle(height: 1.4)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}