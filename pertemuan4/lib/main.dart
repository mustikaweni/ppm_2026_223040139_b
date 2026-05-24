import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class Catatan {
  final String judul;
  final String isi;
  final String kategori;
  final String email;
  final DateTime dibuatPada;

  Catatan({
    required this.judul,
    required this.isi,
    required this.kategori,
    required this.email,
    required this.dibuatPada,
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Catatan> _semuaCatatan = [
    Catatan(judul: 'Belajar Flutter', isi: 'Stateful, Form, Nav', kategori: 'Kuliah', email: 'user@mhs.com', dibuatPada: DateTime.now()),
  ];
  String _filterKategori = 'Semua';

  List<Catatan> get _catatanFiltered => _filterKategori == 'Semua'
      ? _semuaCatatan
      : _semuaCatatan.where((c) => c.kategori == _filterKategori).toList();

  void _bukaForm({Catatan? editData, int? index}) async {
    final hasil = await Navigator.push(context, MaterialPageRoute(builder: (_) => TambahCatatanPage(catatanToEdit: editData)));
    if (hasil is Catatan) {
      setState(() {
        if (index != null) _semuaCatatan[index] = hasil;
        else _semuaCatatan.add(hasil);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Catatan Mahasiswa'), actions: [
        DropdownButton<String>(
          value: _filterKategori,
          items: ['Semua', 'Kuliah', 'Tugas', 'Pribadi', 'Lainnya'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          onChanged: (v) => setState(() => _filterKategori = v!),
        )
      ]),
      body: ListView.builder(
        itemCount: _catatanFiltered.length,
        itemBuilder: (context, i) {
          final c = _catatanFiltered[i];
          return ListTile(
            title: Text(c.judul),
            subtitle: Text('${c.kategori} • ${c.email}'),
            onTap: () async {
              // Kita kirim index yang sebenarnya dari _semuaCatatan
              final actualIndex = _semuaCatatan.indexOf(c);
              final res = await Navigator.push(context, MaterialPageRoute(builder: (_) => DetailPage(catatan: c)));
              if (res == 'edit') _bukaForm(editData: c, index: actualIndex);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(onPressed: () => _bukaForm(), child: const Icon(Icons.add)),
    );
  }
}

class TambahCatatanPage extends StatefulWidget {
  final Catatan? catatanToEdit;
  const TambahCatatanPage({super.key, this.catatanToEdit});
  @override
  State<TambahCatatanPage> createState() => _TambahCatatanPageState();
}

class _TambahCatatanPageState extends State<TambahCatatanPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _jCtrl, _iCtrl, _eCtrl;
  String _kat = 'Kuliah';

  @override
  void initState() {
    super.initState();
    _jCtrl = TextEditingController(text: widget.catatanToEdit?.judul ?? '');
    _iCtrl = TextEditingController(text: widget.catatanToEdit?.isi ?? '');
    _eCtrl = TextEditingController(text: widget.catatanToEdit?.email ?? '');
    _kat = widget.catatanToEdit?.kategori ?? 'Kuliah';
  }

  @override
  void dispose() { // Penting untuk performance
    _jCtrl.dispose();
    _iCtrl.dispose();
    _eCtrl.dispose();
    super.dispose();
  }

  void _simpan() {
    if (!_formKey.currentState!.validate()) return;
    Navigator.pop(context, Catatan(judul: _jCtrl.text, isi: _iCtrl.text, kategori: _kat, email: _eCtrl.text, dibuatPada: DateTime.now()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.catatanToEdit == null ? 'Tambah' : 'Edit')),
      body: Form(key: _formKey, child: ListView(padding: const EdgeInsets.all(16), children: [
        TextFormField(controller: _jCtrl, decoration: const InputDecoration(labelText: 'Judul'), validator: (v) => v!.length < 3 ? 'Min 3 karakter' : null),
        TextFormField(
            controller: _eCtrl,
            decoration: const InputDecoration(labelText: 'Email'),
            validator: (v) => !RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(v!) ? 'Format email tidak valid' : null
        ),
        DropdownButtonFormField(value: _kat, items: ['Kuliah', 'Tugas', 'Pribadi', 'Lainnya'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => setState(() => _kat = v!)),
        TextFormField(controller: _iCtrl, decoration: const InputDecoration(labelText: 'Isi'), maxLines: 3),
        const SizedBox(height: 20),
        FilledButton(onPressed: _simpan, child: const Text('Simpan'))
      ])),
    );
  }
}

class DetailPage extends StatelessWidget {
  final Catatan catatan;
  const DetailPage({super.key, required this.catatan});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [IconButton(icon: const Icon(Icons.edit), onPressed: () => Navigator.pop(context, 'edit'))]),
      body: Padding(padding: const EdgeInsets.all(20), child: Text('${catatan.isi}\n\nEmail: ${catatan.email}')),
    );
  }
}