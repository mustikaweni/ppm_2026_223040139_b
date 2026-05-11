import 'package:flutter/material.dart';

class GalleryHome extends StatelessWidget {
  const GalleryHome({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      ('Display', Icons.image, Colors.blue),
      ('Input', Icons.edit, Colors.green),
      ('Button', Icons.smart_button, Colors.orange),
      ('Feedback', Icons.notifications, Colors.purple),
      ('Layout', Icons.dashboard, Colors.teal),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Widget Gallery')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (context, i) {
          final (name, icon, color) = categories[i];
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: color,
                child: Icon(icon, color: Colors.white),
              ),
              title: Text(name),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => CategoryPage(name: name)),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class CategoryPage extends StatelessWidget {
  final String name;
  const CategoryPage({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: _buildDemoContent(name),
      ),
    );
  }

  Widget _buildDemoContent(String name) {
    // Mempertahankan logika switch dari kode awal kamu
    switch (name) {
      case 'Display':
        return Column(children: [
          const Card(child: ListTile(leading: Icon(Icons.album), title: Text('Judul Item'), subtitle: Text('Sub-judul'))),
          Wrap(spacing: 8, children: const [Chip(label: Text('Flutter')), Chip(label: Text('Dart'))]),
        ]);
      case 'Input':
        return const TextField(decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'Nama'));
      case 'Button':
        return ElevatedButton(onPressed: () {}, child: const Text('Elevated Button'));
      case 'Feedback':
        return const Center(child: CircularProgressIndicator());
      case 'Layout':
        return SizedBox(
          height: 100,
          child: GridView.count(crossAxisCount: 3, children: List.generate(3, (i) => Container(color: Colors.blue[(i+1)*100], margin: const EdgeInsets.all(4)))),
        );
      default:
        return const Center(child: Text('Konten Belum Tersedia'));
    }
  }
}