import 'dart:async';

import 'package:e_learning/providers/theme_providers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../services/storaged.dart';
import '../theme/theme.dart';

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
    var theme = Provider.of<ThemeProvider>(context);
    theme.getCurrentTheme();
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: theme.themeMode == ThemeMode.dark
                      ? const AssetImage("assets/images/bg_dark.png")
                      : const AssetImage("assets/images/bg.png"),
                  fit: BoxFit.cover)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "E-learning",
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(fontSize: 40),
              ),
              Text("Layanan Digitalisasi Sekolah",
                  style: Theme.of(context).textTheme.headline3),
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
