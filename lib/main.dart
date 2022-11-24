import 'dart:io';

import 'package:e_learning/providers/notifikasi_provider.dart';
import 'package:e_learning/providers/theme_providers.dart';
import 'package:e_learning/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/mapel_provider.dart';
import 'providers/user_provider.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/materi_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/tugas_screen.dart';

void main() {
  HttpOverrides.global = new MyHttpOverrides();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => UserProvider()),
    ChangeNotifierProvider(create: (_) => MapelProvider()),
    ChangeNotifierProvider(create: (_) => ThemeProvider()),
    ChangeNotifierProvider(create: (_) => NotifikasiProvider()),
  ], child: const LMSApps()));
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class LMSApps extends StatefulWidget {
  const LMSApps({super.key});

  @override
  State<LMSApps> createState() => _LMSAppsState();
}

class _LMSAppsState extends State<LMSApps> {
  final ThemeProvider theme = ThemeProvider();
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, value, child) {
      final theme = Provider.of<ThemeProvider>(context);
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'LMS Mobile Apps',
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          '/login': (context) => const LoginScreen(),
          '/home': (context) => const HomeScreen(),
          '/tugas': (context) => const TugasScreen(),
          '/materi': (context) => const MateriScreen(),
        },
        themeMode: theme.themeMode,
        darkTheme: darkTheme,
        theme: lightTheme,
      );
    });
  }
}
