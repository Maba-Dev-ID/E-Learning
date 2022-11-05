import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/storaged.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var storage = SecureStorage();
  var isLogin = false;

  token() async {
    String? token = await storage.read('token');
    if (token != null) {
      isLogin = true;
    }
  }

  @override
  void initState() {
    token();
    Timer(const Duration(seconds: 2), () {
      !isLogin
          ? Navigator.pushNamedAndRemoveUntil(
              context, '/login', (route) => false)
          : Navigator.pushNamedAndRemoveUntil(
              context, '/home', (route) => false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Elearning ITG",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
            ),
            Text(
              "Layanan Digitalisasi Sekolah",
              style: TextStyle(fontSize: 12, color: Color(0xFF06283D)),
            ),
          ],
        ),
      ),
    );
  }
}
