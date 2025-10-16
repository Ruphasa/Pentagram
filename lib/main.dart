import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pentagram/pages/activity_broadcast/activity_add.dart';
import 'package:pentagram/pages/dashboard.dart';
import 'package:pentagram/pages/activity_broadcast/activity_view.dart';
import 'package:pentagram/pages/keuangan/pemasukan_page.dart';
import 'package:pentagram/pages/keuangan/pengeluaran_page.dart';
import 'package:pentagram/pages/login/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pentagram/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ).apply(bodyColor: Colors.black87),
        canvasColor: const Color(0xFFFFFFFF),
      ),
      initialRoute: '/login',
      routes: {
        '/': (ctx) => const DashboardScreen(),
        '/login': (ctx) => const LoginPage(),
        '/activity/view': (ctx) => const ActivityView(),
        '/activity/add': (ctx) => const ActivityAdd(),
        '/pemasukan': (ctx) => const PemasukanPage(),
        '/pengeluaran': (ctx) => const PengeluaranPage(),
      },
    );
  }
}
