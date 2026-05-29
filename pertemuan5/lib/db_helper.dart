import 'package:flutter/foundation.dart'; // <--- Tambahkan ini
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'main.dart' show Catatan;

class DbHelper {
  DbHelper._();
  static final DbHelper instance = DbHelper._();

  static const _dbName = 'catatan.db';
  static const _dbVersion = 1;
  static const tabel = 'catatan';

  Database? _db;

  Future<Database> get database async {
    // Jika _db sudah ada, langsung kembalikan
    if (_db != null) return _db!;
    // Jika belum, inisialisasi dan tunggu sampai selesai
    _db = await _openDb();
    return _db!;
  }

  Future<Database> _openDb() async {
    final dir = await getDatabasesPath();
    final path = join(dir, _dbName);

    return await openDatabase(
      path,
      version: _dbVersion,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $tabel (
            id          INTEGER PRIMARY KEY AUTOINCREMENT,
            judul       TEXT    NOT NULL,
            isi         TEXT    NOT NULL,
            kategori    TEXT    NOT NULL,
            dibuat_pada INTEGER NOT NULL
          )
        ''');
      },
    );
  }

  // ===== CRUD

  Future<int> insert(Catatan c) async {
    final db = await database;
    return await db.insert(tabel, c.toMap());
  }

  Future<List<Catatan>> getAll() async {
    final db = await database;
    final rows = await db.query(tabel, orderBy: 'dibuat_pada DESC');
    return rows.map((e) => Catatan.fromMap(e)).toList();
  }

  // Contoh untuk update
  Future<int> update(Catatan c) async {
    if (c.id == null) return 0;
    final db = await database;
    int count = await db.update(tabel, c.toMap(), where: 'id = ?', whereArgs: [c.id]);
    debugPrint('Data ID ${c.id} berhasil diupdate: $count');
    return count;
  }

// Contoh untuk delete
  Future<int> delete(int id) async {
    final db = await database;
    int count = await db.delete(tabel, where: 'id = ?', whereArgs: [id]);
    debugPrint('Data ID $id berhasil dihapus: $count');
    return count;
  }
}