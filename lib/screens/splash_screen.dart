import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // @override
  
  // void initState() {
  //   Timer(Duration(seconds: 2), () {
  //     Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Text("Elearning ITG", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
            Text("Layanan Digitalisasi Sekolah", style: TextStyle(fontSize: 10, color: Color(0xFF06283D)),),
          ],
        ),
      ),
    );
  }
}
