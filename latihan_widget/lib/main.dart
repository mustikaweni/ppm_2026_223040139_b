import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      body: Center(
        child: Container(
          // 1. Dimensi Kotak
          width: 200,
          height: 200,
          padding: const EdgeInsets.all(20),

          // 2. Dekorasi Kotak
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(20), // Sudut melengkung
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withValues(alpha: 0.3),
                blurRadius: 20, // Kehalusan bayangan
                offset: const Offset(0, 10), // Posisi bayangan (x, y)
              ),
            ],
          ),

          // 3. Konten di dalam Kotak
          child: const Center(
            child: Text(
              'Box',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
        ),
      ),
    ),
  ));
}