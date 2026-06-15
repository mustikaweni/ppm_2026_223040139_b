import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'main.dart' show Catatan;

class ApiException implements Exception {
  final int statusCode;
  final String message;
  ApiException(this.statusCode, this.message);
  @override
  String toString() => 'ApiException($statusCode): $message';
}

class ApiClient {
  ApiClient._();
  static final ApiClient instance = ApiClient._();

  static const String _baseUrl = 'https://besab-production.up.railway.app/api';
  static const String _apiKey  = '8f38b5fbf0bc437285f2c62ed6e447eab56f78c8f95239a7';
  static const _timeout = Duration(seconds: 30); // Timeout dilonggarkan jadi 30 detik

  Map<String, String> get _headers => {
    'X-API-Key': _apiKey,
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  // ===== CRUD =====

  Future<List<Catatan>> getAll() async {
    final res = await _send(() => http.get(
      Uri.parse('$_baseUrl/catatan'),
      headers: {
        'X-API-Key': _apiKey, // Hanya mengirimkan API Key saja
      },
    ));
    final body = jsonDecode(res.body) as Map<String, dynamic>;
    final dataRaw = body['data'];
    if (dataRaw == null) return [];
    final list = (dataRaw as List).cast<Map<String, dynamic>>();
    return list.map(Catatan.fromJson).toList();
  }

  Future<Catatan> getById(int id) async {
    final res = await _send(() => http.get(
      Uri.parse('$_baseUrl/catatan/$id'),
      headers: _headers,
    ));
    final body = jsonDecode(res.body) as Map<String, dynamic>;
    return Catatan.fromJson(body['data'] as Map<String, dynamic>);
  }

  Future<Catatan> insert(Catatan c) async {
    // Membuat payload bersih tanpa ID dan variasi tanggal agar diterima oleh server
    final payload = {
      'judul': c.judul,
      'isi': c.isi,
      'kategori': c.kategori,
      'dibuat_pada': DateTime.now().toUtc().toIso8601String(),
    };

    final res = await _send(() => http.post(
      Uri.parse('$_baseUrl/catatan'),
      headers: _headers,
      body: jsonEncode(payload),
    ));
    final body = jsonDecode(res.body) as Map<String, dynamic>;
    return Catatan.fromJson(body['data'] as Map<String, dynamic>);
  }

  Future<Catatan> update(Catatan c) async {
    assert(c.id != null);

    final payload = {
      'judul': c.judul,
      'isi': c.isi,
      'kategori': c.kategori,
      'dibuat_pada': c.dibuatPada.toUtc().toIso8601String(),
    };

    final res = await _send(() => http.put(
      Uri.parse('$_baseUrl/catatan/${c.id}'),
      headers: _headers,
      body: jsonEncode(payload),
    ));
    final body = jsonDecode(res.body) as Map<String, dynamic>;
    return Catatan.fromJson(body['data'] as Map<String, dynamic>);
  }

  Future<void> delete(int id) async {
    await _send(() => http.delete(
      Uri.parse('$_baseUrl/catatan/$id'),
      headers: _headers,
    ));
  }

  // ===== Helper =====
  Future<http.Response> _send(Future<http.Response> Function() req) async {
    try {
      final res = await req().timeout(_timeout);
      if (res.statusCode >= 200 && res.statusCode < 300) return res;
      throw ApiException(res.statusCode, _extractMessage(res));
    } on SocketException {
      throw ApiException(0, 'Tidak ada koneksi internet.');
    } on TimeoutException {
      throw ApiException(0, 'Server tidak merespons (timeout).');
    }
  }

  String _extractMessage(http.Response res) {
    // Ditambahkan print log otomatis agar ketahuan di VS Code jika server menolak sesuatu
    print("====== LOG SERVER ERROR ======");
    print("Status Code: ${res.statusCode}");
    print("Response Body: ${res.body}");
    print("==============================");

    try {
      final m = jsonDecode(res.body) as Map<String, dynamic>;
      return (m['message'] as String?) ?? 'HTTP ${res.statusCode}';
    } catch (_) {
      return 'HTTP ${res.statusCode}';
    }
  }
}