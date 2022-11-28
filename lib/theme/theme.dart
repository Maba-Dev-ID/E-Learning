import 'package:flutter/material.dart';

const kGreenPrimary = Color(0xff256D85);
const kGreen = Color(0xff06283D);
const kWhiteBg = Color(0xffF7F6FB);
const kwhite = Color.fromARGB(255, 201, 201, 201);
const kWhiteText = Color.fromARGB(255, 150, 150, 150);

ThemeData lightTheme = ThemeData(
  primaryColorLight: Colors.black,
  primaryColorDark: Colors.white,
  fontFamily: "Poppins",
  scaffoldBackgroundColor: kWhiteBg,
  primaryColor: kGreenPrimary,
  textTheme: const TextTheme(
    headline1: TextStyle(
        fontSize: 28, fontWeight: FontWeight.w800, color: Colors.black),
    headline2: TextStyle(
        fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
    headline3: TextStyle(
        fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
    subtitle1: TextStyle(fontSize: 12, color: kWhiteText),
  ),
);

ThemeData darkTheme = ThemeData(
    primaryColorLight: kGreen,
    primaryColorDark: kwhite,
    textTheme: const TextTheme(
      headline1:
          TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: kwhite),
      headline2:
          TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: kwhite),
      headline3:
          TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: kwhite),
      subtitle1: TextStyle(fontSize: 12, color: kwhite),
    ),
    fontFamily: "Poppins",
    scaffoldBackgroundColor: Colors.black87,
    primaryColor: kGreen);
