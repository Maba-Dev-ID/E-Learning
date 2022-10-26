import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/user_provider.dart';
import 'package:flutter_application_1/screens/home_screen.dart';
import 'package:flutter_application_1/screens/login_screen.dart';
import 'package:flutter_application_1/screens/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => UserProvider()),
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
          '/': (context) => const LoginScreen(),
          '/login': (context) => const LoginScreen(),
          '/home': (context) => const HomeScreen(),
        },
        theme: ThemeData(fontFamily: "Poppins"),
      );
    });
  }
}
