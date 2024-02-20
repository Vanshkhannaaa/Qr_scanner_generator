import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_scanner_generator/nav_page.dart';
import 'package:qr_scanner_generator/qr_generator.dart';
import 'package:qr_scanner_generator/qr_scanner.dart';
import 'package:qr_scanner_generator/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Checking if storage permission is already granted
  var status = await Permission.storage.status;
  if (!status.isGranted) {
    // Requesting storage permission if not granted
    await Permission.storage.request();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QR CODE SCANNER AND GENERATOR',
      theme: ThemeData(
        primaryColor: Colors.blue.shade400,
        secondaryHeaderColor: Colors.blue.shade400,
        colorScheme: const ColorScheme.dark().copyWith(
          background: Colors.black,
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashPage(),
        '/scanner': (context) => const Scanner(),
        '/generator': (context) => const Generator(),
        '/nav': (context) => const NavPage(),
      },
    );
  }
}
