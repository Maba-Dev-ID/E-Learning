import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/mapel_provider.dart';
import 'providers/user_provider.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/materi_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/tugas_screen.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => UserProvider()),
    ChangeNotifierProvider(create: (_) => MapelProvider()),
  ], child: const LMSApps()));
}

class LMSApps extends StatefulWidget {
  const LMSApps({super.key});

  @override
  State<LMSApps> createState() => _LMSAppsState();
}

class _LMSAppsState extends State<LMSApps> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, value, child) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'LMS Mobile Apps',
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          '/login': (context) => const LoginScreen(),
          '/home': (context) => const HomeScreen(),
          '/profile': (context) => const ProfileScreen(),
          '/tugas': (context) => const TugasScreen(),
          '/materi': (context) => const MateriScreen(),
        },
        theme: ThemeData(fontFamily: "Poppins"),
      );
    });
  }
}
