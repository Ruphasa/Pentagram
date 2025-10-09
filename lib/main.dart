import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'page/dashboard.dart'; // <-- DISESUAIKAN DENGAN STRUKTUR ANDA

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dashboard Jawara Pintar',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: const Color(0xFFF0F5F5),
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.black87),
        canvasColor: const Color(0xFFFFFFFF),
      ),
      // Class yang dipanggil tetap DashboardScreen
      home: DashboardScreen(), 
    );
  }
}