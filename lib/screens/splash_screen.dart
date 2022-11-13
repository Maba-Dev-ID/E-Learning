import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/storaged.dart';
import 'package:flutter_application_1/utils/theme.dart';
import 'package:lottie/lottie.dart';

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
    print(token);
    if (token != null) {
      isLogin = true;
    }
  }

  @override
  void initState() {
    token();
    Timer(const Duration(seconds: 2), () {
      Timer(const Duration(seconds: 2), () {
        !isLogin
            ? Navigator.pushNamedAndRemoveUntil(
                context, '/login', (route) => false)
            : Navigator.pushNamedAndRemoveUntil(
                context, '/home', (route) => false);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/bg.png"),
                  fit: BoxFit.cover)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "E-learning",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.w700),
              ),
              const Text(
                "Layanan Digitalisasi Sekolah",
                style: TextStyle(fontSize: 16, color: Color(0xFF06283D)),
              ),
              Container(
                  margin: EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: MediaQuery.of(context).size.width / 3),
                  child: const LinearProgressIndicator(
                    color: kGreenPrimary,
                    backgroundColor: kWhiteBg,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
